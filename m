From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Sun, 25 Nov 2007 20:28:37 -0500
Message-ID: <20071126012837.GA5402@dervierte>
References: <200711252248.27904.jnareb@gmail.com> <20071125222314.GC21121@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwSmu-0000Ey-US
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 02:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbXKZB2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 20:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758613AbXKZB2n
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 20:28:43 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:5313 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565AbXKZB2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 20:28:41 -0500
Received: by an-out-0708.google.com with SMTP id d31so77620and
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=bLeOZdZ8e8xFbJfr2Aa0Gd3PWEZZ6yKhSAcV3r1sMCc=;
        b=QI+d76oHutu35ERV2YShkLsbI8VRGU1mLQIaj5Qv4hjubqbUyTIZK3zA3DPAeiNp12Xxwr96JBqJfPScseBnEv4Q0cZk9YZST/hBQaW3k4GDE2FdoGswD40KaNROaIVwhUTaoDXqszfjcBzq9Nb0KFuXvYqLk9f5y0Oj8tnMO2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RL5R4YYQnqpUhfZlWoChri5VoFNqvDec/1lc5ugGbxg9Y1HylvrfKJX5Pm4spcxvO9SRSV7qySlbrLUKGHiTQ032MKOXyHEqAAPNiGxjU3nBeuFx1HlghyjaUq3W+45/gewwWT7CCtDT9KNwCmmX+Cq7DDwjqDI+nEusGqwwdSg=
Received: by 10.100.225.19 with SMTP id x19mr2851779ang.1196040521002;
        Sun, 25 Nov 2007 17:28:41 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 14sm1654259wrl.2007.11.25.17.28.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2007 17:28:40 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id DA557D52C4C; Sun, 25 Nov 2007 20:28:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071125222314.GC21121@artemis.corp>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66034>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 11:23:14PM +0100, Pierre Habouzit wrote:
> On Sun, Nov 25, 2007 at 09:48:27PM +0000, Jakub Narebski wrote:
> > If you would write git from scratch now, from the beginning, without=20
> > concerns for backwards compatibility, what would you change, or what=20
> > would you want to have changed?
>=20
>   * reset/checkout/revert. The commands to wonderful things, but this UI
>     is a mess for the newcomer.

Heartily seconded.  I think checkout is the most egregrious of the
three.  git-checkout can be used to:

    * Switch branches
    * Create a branch
    * Change the state of all files to a particular commit
    * Change the state of a particular file to that of the index
    * Change the state of a particular file (and index) to a particular
      commit

To makes things more complicated, several of these tasks can be done
with other commands.  Short of rewriting git from scratch, what can be
done to simplify the many-to-many mapping of tasks to commands?
--=20
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 =3D 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSiFF/IGXd9wono8RApZqAJwKciH+SXH8FzsKkJMtsKDdptnqmwCdGhIQ
Rxoo/qC+0CpXbBsjIFDovec=
=onlX
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
