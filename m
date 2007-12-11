From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 13:57:42 +0100
Message-ID: <20071211135742.62d1d641@pc09.procura.nl>
References: <20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl>
	<47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
	<7vve7e49or.fsf@gitster.siamese.dyndns.org>
	<20071210145123.7c34af6d@pc09.procura.nl>
	<7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
	<20071211085440.GK14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, arjen@yaph.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:59:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24hQ-0003AN-5K
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbXLKM6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbXLKM6h
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:58:37 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:3921 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXLKM6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:58:36 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBBCvgSA078035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 13:57:47 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20071211085440.GK14735@spearce.org>
X-Mailer: Claws Mail 3.1.0cvs70 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67849>

On Tue, 11 Dec 2007 03:54:40 -0500, "Shawn O. Pearce" <spearce@spearce.org>
wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> > 
> > > 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
> > >   at least does not conform to the expectations in the GNU world,
> > >   but chickening out like the way strbuf_addf () does is maybe a
> > >   bit too rude, so I forced a minimum of 64bytes available. That
> > >   fixes a lot!
> > >
> > >   but it still breaks t4013 :(
> > 
> > I think Shawn had something similar for Solaris, and if it is a small
> > cost to help portability, it does not feel so bad.
> 
> My Solaris change is already in your tree; on Solaris vnsprintf
> will return -1 if the input buffer we gave it had a length of 0.
> This can happen at odd times, depending on what is already in the
> strbuf and how its buffer is. :)
> 
> The fix for Solaris turned out to be just make sure there is at
> least 1 byte in the buffer before calling vsnprintf().
>  
> > > + git-index-pack -o tmp.idx test-2-7f8ead892057e78576c0329a70cc83afb113f117.pack
> > > fatal: serious inflate inconsistency
> > 
> > That sounds like a broken zlib X-<.

libz is version 1.2.3

> I think this is actually a broken pread().  Its been reported
> multiple times by different people on HP-UX.  Compiling with
> NO_PREAD=1 resolves the issues for everyone who has tried it.

:)

* passed all 114 test(s)

> Jakub asked me for an autoconf test to look for this sort of
> breakage in pread(), I have yet to come up with a theory for
> what sort of breakage HP-UX is showing us here, let alone write
> a test for it.

For now, the HP section in Makefile for 11.00 now looks like

ifeq ($(uname_S),HP-UX)
	# HP-UX
	BASIC_LDFLAGS  += -L/usr/local/ssl/lib -L/usr/local/lib
#	EXTLIBS        += -lc_r -lgcc
	NO_HSTRERROR	= YesPlease
	NO_ICONV	= YesPlease
	NO_INET_NTOP	= YesPlease
	NO_INET_PTON	= YesPlease
	NO_UNSETENV	= YesPlease
	NO_STRTOULL	= YesPlease
	NO_STRTOUMAX	= YesPlease
	NO_PREAD	= YesPlease
endif


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
