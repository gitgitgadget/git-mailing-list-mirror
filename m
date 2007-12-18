From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 08:11:45 +0100
Message-ID: <20071218081145.18e17f85@pc09.procura.nl>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
	<20071217232259.0b41a3bf@pc09.procura.nl>
	<7vbq8o370k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 08:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Wdi-0007tc-Lw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 08:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762393AbXLRHM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 02:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763220AbXLRHMz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 02:12:55 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4510 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765659AbXLRHMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 02:12:54 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBI7Blth056858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 08:11:48 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vbq8o370k.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68704>

On Mon, 17 Dec 2007 21:29:31 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > On Mon, 17 Dec 2007 13:00:22 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> >> 
> >> > HP-UX does not have select.h, but it offers all select () functionality.
> >> > The defines are in <sys/types.h> and <X11/fd.h>
> >> 
> >> Will apply the patch as-is for now, only because I do not want major
> >> surgery during rc period, but I think is can be improved.
> > ...
> >> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
> >
> > That is defined in GNU gcc. I did not pass it with -D...
> 
> Actually I changed my mind.  I won't be applying this as is.
> 
> For the selective inclusion of <sys/select.h>, I would prefer it see it
> done like the attached.

So do I

> The main point is to limit the "platform" dependency to configure and
> Makefile, and keep #ifdef in the actual header files expressed in more
> generic terms (e.g. "do we need to (and can we) include sys/select.h
> here?").
> 
> I am fuzzy about the uname_S part, so I won't be applying the attached
> patch either; the attached is for demonstration purposes only.
> 
> diff --git a/Makefile b/Makefile
> index 617e5f5..f9f724a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -100,6 +100,9 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> +# Define NO_SYS_SELECT_H if your C library header files do not have <sys/select.h>
> +# but you do have select(2) (pre POSIX.1-2001 systems, e.g. HP-UX before 11.23).
> +#
>  # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
>  # that tells runtime paths to dynamic libraries;
>  # "-Wl,-rpath=/path/lib" is used instead.
> @@ -504,6 +507,9 @@ endif
>  ifneq (,$(findstring arm,$(uname_M)))
>  	ARM_SHA1 = YesPlease
>  endif
> +ifeq ($(uname_S),HP-UX)
> +	NO_SYS_SELECT_H = YesPlease
> +endif

# uname -s
HP-UX
# uname -r
B.11.00
#


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
