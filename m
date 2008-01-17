From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 19:21:54 +0100
Message-ID: <20080117192154.5634c62d@pc09.procura.nl>
References: <20080117141143.38a88c7a@pc09.procura.nl>
	<alpine.LSU.1.00.0801171655570.5731@racer.site>
	<20080117185514.621525a6@pc09.procura.nl>
	<alpine.LSU.1.00.0801171811480.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZO0-0003j5-QQ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbYAQSWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbYAQSWO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:22:14 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:1532 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYAQSWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:22:13 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id m0HILsXm098463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 19:21:55 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <alpine.LSU.1.00.0801171811480.5731@racer.site>
X-Mailer: Claws Mail 3.2.0cvs27 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70892>

On Thu, 17 Jan 2008 18:14:00 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Thu, 17 Jan 2008, H.Merijn Brand wrote:
> 
> > On Thu, 17 Jan 2008 16:58:36 +0000 (GMT), Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > On Thu, 17 Jan 2008, H.Merijn Brand wrote:
> > > 
> > > > * Have to force use of /usr/local/bin/perl, otherwise it picks up 
> > > > /usr/bin/perl which the build system doesn't like.
> > > 
> > > This should be handled in your patch to Makefile IMHO.
> > 
> > You mean this: ?
> > --8<---
> > --- Makefile.orig       2007-12-17 07:03:21 +0100
> > +++ Makefile    2007-12-17 18:04:37 +0100
> > @@ -401,6 +401,19 @@ EXTLIBS =
> >  # because maintaining the nesting to match is a pain.  If
> >  # we had "elif" things would have been much nicer...
> > 
> > +ifeq ($(uname_S),HP-UX)
> > +       # HP-UX
> > +       BASIC_LDFLAGS  += -L/usr/local/ssl/lib -L/usr/local/lib
> > +#      EXTLIBS        += -lc_r -lgcc
> > +       NO_HSTRERROR    = YesPlease
> > +       NO_ICONV        = YesPlease
> > +       NO_INET_NTOP    = YesPlease
> > +       NO_INET_PTON    = YesPlease
> > +       NO_UNSETENV     = YesPlease
> > +       NO_STRTOULL     = YesPlease
> > +       NO_STRTOUMAX    = YesPlease
> > +       NO_PREAD        = YesPlease
> > +endif
> 
> Almost:
> 
> +	PERL_PATH = /usr/local/bin/perl

Yep, should work

> > -->8---
> > 
> > Note that this was on HP-UX 11.00/32. A 64bit env on 11.23/64 IPF will be
> > different.
> > 
> > I had no problem with my perl, as I specifically told that on the configure
> > line:
> > 
> > $ ./configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl
> 
> I guess that my suggestion doesn't work... Your perl is not in 
> /usr/local/bin...

This was *my* CONF, not Richard's!

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
