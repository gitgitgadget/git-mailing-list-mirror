From: "Mike Pape" <dotzenlabs@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 15:13:32 -0400
Message-ID: <fd2562310708031213sabc4599m79166f52e78edde3@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B32C8D.4060804@trolltech.com>
	 <Pine.LNX.4.64.0708031434130.14781@racer.site>
	 <46B34B0D.6030106@trolltech.com>
	 <Pine.LNX.4.64.0708031649480.14781@racer.site>
	 <46B36B7F.8010008@trolltech.com>
	 <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
	 <46B3764E.6090106@trolltech.com>
	 <Pine.LNX.4.64.0708031954480.14781@racer.site>
	 <46B37B09.1030808@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH2ag-0004Dr-Nj
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 21:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbXHCTNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 15:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756450AbXHCTNe
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 15:13:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:39106 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbXHCTNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 15:13:33 -0400
Received: by wr-out-0506.google.com with SMTP id 36so347382wra
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 12:13:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P/PWUQjJX2gObqTopVqDvJBSJMo3wHOuvZp2eA47VnbriiwJbsPSWlfjxl41LOYEcZWuKQked40bm8ctqNEIh3AnJ4aHm1tKjSxyD5NjBmVRg0mmofdoy1BR8EnoU9fuQl1NYQ7EYOKp+0dsp/c/d0v2/2i/3oyADL6Kl0OkKOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bYw4lI/XcOprW0UECMS5vYLATi3ohpO2Za8BeAc2oPmpUJqWGqwZWG0jCrlA7Xgn1URGatP5VtCeTBAp1UyaTy83BbXGvqd8d95Fl2YTrsLZCvAYY7ArLKmi5YDjiNa0sr0gFR73wEUNtNIp1Sq/QhreCDp0KInOcO6FEFFlWmA=
Received: by 10.90.90.3 with SMTP id n3mr3519183agb.1186168412343;
        Fri, 03 Aug 2007 12:13:32 -0700 (PDT)
Received: by 10.90.55.17 with HTTP; Fri, 3 Aug 2007 12:13:32 -0700 (PDT)
In-Reply-To: <46B37B09.1030808@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54745>

On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Johannes Schindelin wrote:
> > On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:
> >> Mike Pape wrote:
> >>> Works for me as well now.  One catch is that at work, I'm behind
> >>> a firewall so git:// doesn't work for me.  I have a packaged
> >>> version that adds curl and expat, enables them in the build, and
> >>> then falls back to http:// if git:// fails in /etc/profile.  Is
> >>> that something you'd want up on code.google.com?
> >> Ooo, I'd like your built curl and expat libs in a zip, pretty
> >> please! :-)
> >>
> >> Then we can add it to the package. The more complete MinGW port,
> >> the better. Do you have anywhere you can put out such a zip, so I
> >> can get ahold of it? You can mail me privately, if you'd like.
> >
> > I already installed curl, didn't I?
>
> Ah, yes, you did.
> However, we don't use it, due to Makefile's
>         NO_CURL=YesPlease
> for MINGW builds.
>

Was it in the latest version (0.2)?  I didn't see it there.  Either
way, I had to make a couple changes to the Makefile to get it to work
and also add expat (unless I somehow missed that too).  Marius, do you
still want a zipped copy or do you have it already?
