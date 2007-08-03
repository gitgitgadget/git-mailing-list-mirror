From: "Mike Pape" <dotzenlabs@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 14:33:52 -0400
Message-ID: <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
	 <Pine.LNX.4.64.0708031334530.14781@racer.site>
	 <46B328EA.4030309@trolltech.com>
	 <Pine.LNX.4.64.0708031411360.14781@racer.site>
	 <46B32C8D.4060804@trolltech.com>
	 <Pine.LNX.4.64.0708031434130.14781@racer.site>
	 <46B34B0D.6030106@trolltech.com>
	 <Pine.LNX.4.64.0708031649480.14781@racer.site>
	 <46B36B7F.8010008@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH1yG-0008Un-Q4
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 20:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbXHCSdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 14:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbXHCSdx
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 14:33:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:26118 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbXHCSdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 14:33:52 -0400
Received: by wr-out-0506.google.com with SMTP id 36so342011wra
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 11:33:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lhdopGB0kcloPlFc4d3a4G6R9j/VLNDS49cN0b/ZKvPV3zL21yWrkeaHUXdt1YdiP3GU4AroSmxMBWeRM8ZD+/ItANEJt6Hq7y6b5sfASwbAYfZaWIxMbCiCs037GXTZtjOwnuh+zOtmeVL5zEl5lA+EiNS9lOwtPYVSJeDVA2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5gJzafZgmaF+8lrp8fJ/Wqt7pUP6t77ZS/XCsBGmtCLVgDAkBaq7uueIEOJ7NIKnZPg/BGjhn7ansEwdJgcwnsnwxbRi41JAXdGP40+4ziF5BIZWF5EbEL/EviO4YN/G80Yb7l6vJwWQV5Kf0Hc8QWMA9ednCB5XsPc/TLLNPk=
Received: by 10.90.113.18 with SMTP id l18mr3453360agc.1186166032127;
        Fri, 03 Aug 2007 11:33:52 -0700 (PDT)
Received: by 10.90.55.17 with HTTP; Fri, 3 Aug 2007 11:33:52 -0700 (PDT)
In-Reply-To: <46B36B7F.8010008@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54739>

> >> 3) When "Setting up git" the second time, it feels like the whole thing
> >> is hanging; have let it run for ~5min now without anything happening.
> >> Not sure what's going on here. It looks like git.exe was ran with any
> >> options, but that should not consume 100% CPU.. Hmm
> >
> > Yep.  I did not test the initial phase, and there is a serious bug in
> > setup_git_directory_gently() in origin/devel.  I fixed that.
>
> Yup, work now.

Works for me as well now.  One catch is that at work, I'm behind a
firewall so git:// doesn't work for me.  I have a packaged version
that adds curl and expat, enables them in the build, and then falls
back to http:// if git:// fails in /etc/profile.  Is that something
you'd want up on code.google.com?
