From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: query regarding git merge
Date: Sun, 13 Dec 2015 19:23:17 +0000
Message-ID: <20151213192316.GM990758@vauxhall.crustytoothpaste.net>
References: <loom.20151213T185500-631@post.gmane.org>
 <20151213181800.GK990758@vauxhall.crustytoothpaste.net>
 <CAGkBSDLMCZR=qrXJKTgpzGGQdogXHN+0Ub8qW=aPq80RjjN=5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Cc: git@vger.kernel.org
To: Rohit Gupta <roborohitgupta75@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CFS-0003nW-AK
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbLMTXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:23:22 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44932 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbbLMTXW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 14:23:22 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ECA5C282CA;
	Sun, 13 Dec 2015 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450034599;
	bh=lAahBl1WuaIZzT1GjaAydwJzQ5yz0nE5OXocuKfaAWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vD0/2BILIYvHUPMhohQCmGqAsUfRzdrnALU8F/3CKLQ95FRYuyIm26JojXGOdwvHL
	 bNQvdRG3KndKJLZce6+j//2/7iRBJRMA7WusYGzjy4Pl1dlBEKWWkRVUOGSsnsSfWt
	 RbhQaWIxEbWDsTb8AxxaBzCVWuvC/0IHK7fj/NjB9FF1SlIGBvxCEJ6K6YB7sf98aZ
	 nJDy663MOYGcmP+YWEh+VOFIMqXZxv7qnzNdniC50cq45/qOKcCwWRvxf6/xm9YXJH
	 +VmfpUQaBFyt4aIaJX6keLpeKIBzFj9nQBRDghMk0ObIuW3ZTFpzU68VS3GtIGrHhY
	 BgIvvaGgIu45Si4pPlU3JoVcmI5PvIWvSK9WY5vIyObz2zXmg0+hvXLFbOEtmA5NTo
	 /jeHse6YPm9r7E0seXfsKR4LsazW7rnubfnAgTVt3WN4aY0A+96P51yc4UJCjWdwPs
	 aQ4n5d29VUM6ZTHD+Fc6wHalhcHoyTyxjtyUywPzubX0rHRqYd6
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Rohit Gupta <roborohitgupta75@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAGkBSDLMCZR=qrXJKTgpzGGQdogXHN+0Ub8qW=aPq80RjjN=5w@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282343>


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please don't top-post.]

On Mon, Dec 14, 2015 at 12:03:18AM +0530, Rohit Gupta wrote:
> Thanks brian. I understood my mistake in understanding the working of git
> merge.
> But isn't it wrong? As after merging, branch's logic can't work. How to g=
et
> that right then ?

If you know that the merge didn't go the way you wanted, you can either
add a follow-up commit, or you can do "git commit --amend" on the merge
after making the necessary changes.  In such a case, it may be useful to
add a note to the commit message stating that you modified it from the
original merge.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWbcWkAAoJEL9TXYEfUvaLRxUQAI8/cnFX7HajqfoIKYhw5FB0
QXKjodWfXBnp4F6Db4dd1Cl8MrpwTVz2WY+r2jHiZaHBdvf2XRnfZZC3+6/8os1C
z7dObVXlS4xlIUw/7xaO88fov28pCCkuJZz2PnaNT0ehbiDqa4BaA8aTtXx87Cs2
6kSdR5yTyPmZjOeh2AyjFDUdhGTFLi1g+dWnXcEFLjn7lF0wcIJpqao1JVUGYcrb
bbURAsmmbwmvZLl6pNiyZtQVReZqdIrrdR9Zefet+UQrBR7+mgv+cAX03aOrMLUc
vHx9d90cN1kuhsR0hGEuzjRsOnjKiYsnPoKadQBXg7k3jV4xfRpcLY4NryEK0LC9
uyrILYytznCnjXYmlp1hlLI+vu7uF1d+mYJPY4R/Lqwc1YkikuFKyiRjhRn8Ds2R
CchauPXMM+Gn683UnDA8ievVWV8SdR8ZZiMdNjBC3WdYXtkGPliXgMW8yAPD/UBM
RJF6XdelAamB2ui7E/TuHGdbvG1jGRz6hKOq0guAXHGIitFa8B2NT7K4v3ATO7tN
Q3j4xzb/o49SuEEBAelk6hAsVm+I0MInb6MvRETEj96s5BAARYFAJm/SSNQDdwxY
DTaNruZeJ+3Z5XXjv2nK8DLXJJKVXQ0JZ3HuE67jDEzGYlJP2zvo/q7OZPFn1NjV
BK2yGQVuPreOK062ejrP
=DRzE
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--
