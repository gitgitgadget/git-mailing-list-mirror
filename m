From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Tue, 08 Jan 2013 10:59:32 -0500
Message-ID: <20130108155932.GB4662@odin.tremily.us>
References: <20130108143214.GA3755@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:00:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsbat-000409-HF
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 17:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab3AHP7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 10:59:38 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:65168 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab3AHP7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 10:59:36 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB001UVDR8JH80@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 09:59:33 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 99C2677F2B8; Tue,
 08 Jan 2013 10:59:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357660772; bh=iX8ZJY6/YxriVWuK4uC/SGVSmxnvPSJoDYGTjnuo+Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PgS8gxjaItJ+utbDF8shVd6N+7CgiG82kCM0sUZvAoBYfH52Nw5K6rBVo3CmJHQZS
 zM09AkQ4TY8AayjedU/2PHE2sYcV44h/+7CqA5XLXxFPZO+W4JCEeo1oKkO//yDWAm
 6ua15la6m351HsCRx9Ng1C1wlQphWRt0Rtv/cPJg=
Content-disposition: inline
In-reply-to: <20130108143214.GA3755@odin.tremily.us>
 <20121023220955.GA30442@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212971>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2013 at 09:32:14AM -0500, W. Trevor King wrote:
> Thinking about this a bit more, I'm not clear on how out-of-tree
> updates (i.e. worktree in .git/modules/*/config) propogated during
> branch checkouts (merges, rebases, etc.).

Actually, I don't understand why storing `worktree` in
=2Egit/modules/*/config is useful at all=E2=80=A6.  This may be related to =
my
lack of clarity on the "why can't we have multiple working directories
checked out at the same time" issue:

On Tue, Oct 23, 2012 at 06:09:55PM -0400, W. Trevor King wrote:
> On Tue, Oct 23, 2012 at 10:57:57PM +0200, Jens Lehmann wrote:
> > Am 22.10.2012 14:37, schrieb W. Trevor King:
> > > but cloning a remote repository (vs. checking out a local branch)
> > > seems to be baked into the submodule implementation.  Should I be
> > > thinking about generalizing git-submodule.sh, or am I looking under
> > > the wrong rock?  My ideal syntax would be something like
> > >=20
> > >   $ git submodule add -b c --local dir-for-c/
> >=20
> > But then we'd have to be able to have two (or more) work trees using
> > the same git directory, which current submodule code can't.
>=20
> And that's the problem I'm trying to solve ;).

Can someone with a better feeling for why this won't work.  Is is just
that there's only one `.git/HEAD`?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7EJiAAoJEEUbTsx0l5OMLW4P/3gYMkG89m/huDM0YTJIvEju
2TyNXmaodWmvqLY8yZnGtiylUaRC+wbKPDLtEmOFTsvQCwCMq9W7aXI7CQfLcW0P
WCxm1UZ1YSWhi55ZBgf00wE39QbP6GJyaiy3oeofPwaPhOdeL4LLPEBfGnARxy8a
ukDFXJK5Ih28tBgzUHgw0ns9CVT3CYM+FwCTU9OT96rQx4iKT2XX06rNriCicECu
obGm8XHkX5tA33Eg2BBZABsLizjKi2NECIsQJ5BUdkTGkbTlT0QWSjn7F75fvDb1
XlZJiEywBl4PBuYgOVCgou0EWxgdYVfZypE785VXNIhVafeRv+I2m3jRSoBkXpYs
ItqKPwXiLj5WdgF63zcj69nfO5m3MBaeS3nDjCWkegF08qQEqCpvFpMQrEA/BOkg
ybEulqXbQdmcJjhPfKga8SkVjbES0/cSVG8FNTiU7/suxeweXItnxHG8hqfuQ/Su
0ExDeHQX9AqL/zKp7XWHqqqcUlfoG+4+Hd5du1i7PhVcUnOq+Zq56yRPwIR764BE
HU2Fa26OAkjo9zaiPcHsOBweF3as9Ns2SU8ynaOYe1HhXw5nvA1G7Vdz1YgsG+YW
C77rKujT3/LeH+t2Vesdvpgx1emSPtPYU1V/3604Vk8bAN9fO3EA4heZe3xu60zW
/glLJsWXTYUT1hcPNIo4
=Ju88
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
