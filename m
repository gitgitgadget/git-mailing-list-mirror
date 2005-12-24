From: "Rob McDonald" <robm@asdl.gatech.edu>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 08:51:53 -0500
Message-ID: <009701c60891$50893fd0$6900a8c0@sps>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 14:49:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq9m5-0003w4-22
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 14:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLXNt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 08:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVLXNt0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 08:49:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:39368 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750708AbVLXNtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 08:49:25 -0500
Received: from sps (c-24-98-112-64.hsd1.ga.comcast.net[24.98.112.64])
          by comcast.net (rwcrmhc13) with SMTP
          id <20051224134924015004rtkne>; Sat, 24 Dec 2005 13:49:25 +0000
To: "Andreas Ericsson" <ae@op5.se>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14025>

> The worst trouble you're likely to run into is all the hardcoded paths.
> They are everywhere and ofcourse use the / for path entity separation.
>
> The fact that there are 39 bash'ish shell-scripts does little to help a
> native port, and although they can be fairly easily replaced by "real"
> programs it still means quite a bit of work with little real value for
> the unix-version, so I'm guessing you'll have to write those up for
> yourself.

MSYS is a minimal system that includes ports of all build-chain tools you
need to get Makefiles to work.  I would envision using it along with native
ports of Perl, Tk/Tcl, etc.

> Is there some reason you can't install Cygwin, which effectively
> overcomes both those problems?

I've had consistently lousy luck with Cygwin which has left a bad taste in
my mouth.  Cygwin is generally a lot slower than Mingw, although that is
most noticeable when you're making extensive use of math.h.  Also, it seems
that every time I install some package in Cygwin, something else I've
installed gets messed up.  It just seems to me that there isn't any reason
for an efficient command-line tool like git to depend on a large
unmaintained project like Cygwin.

Of course, one could use -mno-cygwin (or whatever it is) to use the MinGW
headers when compiling in Cygwin as an intermediate step.  That would give
any speed advantages.

However, I've had great luck porting Linux apps using the gcc toolchain to
Windows using MinGW.  All these programs 'just worked'.  However, none of
them really did things outside the realm of simple, portable C and Fortran.
Most of them have been old engineering analysis codes which have been ported
a dozen times in their life anyway.

Thanks for the comments.  The best idea may be to just try it....

            Rob
