From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 15:44:36 -0400
Message-ID: <20121023194436.GD28592@odin.tremily.us>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
 <5086ED06.5020406@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=UfEAyuTBtIjiZzX6
Cc: git@vger.kernel.org
To: Nahor <nahor.j+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 22:45:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlLo-0008MJ-P3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784Ab2JWUpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 16:45:09 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:43978 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804Ab2JWUpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:45:04 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2012 16:45:04 EDT
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD00JH62UD6940@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 14:44:38 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EFFBB67E9EE; Tue,
 23 Oct 2012 15:44:36 -0400 (EDT)
Content-disposition: inline
In-reply-to: <5086ED06.5020406@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208246>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 12:16:22PM -0700, Nahor wrote:
> On 2012-10-22 09:34, W. Trevor King wrote:
> For instance, the module may later be updated to a commit in branch B=20
> instead of branch A. Unless you remember to also update .gitmodule, you=
=20
> have then inconsistent information.

But you're explicitly *using* the configured setting in

  git config --file $toplevel/.gitmodules submodule.$name.branch

That should be a reminder that the configuration is important, and
you'll remember to change it.  Plus, the text from git-pull should
clearly display the branch you are pulling, which gives you a second
change to notice if something is going wrong.

> A similar issue arises if branch A is deleted from the module later (for=
=20
> instance because it has been merged in the master branch and is not=20
> useful anymore). Then .gitmodule points to a non-existant branch.
> Same thing if a branch is renamed.

All of these are possible, and all would reqire manual intervention to
pick out a new branch to follow.  Plus, this patch is not even about
the auto-pull application, it's about storing the initially cloned
branch name.  What you do with that name afterwards is up to you ;).

> I think a better place to store that kind of information is using=20
> git-notes. That way, if the branch is renamed or deleted, you can easily=
=20
> update the old notes to use the new name instead.

Interesting.  What would you attach the note too?

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhvOjAAoJEEUbTsx0l5OMB5AP/1Qfp3qvBYKOfnCd7FLI6wz5
WMRON3PMhFBA/f4oi/l7Nve3+vp2Ww4R9iDw6EthRxD1Ru8p0RfnbLlnvkF77Z1Q
44227GFt5Y9R5EQ7v/+VCWYCBa4V/lkMttFVnjFH6iFOm9tmnJ8bh+ZKVcUJYAL4
O20QZ/96cq+jotB7hq0jOKpp6RIqkbawlRqh0oZkIAlW2Tw+gy6LIEp53w+BoBuK
hWsFBmlg19BOoO2BvHqNMM0F71+Yg9+vQWVxS1iChAG+jqxXn/o9tamNCHP844G6
SKO5MadDHLVYbkkOrYxnFWLCCNjymhMNcT2k7H4JQlmBQwIh0mX37NHxM21+ILa+
vLu/uO7S7e5pDp4vKYxg9PeYNvhSNmMfgzt3OwHICM3A4yHvOn3oDQhoCmrLvJ0N
gWIHVf9igfwkUyxEjo6CN9m2lXcBT9sp4yMRvfJIbME/Coo2HXvDG47FvclLTa3F
niOJoPx/QYbmqBBgiwRStt8TtqJqDJeIvIEAAP4F1+50ip+NCIOU8B+ZBXX7dxhq
IyXBoSqPCFcWmwKrgkZ0wKw4MMAvPjGF8MxAhWvvg+79bCz88CGj8fnKZhq5FP9R
4JylwwIj8EcejpxK1fl2HTudEdN85wc6zoQlxglWuOkfIFmBdhQ/t09t6TNa97hU
K+XX7azM0q367NkWQc3p
=A9FG
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
