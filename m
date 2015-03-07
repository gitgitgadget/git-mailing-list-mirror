From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Please consider adding a -f switch to git-clone (or something
 similar)
Date: Sat, 7 Mar 2015 22:53:14 +0000
Message-ID: <20150307225314.GC742348@vauxhall.crustytoothpaste.net>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
 <87d24kzbor.fsf@igel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Cc: Diego Viola <diego.viola@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 23:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUNb4-0003Ty-FB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 23:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbbCGWxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 17:53:22 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49814 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060AbbCGWxV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 17:53:21 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:295b:e478:8994:8469])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 771B22808F;
	Sat,  7 Mar 2015 22:53:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Diego Viola <diego.viola@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87d24kzbor.fsf@igel.home>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265007>


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 11:26:28PM +0100, Andreas Schwab wrote:
>Diego Viola <diego.viola@gmail.com> writes:
>
>> I know I could git-init in a empty directory
>
>You can also git init a non-empty directory.

I have a script to set up a new throwaway VM with my dotfiles using git.
It looks a bit like the following ($BRANCH !=3D master):

  SSH=3D"ssh $DEST"
 =20
  $SSH "cd; $GIT init"
  git push --receive-pack=3D$GIT-receive-pack $DEST:~/.git $BRANCH
  $SSH "
      $GIT pull . $BRANCH
      $GIT submodule update --init
  "

It relies on the ability to git init a non-empty directory.  $BRANCH can=20
be master if you use the new updateInstead functionality in git 2.3.0,=20
and you can use git pull from a remote location instead of the push/pull=20
pair if that suits you better.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+4FaAAoJEL9TXYEfUvaLKZkP/1EbFDUglzGa702uxpcc5WtI
VStKdvCA8ufvt8OpFJWyYlgI7ZML+i8B28BwcKOzuOzr/LJ9I0LSAbVoaNglm0hY
N8ZcUWZcYzC9UxytAqZuPEGGiFilfd63yduPqIDuVT43GWyZUjlG2DhcxUABna30
srP/xAJO2sWGZ60I8KvZJKvaVelYeTokCpEUieignIW1x8YPRYz64qbc9ux8xrOK
sM9n6L8Euhat4uMCUV0/o76fiV/93jyr70qbp/pV+EKVKv0FS9EpWcrsO65f+kVX
zPO2QcrFpe2TOpdEh2EcFd1E6Ih6BRVs4rlSq62Ji4CNI8BB9EaWuPqTein33AZL
TZDXJPcX7JXyXQjZY1BmymTRxnqe2t0CE/q5kQ87JcOj0pKnKw7k0Nx38SpZdicQ
0iLBhUy1awEB+Z+7bkDp8yRh/Pp6+/koN5cBf84/ZgA3MBJTxUVL5OzRr3AfvXsZ
utau+j8EkYzWFid3Dv3+HLUjI9Wc6cZSXo5ScKynVtdWTLN213QN/Vp89lS4TO+t
kLQ0HrAv7dqeFSbtv3ONZJv869lBX5K47AJ+21psg0vrysB4pgTUMrk0VYIoTzAH
KLDQr4RxGu1PVFN5ULqiXgr8vMYD6qBzT5R+rVy9IqEaCiJj4Q00XBwA7F9gtVqW
zIc1rcthFL1fXanqpl93
=ivPj
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
