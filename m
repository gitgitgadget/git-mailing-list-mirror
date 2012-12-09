From: "Matthew Ciancio" <matthew.ciancio16@gmail.com>
Subject: RE: Feature Request - Hide ignored files before checkout
Date: Mon, 10 Dec 2012 09:37:39 +1100
Message-ID: <000301cdd65d$ce311c40$6a9354c0$@gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com> <CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com> <7vhanvegvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Chris Rorvick'" <chris@rorvick.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 23:38:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThpVc-0007xk-Ai
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 23:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934575Ab2LIWhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 17:37:48 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56131 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab2LIWhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 17:37:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1455853pbc.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 14:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        bh=kqP7X8bbo+lXlVvH3Ixa7T+3BbWVLRmci8njahjIjA4=;
        b=WTgZq7SK7qhrIomP+2Q2mt2O5vNKR3dRQsis6BUTsQDJM6z7sJiPZCKse8f8lMeDIU
         EO5OP7cO0lSz8xaXiDWZEbFRf6qNacJ6Pil2dcjc6rciplJ3wP8/KdIxafnOhGPBZzCh
         divCxFZkpqQwnhFtpx8c9ibbGVpz9qrJOn2Hs0D1Aop+HrnpKR8/4jbH5P6NX7rkFJCI
         0ZBXir5FPT3e+hF3Tueec+y3jXmkFoLNnFFsG7Jcy6eSdh2mUAx9+Utse5ntpZogjMZG
         uaCa5KBee4ujVq21Flk0wjyyBQ13tLx1XBb1Lmn66F3tD/K9puEaGtxYo8QZcsQg6wtP
         2+aA==
Received: by 10.68.143.129 with SMTP id se1mr34404871pbb.67.1355092666813;
        Sun, 09 Dec 2012 14:37:46 -0800 (PST)
Received: from MattPC (CPE-60-225-40-254.nsw.bigpond.net.au. [60.225.40.254])
        by mx.google.com with ESMTPS id p10sm10666557pax.27.2012.12.09.14.37.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 14:37:45 -0800 (PST)
In-Reply-To: <7vhanvegvu.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHMNWi7KxtTHnq09qgMXBkE3T5YpgFvr262AhNbdVKX+C9PwA==
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211243>

I appreciate your involvement, Mr Hamano.

You have made me realise that my intentions were flawed from the beginning,
because I had been misusing the branch feature.

Thank you for your time.

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Sunday, 9 December 2012 8:04 PM
To: Chris Rorvick
Cc: Matthew Ciancio; git@vger.kernel.org
Subject: Re: Feature Request - Hide ignored files before checkout

Chris Rorvick <chris@rorvick.com> writes:

> It's not in branchA, it's just no longer ignored because your changes 
> to .gitignore were effectively reverted by jumping back to the commit 
> that branchA points to.
> ...
> "hide/reappear" is the equivalent to saying "deleted/created" in the 
> case of a tracked file in your working tree.  But how would Git cause 
> an untracked file to reappear?  By definition, it doesn't know 
> anything about the file.

Nicely explained. To make something simply disappear, you could remove it,
but that is obviously not enough to make it reappear.  It has to be stashed
away somewhere before it gets removed, and in the context of (any) SCM, that
is done by committing.

You may have Mac and Windows branches, each of which needs to link with
vendor supplied object file blackbox.o with the rest of the source.  It is
understandable if a project does not want to mix such platform specific
black box binaries in the history of the source.

But that does not necessarily mean the project can totally ignore what
specific black box binary was meant to be used with the rest of the source.

After you released the v1.0 of your product for both Macintosh and Windows,
the vendor may supply updated versions of the blackbox.o binary for these
platforms, and you would start working toward v1.1 of your product using
these updated copies of objects.  Then you find problems in the released
v1.0 software.  Without keeping track of which version of the object was
used to build the released v1.0, you cannot diagnose, build and test a
maintenance update v1.0.1.

The project may add new Macintosh (or Windows) developers.  You can tell new
Macintosh developers to clone and checkout mac branch, and in the same
e-mail, give them the untracked blackbox.o file for that platform, but you
have to rely on human not making mistakes (you may mistakenly send Windows
version of blackbox.o to him, you may send stale Macintosh version, the
developer may misplace the new one and keep using the stale one, etc. etc.).

Some people commit blackbox.o on each platform-specific branch, or all
branches share blackbox-win.o and blackbox-mac.o, only one of which is used
at any given branch, for this exact reason.

The project, for licensing reasons, may not have rights to distribute such a
blackbox object file along with its sources, but the vendor of the blackbox
object may allow individual developer to download and link it from vendor's
site.  In such a case, the project would not want to (and is not allowed to)
commit such object file.  One approach I have seen used in such a case is to
arrange the build procedure so that these individual developers can drop
such an external object next to the project directory, and refer to it as
../blackbox.o when linking.

So "these files are moved away from the working tree upon checking another
branch out, and moved back into the working tree upon checking out this
branch" is pretty much outside the scope of any SCM.  It is not very
interesting, as it is not necessary to solve any real world problem.

Of course, the users can do whatever moving/copying/renaming of untracked
files in their post-checkout hook to be run when a new branch is checked
out.
