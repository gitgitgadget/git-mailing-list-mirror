From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 23:55:28 -0400
Message-ID: <48AA4430.3060207@gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E69742F58FB2810FD7D9922"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 05:56:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVIKw-0007tX-CQ
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 05:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYHSDzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 23:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYHSDzr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 23:55:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:58318 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYHSDzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 23:55:46 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2377495wri.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 20:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=y0/v1i4zHmmJ8DnM78Os68uSIhNaWNu5/qh1RtUJgEg=;
        b=VMzuZnOqe0cTWG78sf0ywWW+mzXdIpVsIlWifekM8VvFJACUV+ea+SXAuNL0GWLyfF
         Q8d9iR3KyWOUTSYLr+CkUsPmDTMN16gOZGF/ERJi8oErfXUdW5WV5OKMSnxN8SjGdP5P
         VZE5bQzIk5iwnYm+otlmmZGGj+wij78sf1Bpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=YeK2zCALK6tb8DPQ5K0Pvtc/9wf1zb7d+ziU0qcNzQqUpCio3jYbRMe9YIArc5cISS
         i30NU7IR1t3JB++4OFh/Lrbf72YJ4y5CPmi9IiADlM/+UQeCjhokmMV/ZvpUspRnZa5A
         KIKyrQSMiV/gBU9Xnc/nPFmhkKlpwhEPnx3nM=
Received: by 10.90.33.5 with SMTP id g5mr8902209agg.81.1219118145468;
        Mon, 18 Aug 2008 20:55:45 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 38sm3242883aga.4.2008.08.18.20.55.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 20:55:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vy72tit90.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92810>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E69742F58FB2810FD7D9922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> This implements Daniel's idea to indicate what are compared by using
> prefix different from the traditional a/ and b/ in the textual diff
> header:
>=20
>     "git diff" compares the (i)ndex and the (w)ork tree;
>     "git diff HEAD" compares a (c)ommit and the (w)ork tree;
>     "git diff --cached" compares a (c)ommit and the (i)ndex;
>     "git diff HEAD:f /tmp/f" compares an (o)bject and (w)ork tree.
>=20
> Because these mnemonics now have meanings, they are swapped when revers=
e
> diff is in effect.

I like this proposal-ish; making the prefixes more intuitive could be
useful when looking at a bare diff from git too.  I'd put some time in
to help implement this.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig8E69742F58FB2810FD7D9922
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSKpEPgPFruyc22R/AQL77w/+IzPAcPrfmq1zC/ox/JDT6ZmOd7EyklQc
C94OSLiAirjOqi2fiWw1NeQK3mqRideEl39IZDYUq2G4OX233UFyKuemlIfSMig2
j9AwKghIceAYVkz363JfiyOh5ohcTfw6SpXvavxlOrhR6YBqohtE4mjOkFehXTbY
PckktxqimfNNOpj7VC8+CocZFv+nfLj5XH1G0xY2bgGoAYSlhkj/GZJp/VWEgcxk
T3kruCCh8+ueRKc0pYBIvTzQJdkosRd7CDWdcHIiZBef0Xo2yC4rdFXU8LBDl5fS
dLPwa5u+tbJbcfq9Mux4fd1p4jqyClPJYTyS5YNNxfG1/jcI1h3EPBZZpU6Yn4As
jDrNosvN4okTA5qGaRLAA/GsIEv7PVsUGfQDL/EtNMuyiJXnPLU8D/j7VpEAtrR5
/YjghLzZmIHDVmoLi5mLuzgiQ9MFogqhEzmvM6pAD3/CZcdHABRrh7N0MOPdoBD7
/bjGgviuOba546axGhgvjj6fq7tJRhoLq1pAxEm1XC6P28S27FHB8RglDliyhr3J
fAHJhM4iZEYBGoFdNVD8qTHXjUUHFK5t/O+TLuHOjUnAue5Om4dTS/L0ZuTEBLVq
TTah0DxX/xo6dL6dfpitQy1Hoc1FHNQZBz0yQcJdPzyih6OouZDFZZjwP/KDLi9q
AXDWHNDjiEE=
=Pj82
-----END PGP SIGNATURE-----

--------------enig8E69742F58FB2810FD7D9922--
