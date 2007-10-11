From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 10:11:41 -0300
Message-ID: <f329bf540710110611j7ea39cfdx416b43b902fcc9e4@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
	 <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
	 <Pine.LNX.4.64.0710111145090.4174@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 15:12:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfxpW-0003aP-Hs
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 15:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbXJKNLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbXJKNLo
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 09:11:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:55545 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbXJKNLn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 09:11:43 -0400
Received: by ug-out-1314.google.com with SMTP id z38so440862ugc
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8Qxs51vYnoK7wRxGydbGEgRlQbUD+DPVupysP1UY/+o=;
        b=EoIAfT3zEtr9Igs90j+EnqJatm61G0k2nXmSXW4yFUxg5p4WnVOaZqA7mglt1hdb4zot9ruAoMQTa6eqw+bwrFvpYTpPuJcirN2+/FIzznPI+zn2/3+IZSEnJXyAJnfhf1+TshL5Y4T59pQ4TlDbXZZ8TL/B5DBee21g6IHDimY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eqNw6tDa8rJtt9Tjr0sQoZZBtCy5dz6gSv3CbUGqtFocHxMCEVzdqWU0sa2fMmk2ap16D/K4itw9MhV0Pcyq9KczNvJpo9pX2XC3r4bWAi2QYxYfglyr9j7L/8AO+F3aoQbdB6RTe7PoPUhT1tG28nlzY98UBrKpHR72p46Bqrk=
Received: by 10.78.175.14 with SMTP id x14mr1419802hue.1192108301757;
        Thu, 11 Oct 2007 06:11:41 -0700 (PDT)
Received: by 10.78.41.4 with HTTP; Thu, 11 Oct 2007 06:11:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710111145090.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60594>

2007/10/11, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > For cherrypicking convenience, I would still appreciate it if there was
> > a mechanism similar to alternates that would allow me to view objects
> > from an alternate repo; objects found through this mechanism should
> > never be assumed to be present in the database, of course.
>
> Silly question: why don't you just
>
>         git remote add -f other <url>
>
> and then review the changes with "git log", "git diff" and "git show"?

Thank for the tip; I'll look into it.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
