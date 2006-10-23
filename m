From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-cherry should show "+" instead of "-" and vice versa
Date: Mon, 23 Oct 2006 21:22:10 +0100
Message-ID: <200610232122.17268.andyparkins@gmail.com>
References: <200610232003.08861.andyparkins@gmail.com> <20061023193326.GS20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1226891.VFH5bCT3WI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 22:24:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6Lt-0005h7-QN
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWJWUYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWJWUYv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:24:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:18043 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750928AbWJWUYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 16:24:50 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1499169uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 13:24:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=SbGE1oiC5JBTfxxfNqpHhIpgm3NyxhQFixV43eJNF5aVJHYbvUf588Br/QbJ/m5HKKwoh0RRHi4hmB6dH5V4AiijgKh7piZQhtQfNYUf2Y6xBMnPwEGnzIILr045/VseIvjMTjMyNWKec/gzABee3b+gx8F15+0cI6ZV1MZvjU4=
Received: by 10.78.127.3 with SMTP id z3mr536303huc;
        Mon, 23 Oct 2006 13:24:47 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 36sm1502430huc.2006.10.23.13.24.47;
        Mon, 23 Oct 2006 13:24:47 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061023193326.GS20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29874>

--nextPart1226891.VFH5bCT3WI
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2006, October 23 20:33, Petr Baudis wrote:

> Did the documentation ever get fixed or noone cared enough? ;-)

My patch makes git-cherry match the documentation.

Personally I think that the documentation is correct.  git-cherry is, to me=
,=20
terribly useful.  I've got a few patches in my own branch and it's very=20
useful to be able to check to see if those emailed patches have been accept=
ed=20
upstream with a simple

git-cherry -v upstream

Which makes it natural to see
 "-" =3D patch not in upstream
 "+" =3D patch in upstream

I read the thread you pointed at, and didn't really understand what the dow=
ner=20
on git-cherry was, or why the patch wasn't accepted.  Have I misunderstood=
=20
something?



Andy
=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart1226891.VFH5bCT3WI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPSR5wQJ9gE9xL20RAvCBAKDLFMDZ2VMrEswVItOHIM9VrQhWFACg213i
6xSqMBs4MYwolxXbOmhinbQ=
=d5yo
-----END PGP SIGNATURE-----

--nextPart1226891.VFH5bCT3WI--
