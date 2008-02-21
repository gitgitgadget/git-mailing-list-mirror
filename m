From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merge git repositories
Date: Thu, 21 Feb 2008 14:58:23 +0100
Message-ID: <20080221145823.019b8b7e@pc09.procura.nl>
References: <20080220175901.71e7acc2@pc09.procura.nl>
	<47BD7DEC.7040708@brefemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: t2a2e9z8ncbs9qg@brefemail.com
X-From: git-owner@vger.kernel.org Thu Feb 21 14:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSBx8-0007tC-PC
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 14:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbYBUN63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 08:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYBUN63
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 08:58:29 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:2858 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYBUN62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 08:58:28 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1LDwOei034086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 14:58:24 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <47BD7DEC.7040708@brefemail.com>
X-Mailer: Claws Mail 3.3.0cvs18 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74616>

On Thu, 21 Feb 2008 14:34:36 +0100, Jerome Lovy
<t2a2e9z8ncbs9qg@brefemail.com> wrote:

> Hello,
>=20
> On 02/20/2008 05:59 PM, H.Merijn Brand wrote:
> > I have a whole bunch of git repositories that are conversions from =
SCCS.
> > SCCS is a VCS that only deals with a single directory, and cannot c=
ope
> > with directory hierarchies.
> [SNIP]
>=20
> > is it possible to merge git repos from sub-folders into the current=
 repo?
>=20
> Doesn't maybe the subtree merge strategy help ?
> See=20
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-sub=
tree.html

Does seem to fit the need.

> My 2 cents

Probably worth much more! Thanks.

> J=C3=A9r=C3=B4me

--=20
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/=
)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11=
,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.or=
g
http://mirrors.develooper.com/hpux/            http://www.test-smoke.or=
g
                        http://www.goldmark.org/jeff/stupid-disclaimers=
/
