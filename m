From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] Fix overridable written with an extra 'e'
Date: Thu, 27 Aug 2009 23:43:05 -0400
Message-ID: <20090828034305.GQ4297@inocybe.localdomain>
References: <20090828121849.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="VousOZe2B5HJrJZY"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 05:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgsNU-0000nL-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 05:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbZH1DnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 23:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbZH1DnN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 23:43:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZH1DnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 23:43:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4DB01B697;
	Thu, 27 Aug 2009 23:43:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=1Dg1f7Z33+eSVeCmZlGRqKb3XIk=; b=Apw0c6D
	Kb5AvRkbMr6ZT9vTZr2LDmhP1YZ/pV32OdRWvptc0hZh2gviMuJKwl6TooyLjTGZ
	JSLqrQHgAGd6iEi1DLRnUuuUolGrTZ1y1UEsOqRxiuboo3Ig5IF/o7Uj0JLaqSnq
	osbfi+DPspKaUpBltPgCfr6pgCNVhjZx+axo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=BUA900IuUvkS0FxG31MTCB7TaR3kdYtf3
	Y3WwzwwhzlWy6op805gAtVJoY8b3HP8F2csnd+xmCAxgHNn+SBlqdG+OXP/itN1L
	twMzB/S9LeHCgtimqpbhhjIi6mXuHGMKQDIUzI92hwzbmoiJ5oh9aCHY7sOnnape
	usvxCTTaYg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 950CB1B696;
	Thu, 27 Aug 2009 23:43:10 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.9.179]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D43A1B694; Thu, 27 Aug
 2009 23:43:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090828121849.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: E80D31CC-9384-11DE-90E1-CA0F1FFB4A78-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127251>


--VousOZe2B5HJrJZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nanako Shiraishi wrote:
> Found during the lunch break by one of my students...

Is overridable a word itself?  While English is my native language, I
wouldn't call myself an expert on its proper usage. ;)

However, I can't find 'overridable' in several online dictionaries:

http://dictionary.reference.com/browse/overridable
http://www.merriam-webster.com/dictionary/overridable
http://www.google.com/dictionary?aq=3Df&langpair=3Den|en&q=3Doverridable&hl=
=3Den
http://dictionary.cambridge.org/results.asp?searchword=3Doverridable&x=3D0&=
y=3D0

Perhaps using overridden would be more accurate?

>  	Prune loose objects older than date (default is 2 weeks ago,
> -	overrideable by the config variable `gc.pruneExpire`).  This
> +	overridable by the config variable `gc.pruneExpire`).  This
>  	option is on by default.

 	Prune loose objects older than date (default is 2 weeks ago,
-	overrideable by the config variable `gc.pruneExpire`).  This
+	which can be overridden by the config variable `gc.pruneExpire`).  This
 	option is on by default.

> -		warn "feature $name is not overrideable";
> +		warn "feature $name is not overridable";

and

-		warn "feature $name is not overrideable";
+		warn "feature $name cannot be overridden";

?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I got stopped by a cop the other day.  He said, "Why'd you run that
stop sign?"  I said, "Because I don't believe everything I read."
    -- Stephen Wright


--VousOZe2B5HJrJZY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKl1JDJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjR/MH/A5kSVUNj5YqG98Q10dt4ZXmSYFffE3NhFBg
GOrcOxxB/FOcB3z8hUShs0Go2cNKsLJJOxZktRfniotycMO1YqFCYJ0r4bCiP1KN
KHD8aaQYwfelWLMyWKmL4Lzdpi5AmIywx+NbonIdxNhHX2LWP8HyxOEKz5zQbiw7
fPkts0GqD2m3KOHergBhtXNudFPno4xWfAv+deEz3lPL55pd0u94iY4G8zAChzFU
XXPVL8k13alfHV6FLoNtNROv0s/DgEPic8bYXwnP69bpGWVJmaEXSUpUUBS2fHfI
eDxkSKNv0fuaiL7xb7f6nv6HxbLHegql3ObLaG5orvyewPcIRG4=
=0+1H
-----END PGP SIGNATURE-----

--VousOZe2B5HJrJZY--
