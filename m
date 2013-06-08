From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Sat, 8 Jun 2013 02:35:12 +0200
Message-ID: <20130608003512.GF31625@goldbirke>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
 <CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:35:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul784-0002mD-LH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab3FHAfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:35:14 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:56842 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3FHAfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 20:35:13 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M731J-1UQXTR0y3h-00wmru; Sat, 08 Jun 2013 02:35:12 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:wCrvJXpjyRRSERJhcgcGLN0M8MOA4Q7T+VEBl/bCJie
 2ladPd/u0dXNfQXdCoA7cMUbIer1SSMdOMqAJoA9FfmNj7bY9s
 cWHI2ZOn1kqjgqbFlgo2+Wx7aat47nQMU1Sxv7tS0to+v4b8EF
 VgKiG30VO0vR3wj+3Y0nfyW1Ef6tLgAF6SZsp5Hip86vXdpWMD
 TLJJi9NJsfGnXo5lb4/JRjFKWuUKhwShRnFT9zvfzHMdvxxogA
 Q0sICzK08eC/nY0aqpjDELL45xyEjcgmY+QSTUmubiQnsF3t/F
 kKZRBuuVtUbeSkyoVW6xxURxCBl7RPEBmCc6ePV76LiK4nm1qg
 ZxJprWlZTV83yssf5hBv+R9rj7ikC3F2clSXb/YMF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226772>

On Fri, Jun 07, 2013 at 02:25:54PM -0500, Felipe Contreras wrote:
> On Fri, Jun 7, 2013 at 2:09 PM, Ramkumar Ramachandra <artagnon@gmail.=
com> wrote:
> > 77c130 (completion: clarify ls-tree, archive, show completion,
> > 2013-06-02) removed __git_complete_file () because it had no caller=
s
> > left in the file.  However, to avoid breaking user scripts that may
> > depend on this, add it back as a deprecated alias.
>=20
> This is fine by me, but at some point we need to decide how we should
> prefix the functions that are supposed to be used by external scripts=
=2E

Or rather how we should prefix the functions that are _not_ supposed
to be used by external scripts.  That way all public functions would
retain the "__git" prefix and existing scripts calling only common
functions like __git_(heads|git_refs|find_on_cmdline|etc.) would work
without modification.


Best,
G=E1bor
