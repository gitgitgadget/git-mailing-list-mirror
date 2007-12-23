From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Sun, 23 Dec 2007 09:59:22 +0100
Message-ID: <20071223095922.55067db5@pc09.procura.nl>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
	<4767934F.7070706@op5.se>
	<7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
	<20071218114949.711ba447@pc09.procura.nl>
	<7vr6hiv4ny.fsf@gitster.siamese.dyndns.org>
	<20071219211226.41920430@pc09.procura.nl>
	<7vzlw6tlpt.fsf@gitster.siamese.dyndns.org>
	<20071220081806.0ccdf636@pc09.procura.nl>
	<20071223083708.GA3563@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Dec 23 10:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Mhc-0007UG-3t
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 10:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXLWI76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 03:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXLWI76
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 03:59:58 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1185 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbXLWI75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 03:59:57 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBN8xOnq043503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Dec 2007 09:59:24 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20071223083708.GA3563@efreet.light.src>
X-Mailer: Claws Mail 3.2.0cvs12 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69170>

On Sun, 23 Dec 2007 09:37:08 +0100, Jan Hudec <bulb@ucw.cz> wrote:

> On Thu, Dec 20, 2007 at 08:18:06 +0100, H.Merijn Brand wrote:
> > On Wed, 19 Dec 2007 13:31:58 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > > "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> > > > On Wed, 19 Dec 2007 11:57:21 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > > >> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> > > >> > On Tue, 18 Dec 2007 01:47:53 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > > >> > ...
> > > >> >> Merijn, discarding the earlier patch I did to configure it out for
> > > >> >> HP-UX, does the following patch based on Andreas's idea work for you?
> > > >> >
> > > >> > Probably not:
> > > >> >
> > > >> > HP-UX 10.20, 11.00, 11.11, 11.23/PA, and 11.23/IPF all have:
> > > >> >
> > > >> > /usr/include 103 > grep -r POSIX_VERSION *
> > > >> > sys/unistd.h:#    define _POSIX_VERSION _POSIX1_VERSION_88
> > > >> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_90
> > > >> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_93
> 
> Please, note that the defines are _POSIX1_VERSION_*
>                                         ^

Ow. good catch. Sorry, yes, missed that.

> > > >> > sys/unistd.h:#  define _SC_1_VERSION_88    7     /* _POSIX_VERSION: Date of POSIX.1-1988 */
> > > >> > sys/unistd.h:#  define _SC_1_VERSION_90   102 /* _POSIX_VERSION: Date of POSIX.1-1990 */
> > > >> > sys/unistd.h:#  define _SC_1_VERSION_93   103 /* _POSIX_VERSION: Date of POSIX.1b-1993 */
> > > >> > sys/unistd.h:#  if (_POSIX_VERSION == _POSIX1_VERSION_88)
> > > >> > sys/unistd.h:#    if (_POSIX_VERSION == _POSIX1_VERSION_90)
> > > >> >
> > > >> > and the two 11.23 do have select.h
> > [...]
> > 
> > If it is used to *define* _POSIX_VERSION, it should have come up too,
> > wouldn't it?
> > 
> > The only define that comes close to something like YYYYMM is:
> 
> No, it's not the only one. The _POSIX1_VERSION_* macros we are looking for
> are there below and they are defined this way too (did you miss them because
> of the trailing comment?)

No, because of the trailing _88, _90, and _93

> > X11/Xosdefs.h:#define X_POSIX_C_SOURCE 199300L
> > 
> > usr/include 111 > grep -r POSIX.*YEAR .
> > Exit 1
> > 
> > /usr/include 112 > grep -P -r 'POSIX.*\b(19\d\d|200\d)' .
> > ./sys/buf.h:#if         (_POSIX_C_SOURCE >= 199309)
> > ./sys/buf.h:#endif      /* (_POSIX_C_SOURCE >= 199309) */
> > ./sys/stdsyms.h:/* XPG3 semantics gets POSIX.1-1988 semantics by default */
> > ./sys/stdsyms.h: * This usage is obsolescent, "-D_POSIX_C_SOURCE=199506" is preferred */
> > ./sys/stdsyms.h:#  if (_POSIX_C_SOURCE >= 199506) && !defined(_INCLUDE_POSIX1C_SOURCE)
> > ./sys/stdsyms.h:#  endif /* _POSIX_C_SOURCE >= 199506 && !_INCLUDE_POSIX1C_SOURCE */
> > ./sys/stdsyms.h:#  if (_POSIX_C_SOURCE >= 199506) && !defined(_REENTRANT)
> > ./sys/stdsyms.h:#  endif /* _POSIX_C_SOURCE >= 199506 && !_REENTRANT */
> > ./sys/stdsyms.h:#  if (_POSIX_C_SOURCE >= 199309) && !defined(_INCLUDE_POSIX4_SOURCE)
> > ./sys/stdsyms.h:#  endif /* _POSIX_C_SOURCE >= 199309 && !_INCLUDE_POSIX4_SOURCE */
> > ./sys/unistd.h:#  define _POSIX1_VERSION_88     198808L    /* We support POSIX.1-1988 */
> > ./sys/unistd.h:#  define _POSIX1_VERSION_90     199009L    /* We support POSIX.1-1990 */
> > ./sys/unistd.h:#  define _POSIX1_VERSION_93     199309L    /* We support POSIX.1b-1993 */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> And they are defined HERE.
> 
> Obviously, there is no value for the 2001 standard, so if this is from HP-UX
> version that already has sys/select.h, it does not claim conformance to the
> posix standard. But than it might be that sys/select.h is not required, so
> the test might still work.

Good explanation

> > ./sys/unistd.h:#    if !defined(_POSIX_C_SOURCE) || (_POSIX_C_SOURCE < 199309L)
> > ./sys/unistd.h:#    else /* _POSIX_C_SOURCE && _POSIX_C_SOURCE >= 199309L */
> > ./sys/unistd.h:#    endif /* _POSIX_C_SOURCE && _POSIX_C_SOURCE >= 199309L */
> > ./sys/unistd.h:/* Symbolic constants for sysconf() variables defined by POSIX.1-1988: 0-7 */
> > ./sys/unistd.h:#  define _SC_1_VERSION_88    7   /* _POSIX_VERSION: Date of POSIX.1-1988 */
> > ./sys/unistd.h:/* Symbolic constants for sysconf() variables added by POSIX.1-1990: 100-199 */
> > ./sys/unistd.h:#  define _SC_1_VERSION_90   102 /* _POSIX_VERSION: Date of POSIX.1-1990 */
> > ./sys/unistd.h:#  define _SC_1_VERSION_93   103 /* _POSIX_VERSION: Date of POSIX.1b-1993 */
> > ./sys/unistd.h:#  define _POSIX2_VERSION   199209L  /* IEEE POSIX.2-1992 base standard */
> > ./sys/unistd.h:#  define _POSIX2_C_VERSION 199209L  /* IEEE POSIX.2-1992 C language binding */
> > ./limits.h:#  define _POSIX_CLOCKRES_MIN        20000000 /* The CLOCK_REALTIME clock
> > ./X11/Xosdefs.h:#define X_POSIX_C_SOURCE 199300L
> > ./dce/cdsclerk.h:#if _POSIX_C_SOURCE >= 199506L
> > ./dce/rpcexc.h:#if _POSIX_C_SOURCE >= 199506L
> > ./dce/stubbase.h:#if _POSIX_C_SOURCE >= 199506L

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
