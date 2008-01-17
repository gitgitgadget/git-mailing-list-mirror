From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 15:32:53 -0700
Message-ID: <a5eb9c330801171432p4e3600a1x91f088bcafdb876d@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080116183124.GA3181@steel.home>
	 <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>
	 <20080116191737.GD3181@steel.home>
	 <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>
	 <20080116234527.GA3499@steel.home>
	 <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
	 <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
	 <a5eb9c330801171213l2c06c4e4s718324f5b66f0db6@mail.gmail.com>
	 <alpine.LFD.1.00.0801171218470.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFdIt-0005Dy-0K
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 23:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388AbYAQWc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 17:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757711AbYAQWcz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 17:32:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:14512 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667AbYAQWcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 17:32:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1334335wah.23
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 14:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=65jazrdW6n0JXnYxXaqR8sphqPip2npspz4JM6KTrZc=;
        b=O14/3Po1w7dbIMmHjmjkH8HqNl17U3hKFxri8rw6nBXV/aoU1z5EqIanct8nZLi5CT1SrT3VC5c/hitpxiIZJc2cpOimkygyBaLu2EucUXyaJJMgQFh7g2f9N6l5ys2NuwqiS/TDsBaE+ljrgFJ2mHTUcfrUOlOPjFR5jCUY/4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=roKleIjHJCAZqr9dYO7AIKOCdeGGNcDLycg3ww1jpgQituWJZCWy+IfsEm7dqy7Dvko5Va1WLa+aYiz/RzdQpnUjTHoQH3RJ17zKatIW/uJQqc3ypko/q6AmDsr51quDZXYJ+2Kerp4WgH44ZZMkQtJfflbXHDLCsPzqPwsXp7k=
Received: by 10.114.109.1 with SMTP id h1mr3029620wac.45.1200609173951;
        Thu, 17 Jan 2008 14:32:53 -0800 (PST)
Received: by 10.114.133.7 with HTTP; Thu, 17 Jan 2008 14:32:53 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801171218470.14959@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70934>

Yup. That looks like it - dontcha just gotta love the way some vendors
abuse the Windows OS.

I think I'll give msysgit a try, failing that I can always disable the
Embassy Suite (since it seems it's only needed for the fingerprint
reader which I don't use anyways).

Guys, thanks for all your help - you've been terrific.

Paul

On Jan 17, 2008 1:24 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 17 Jan 2008, Paul Umbers wrote:
> >
> > Quite possibly. We have Embassy Trust Suite and Symantec Endpoint
> > Security installed
>
> That's it.
>
> Do a google for
>
>         Embassy Trust Suite cygwin
>
> and revel in all the reports of problems with cygwin with that thing
> installed.
>
> See for example Dave Korn at:
>
>         http://www.cygwin.com/ml/cygwin/2007-05/msg00132.html
>
> or this on:
>
>         http://www.cygwin.com/ml/cygwin-talk/2007-q1/msg00270.html
>         http://sourceware.org/ml/cygwin/2006-05/msg00856.html
>
> so I'm pretty sure that's it.
>
> Ahh, the joys of Windows.
>
> Btw, did you ever test the msys version of git
>
>         http://code.google.com/p/msysgit/
>
> since I suspect that it's likely to not just be faster, but also more
> robust, since there is a much thinner layer between git and windows (and
> thus hopefully many fewer complex dependencies that can go wrong).
>
>                         Linus
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com
