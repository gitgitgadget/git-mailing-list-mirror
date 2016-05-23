From: Joey Hess <id@joeyh.name>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Mon, 23 May 2016 13:29:51 -0400
Message-ID: <20160523172951.GA1184@kitenet.net>
References: <20160517171836.GA12183@kitenet.net>
 <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
 <20160517182645.GA27396@kitenet.net>
 <20160522190404.GA20998@kitenet.net>
 <xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:30:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4tg0-000364-Fj
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbcEWR34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 13:29:56 -0400
Received: from kitenet.net ([66.228.36.95]:53496 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbcEWR3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 13:29:55 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Wz6AGONp;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1464024591; bh=irzFDBoyj9Gwy+qLorTgqym2WX6H82OZEw/U+EkQOTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wz6AGONpJ+6gXtuOpSU2nY32d/y6/6qL1WVcLBR1ijbmIg+b/nejfDXCtAieVFUMp
	 sMvUHtuJlxvv8I4h5vcouRNV0KCjPAefqRFAXMbhrL3Mw+wHuffSMXwizI/A6u68LN
	 5/Ose05xHeTuEw6EWWSi7k/bLVun78ivtypzsMtc=
Content-Disposition: inline
In-Reply-To: <xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-98.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RDNS_DYNAMIC,SPF_SOFTFAIL,
	URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295340>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Joey Hess <id@joeyh.name> writes:
>=20
> > This seems to make it basically impossible for any program that wants to
> > use GIT_INDEX_FILE to use anything other than an absolute path;
> > there are too many configurations to keep straight that could change how
> > git interprets what should be a simple relative path to a file.
>=20
> Thanks for digging.  Perhaps this needs to be documented (not "in
> this case it is take as relative to that, in this other case, ...",
> but "you cannot rely on relative being relative to something you
> think").

Documenting it that way feels like =C2=AF\_(=E3=83=84)_/=C2=AF
I feel it should be made consistently relative to top of work tree.

Seems fairly unlikely that any scripts driving git rely on it
being relative to the pwd when GIT_WORK_TREE etc is set.

(I'd prefer relative to pwd because that is much more sane IMHO, but
making that change is more likely to break something.)

--=20
see shy jo

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV0M+D8kQ2SIlEuPHAQJYaA/9F8OQy8hmVXuT3gX8LvLr88fw4KCPZY3X
bqjZ+kdWgsxpw6E+oioro7JF7q1rW5stTdwf7Yn8MKoDmnFrQA475NlD1bZbJ3/E
nCeHi2MmOxnCty46jVg3tYVkpmAemWOP8lO2KX03nlQzPGB0pERkCWobCE0qjHl1
urDIX7V4dC3UE7RhmZLPTe1tFHzmVsbL93GEn6GduRIeqcnLHoxnPN2d4vpbbfgn
hEFxHbCz1QDTX3rvpelKBpK8+0DAya7Z7hb7gQsvqmvik16UfvrAwsp3gmRO1SXk
7vE7gelD9JoTgtL08mp+2E+zTQR6CwoD58t0ZgoTpyxkY3joa0gQe9bB1kHjwhQk
K+yXfDVPRI89kk9QlR7Xqz3pnWtq50+3xoWI9invQKFlzyxItHg6jyamLc6Gi2Bt
TBgXDg5myxzGJzXAcA46sXubaxPS165jQieK63RIV9ObLAU87geV1MPBvpvYRvao
214MdP4kfPRX7p35L2zikCdANFpGoYcim5Uw8JC1wJt/A/lOorxrlyCny449pkwV
1qK3ijjUuaXXSnQeMlfYbC1w6rggC2VJwN2m3pbq/9ZFPhSwZZ3MLjZHye203HTH
DAC+bhjMurjiaXspL0mzAuEbBGUcjB0EvEhjVZXYB2t9X7J8iErX3yHC/Qh08Th0
MUpUVYo7fwc=
=y+Bo
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
