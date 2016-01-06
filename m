From: Jacek Wielemborek <d33tah@gmail.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 6 Jan 2016 13:51:29 +0100
Message-ID: <568D0DD1.5060300@gmail.com>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <CACsJy8A3xX02pV7r+vG0BvtFmU=Axx7=2nHXp07zOreXeAj_wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rSlSdvJFocW3gqNJBs8qW8fG2OW08HL84"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnZa-0000Ka-FS
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbcAFMwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:52:15 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38099 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbcAFMwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 07:52:14 -0500
Received: by mail-wm0-f52.google.com with SMTP id b14so73949934wmb.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=8XY3hhbesfY2IPYg5u9qQeyptKQXyMpTsfndcqbSMPU=;
        b=roxCMACx/LqNtH8voYxgzt3pMxi2DM78h23tHTkp4wO5ZkXGbrR1MhcXzUEdjEW/t0
         03hoo63+kphTeZkdPCyjLs0Q1Y2qp2Ac0HZQApQ5bWgc0hA3L5JNqg55waUJyHMalitu
         xGFFnFib8CetdRdaUzCQDXnuoDf0rngTRKAn3eNcuZtiJOGkSsiEBXGojqYCjCLQGRtZ
         57AnDQKGFQcECCnj7Rb1XmPK+tKg1pQddsJ3YOsKSoYbqE4MpdKjCLIik7tDLowNoANg
         BQtVpZ3nGxrq8WDaAzCgtVEm3bsa/4QrxN98OgV69Q6T6rPVRfPvSZ92jXFFsMs9OwQO
         B9tQ==
X-Received: by 10.194.179.71 with SMTP id de7mr105705427wjc.119.1452084733174;
        Wed, 06 Jan 2016 04:52:13 -0800 (PST)
Received: from [192.168.43.59] (ip-5-172-247-250.free.aero2.net.pl. [5.172.247.250])
        by smtp.googlemail.com with ESMTPSA id 193sm8561184wmg.16.2016.01.06.04.51.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 04:52:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CACsJy8A3xX02pV7r+vG0BvtFmU=Axx7=2nHXp07zOreXeAj_wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283438>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rSlSdvJFocW3gqNJBs8qW8fG2OW08HL84
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

W dniu 06.01.2016 o 10:46, Duy Nguyen pisze:
> On Tue, Jan 5, 2016 at 10:24 PM, Jeff King <peff@peff.net> wrote:
>> If you can find a fuzzed packfile that crashes "index-pack", then _tha=
t_
>> would be a big deal.
>=20
> I'm sure you know this, but if Jacek moves to break index-pack, then
> he/she should also try to break unpack-objects because sometimes we
> use that command instead of index-pack.
>=20

It sounds that you could use a little explanation on how I found this
crashing case and what would it take to fuzz index-pack, according to
the conversation I had on #git-devel on irc.freenode.net. Should I
assume that you know the basic afl-fuzz in my next post?

BTW @Duy, thanks for CC to me, I'm not subscribed to the ML.


--rSlSdvJFocW3gqNJBs8qW8fG2OW08HL84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWjQ3RAAoJEGlViymZXJRvwf0P/2l4++lfTFdN52afgcB+72mx
3/zNRB2+W8y5Wrk0EQGPH3LmK6pwLRMJZL+QzOMno3gampTK/sFflYFLkS7kOxa9
vupUt6Ns9PQyoB5opnp2g26Fo02f1Dou4scFgtJxho8ZhBnQjtv2JCAzk6EENMNB
qYM4VIYPTdx2JCwM43Vup3hwjgb1x2E0SeQpc8SxIZv+ORGejm3X8ONcFA5EU2/X
dyurXexE2dOgHHSpvTfBCEF0jrPGGa3u3zHqqvwlkCVzVg0eyPy+J8OWprWfUcSf
jRMI8Gn7VIniV5+HTj87EvJW+Ri400QgCVoSIRsYydZwtevvjU0uIUz1eVTpb69x
91IBQkEwiIaWKe+Ric1g24AUsyuNwyeUvgkM5gZBnTCzQwUTfi/SilPvdwKAZwHu
EcDqPGVeXDkkjQbTOKl3SUTgBzGiV35437sYNuErmyZgZE58SrJkgk2Ii2UOl3+R
1wHd+5NxuyI/eZU8+OfGw7EESQA/J+eqJgyErRbFd4keWpQSwBkwbAbc7jV9qEL8
ks1Q1r1w/kQGjCvw/dqFbvCKJtbeBye+Sx/sF/xL40z6fcuMTjsJGl9UG8lyG1Zf
PO52QJY0IQYYlSZEUIiE982nQ2eJjyaZUM9kQPUVXMsxhuEpExAozaw1Lrousbnj
tuZZKHcwwrXcy5hqir9W
=qurf
-----END PGP SIGNATURE-----

--rSlSdvJFocW3gqNJBs8qW8fG2OW08HL84--
