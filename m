From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 07:39:08 -0700
Message-ID: <1144075148.2303.100.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <20060403140348.GE16823@harddisk-recovery.com> <e0rb0j$ml9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/PqxZApCcWgHF57sj5VW"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 16:39:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQDR-0008IS-9B
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWDCOjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWDCOjf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:39:35 -0400
Received: from home.keithp.com ([63.227.221.253]:33295 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751627AbWDCOje (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:39:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 1EE1F13001F;
	Mon,  3 Apr 2006 07:39:33 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29766-02; Mon, 3 Apr 2006 07:39:32 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id A916913001E; Mon,  3 Apr 2006 07:39:32 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8288314002;
	Mon,  3 Apr 2006 07:39:32 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 009DB54386; Mon,  3 Apr 2006 07:39:08 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e0rb0j$ml9$1@sea.gmane.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18336>


--=-/PqxZApCcWgHF57sj5VW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-03 at 16:21 +0200, Jakub Narebski wrote:

> From the comments on #git, parsecvs reads raw ,v files for creating histo=
ry
> tree, then uses 'cvs co ...' for getting the contents.

It's not using cvs co, it's using the rcs 'co' command. I will probably
fix it to just generate the files directly as that will be a lot faster.
If there was a git command to create blobs directly from file contents,
it would be faster still as I could create all of the blobs for a
particular file in one pass and then just build trees in the index out
of those.

--=20
keith.packard@intel.com

--=-/PqxZApCcWgHF57sj5VW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMTOMQp8BWwlsTdMRAjjKAKCh/RXbRm6EHkY2SNFo12XhTTbsvwCaAmrp
OXr1lKHX0b/LNdu5EW3m5OQ=
=NoWK
-----END PGP SIGNATURE-----

--=-/PqxZApCcWgHF57sj5VW--
