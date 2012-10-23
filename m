From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 16:55:24 -0400
Message-ID: <20121023205524.GF28592@odin.tremily.us>
References: <5086FFDC.2050700@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=HCdXmnRlPgeNBad2
Cc: Phil Hord <phil.hord@gmail.com>, Nahor <nahor.j+gmane@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQmRu-0006lf-3O
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 23:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab2JWVze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 17:55:34 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:28662 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2JWVzd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 17:55:33 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2012 17:55:33 EDT
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD009UC64CUE30@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 15:55:25 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2C5E167EAA6; Tue,
 23 Oct 2012 16:55:24 -0400 (EDT)
Content-disposition: inline
In-reply-to: <5086FFDC.2050700@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208257>


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 10:36:44PM +0200, Jens Lehmann wrote:
> Except recording the branch name might raise expectations about what git
> will do with it. And as far as this patch goes, git won't do anything
> with it (yet).

As Phil pointed out, doing anything with this variable is ambiguous:

On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
> Some projects now use the 'branch' config value to record the tracking
> branch for the submodule.  Some ascribe different meaning to the
> configuration if the value is given vs. undefined.  For example, see
> the Gerrit submodule-subscription mechanism.  This change will cause
> those workflows to behave differently than they do now.

On Tue, Oct 23, 2012 at 10:36:44PM +0200, Jens Lehmann wrote:
> But I'd rather see a patch series properly implementing the always-tip
> mode =C6var mentions in f030c96d86 (and which is requested by some users),
> especially the interesting parts: What should git record as commit in
> that case and how are "git status" and "git diff" going to handle
> submodules which shall follow a specific branch. I assume "git submodule
> update" is the right point in time to fetch that branch again and check
> out a newer branch tip if necessary, but should that commit be added to
> the superproject for that submodule automagically or not? This patch
> falls short of this, as it does the easy part but not the interesting
> ones ;-)

I agree that I'm not working on always-tip.  I'm just making that
easier.  For people that aren't interested in always-tip submodules
(e.g. Gerrit folks), this patch is still useful.  It would certainly
be possible to build an always-tip implementation on top of
submodule.$name.branch (as =C6var's one-liner does), but that would be
another patch series.

Personally, I think truly updates should be made explicitly, with a
hand written commit message about why the updates are occuring.  I
also think that setting up and running auto-updates should be easy
one-liners, not long, complicated ones ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhwQ5AAoJEEUbTsx0l5OMPHkP/iV95mfHROHhPPwFkM9UaUiv
cygCIipah+8JLYKqCnCeiKcaiNc74MSJNV3xFxgFxZNqfCdurJZxMYc3IRljBNs0
5Gklxve9aBmjs1b/tHky0g4tnvc47TbpfICROiN3hRciYNZYgoVYlU/K8Tji9W3A
gezhb4dfv0AlG4tpXBQbi8eYlgmyIct8qIgXpTUNsOl5+RsQMaEZVm4NHvskAtfB
mrg29Gss1DDep86/LDpdZqioDj8h6zyTWGit9Fi6yrlDDaxvQNAyx0wBC+XSE/wG
fewxVhl40aMNfVZ/IAJWm8s9zXVCkMThEcWvs6/oF003H9ctN8CWJ6w2pm7sDBY7
KTRicnftBnhMQrhflpEO895FPsIK9IQo+OylC9yTVjSc3kjaFztXueYvCRuWPrzf
EBepbQTbRbhZmjhL41ho9Pwcrr0X2N5Ue8lxvW5FzqFkFHZVy+1cqsYR/FNdCoR0
DCrY5lLJEI67sx+FLN+z6Q/yfnjw6ELQrl8huZePgJkVj69fc/B1J/rZoXT+laea
3Q26gaE46zEzFTieNK/9iGPmA/RnkkbybgBNGTyy+FASmM+lRpXTx1IWG0UcIke2
MBnxa4NeTlrAx0cJC3YfXXxxzPOV5JcrsFOFJcEZ9PK9dhxBFrgDuj5jk0EVsS5H
PeBadhPUNnPkDY80sWxb
=d2AA
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
