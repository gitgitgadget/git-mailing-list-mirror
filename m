From: Barry Warsaw <barry@python.org>
Subject: Re: Git's inconsistent command line options
Date: Mon, 31 Aug 2015 10:25:58 -0400
Organization: Damn Crazy Followers of the Horn
Message-ID: <20150831102558.1514e5f7@anarchist.wooz.org>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BZV=68/I9kydytLxZRuTgrh"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 17:05:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQe1-0006bZ-6O
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 17:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbbHaPFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 11:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:54699 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbHaPFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 11:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZWQdr-0006SJ-P5
	for git@vger.kernel.org; Mon, 31 Aug 2015 17:05:03 +0200
Received: from mail.wooz.org ([216.15.33.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 17:05:03 +0200
Received: from barry by mail.wooz.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 17:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: mail.wooz.org
X-Newsreader: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276882>

--Sig_/BZV=68/I9kydytLxZRuTgrh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Aug 31, 2015, at 05:10 PM, Duy Nguyen wrote:

>I'm probably shot down for this. But could we go with a clean plate
>and create a new command prefix (something like git-next, git2, or
>gt...)? We could then redesign the entire UI without worrying about
>backward compatibility. At some point we can start to deprecate "git"
>and encourage to use the new command prefix only. Of course somebody
>has to go over all the commands and options to propose some consistent
>UI, then more discussions and coding so it could likely follow the
>path of pack v4..

`git` itself could also be a thin wrapper which consulted a configuration
variable to see which version of the ui to expose.

"All problems in computer science can be solved by another level of
indirection"

Cheers,
-Barry


--Sig_/BZV=68/I9kydytLxZRuTgrh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJV5GP2AAoJEBJutWOnSwa/HaoQAJqCws4Cg3aZDJodeZc/zd3W
tWii3LmWB0uiOEyqWD1WKp0f4oBfLmHsm/G33eQVhd0PxieMTdTWH+kyQdkM0Ql6
wlSUbLCu5pCgt145SsMyweQZknow3KFEkppH1oodnS2u0t7Sk9Pa6wze3AvWppYX
gBVM9xf/RbAcdvCR3zDQb48/JeVF1aBs7Le9LBhK1KOcxZzkCyeDRVmaYGOxgdYI
IxEKPr9dYaQh6cn7UJiUFcySuW8PdglgyEuTOtCYvA/vtjKP96iUfhEcAb1GCvZI
MNn3CVZh2SLTgY2gtjk3u/mnZwlM4OBJlM29wyP9aCXEgTRdMGJaIcZg7K+1I0Ho
N8RhqgG4Cz3kiEUaZtodQfXaPsnaSjvreVr2Lx40qiTZjLFLHAVL8t97qOZivEch
Adfimw6AEutI8uY7Abyus0b0Qd/UoarKDKFHn4HuAzC8MJkPiGQRtkphXPBVw9VJ
8ohqvZe45+JR0/EcW5AWx/I/PSpWeh62CPQ7BxFgP2t7VkBQHmCW8DHYyWbleXB8
XZyJ+TvOX3LVKajIuKSt8wsMqpC2zj89t/cENrcBbDquvxXhdCGMAd+nNPG0rLj0
dKFhq5YSH9/BcAq4JK8hNAnfmK61UDxgJE5O9pjuGuZpdipRue2SIdXPs04ScuYu
uZJy23A7oEjaNcGzFOJ1
=crSf
-----END PGP SIGNATURE-----

--Sig_/BZV=68/I9kydytLxZRuTgrh--
