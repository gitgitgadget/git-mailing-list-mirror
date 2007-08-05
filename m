From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Sun, 5 Aug 2007 05:51:52 -0700
Message-ID: <26F4E92272F14115959CFA0C23809617@ntdev.corp.microsoft.com>
References: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com> <Pine.LNX.4.64.0708051252130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Mike Pape" <dotzenlabs@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Johannes Sixt" <J.Sixt@eudaptics.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfaV-00041z-OP
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbXHEMv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbXHEMv7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:51:59 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:27838 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbXHEMv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:51:58 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1472815qbe
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 05:51:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=EZLVLTDcq4R/9kfMhmwaKEHSVdQfNjnhPSlKwQNrhwWNSDbEUZ/e3rhgiof0OkPHbaC1ybfL+34YSbaDVQsqvm/Lgdn0iSK0b+NXJbuGXkuzmvS/3VOB0w9sZcgLjPnOKGU1/+ocoZTeJMm7FTNrrp3cI+S1e4v1I0ha/i8JxJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=XEpGwADlzLXDa2zdF3dflYrzeClqaexchkta2MvJNECEf+hIdjcIybxx6eIP4atjue5T4qZiD3As5SoueBBSSQiLJxABL32NI4yd1KcnbVHXfC8kHwscLmVkB5amQ4geq77OlZ8eHOL3IJ9TMDmgr6xe+Oae6mUEH1ky5VBU0bY=
Received: by 10.114.179.1 with SMTP id b1mr4692592waf.1186318316537;
        Sun, 05 Aug 2007 05:51:56 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j31sm5357730waf.2007.08.05.05.51.55
        (version=SSLv3 cipher=OTHER);
        Sun, 05 Aug 2007 05:51:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708051252130.14781@racer.site>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55011>

----- Original Message ----- 
From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>


> - How about calling your package msysGit-netInstall-<version>.exe?
No problem. Feel free to reupload it with a different name.

>   mingw.git as well...  Still, on dial-up, 40MB or 60MB makes a 
>   difference, no?
Sorry, I didn't have dialup for years so I don't take it into consideration.
Still 60MB is not that dialup unfriendly.

> - There is one big caveat with your bootstrapper: things have been known 
>  to break, and I think msysgit.git is no exception.  So I'd like to have 
>  a fallback in case things go awry, also to have something that is tested 
>  (for example, Mike tested msysGit-0.4.exe before releasing it).  Of 
>  course, we could solve that issue by branching off of the last release 
>  tag.
That, or better yet always maintain master branch in a working condition. Seriously.
If it (VERY rarely) breaks we'll just revert the offending checkin to bring it back in shape.
Where I come from, 'main' or 'master' should ALWAYS be functional.
 
> - AFAICT it is possible to make nicer installers with 7-Zip, and also 
I have no preference here. I just use what I know (WinRAR).
If you feel strongly about 7zip (which I can see you do for some reason :-) feel free to repackage it.

> - I wanted to hold off a little, until Hannes can apply the fix-up patch 
>  we need in mingw.git.  Because when he does, your bootstrap will run 
>  into problems...
Not sure why...

> It would 
> be nice to have insight in how you went about to identify what is needed?
Well, I've set path to a single directory (C:\GitMe\bin), copies over bash and git-clone
and started running it until it worked. Which happened surprisingly fast.

- Dmitry
