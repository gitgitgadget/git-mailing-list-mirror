From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 11:42:51 +0100
Message-ID: <20071211114251.78ae357a@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl>
	<47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
	<7vve7e49or.fsf@gitster.siamese.dyndns.org>
	<20071210145123.7c34af6d@pc09.procura.nl>
	<7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
	<475E5677.9090507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 11:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J22cW-0001ym-HJ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 11:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXLKKp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbXLKKp0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 05:45:26 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:3084 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbXLKKpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 05:45:25 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBBAgptA032285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 11:42:51 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <475E5677.9090507@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67836>

On Tue, 11 Dec 2007 10:20:55 +0100, Johannes Sixt <j.sixt@viscovery.net>
wrote:

> Junio C Hamano schrieb:
> > "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> >> 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
> >>   at least does not conform to the expectations in the GNU world,
> >>   but chickening out like the way strbuf_addf () does is maybe a
> >>   bit too rude, so I forced a minimum of 64bytes available. That
> >>   fixes a lot!
> >>
> >>   but it still breaks t4013 :(
> > 
> > I think Shawn had something similar for Solaris, and if it is a small
> > cost to help portability, it does not feel so bad.
> 
> Windows's vsnprintf() is broken in two regards: (1) It returns -1 if the
> buffer is too small; (2) the size parameter is not the size of the buffer,
> but the max. number of chars to write (i.e. does not count the NUL). How
> broken is HP-UX's?

Do you have a simple test program to show how `broken' it is?
I have 10.20, 11.00, 11.11, 11.23/PA and 11.23/IPF and both
HP C-ANSI-C and gcc

> Maybe we can share the implementation? See:
> 
> http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=5fd41ffacdef5454acbe51f5e23a97eb5158226d
> http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=e88aa8cbe816526bb0a7d37eaf2f5eb40ff36ae1

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
