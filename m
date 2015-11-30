From: Owen Jacobson <ojacobson@heroku.com>
Subject: Re: Detecting pushes originating from shallow clones?
Date: Mon, 30 Nov 2015 18:11:41 -0500
Message-ID: <5C8F7871-D25C-4DDD-9F15-8EB9DF1F3103@heroku.com>
References: <147913FA-1158-40BE-8365-B90E3CBD79C7@heroku.com> <xmqqr3j76qxp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/signed; boundary="Apple-Mail=_BE6229E1-215E-4D4B-B253-00A38CB7CC51"; protocol="application/pgp-signature"; micalg=pgp-sha512
Cc: Owen Jacobson <ojacobson@heroku.com>, git@vger.kernel.org,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 00:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Xbq-0000nx-0B
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbbK3XLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 18:11:46 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33800 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbK3XLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 18:11:44 -0500
Received: by ioir85 with SMTP id r85so191318885ioi.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heroku-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:mime-version:content-type:in-reply-to:date:cc
         :message-id:references:to;
        bh=SEPFfsOV2WccPJgClQrCbcTiazYBuFo+GFzEMje/SgI=;
        b=Vl5Rl/SL16O7L1GAIc1wvjWNmZRCXYO+u0i8IzfExCkZhaMsq9HjgVft/B4INrYsoK
         IwXDVzK59OgO5Aq7+pug73A7doR/8hK6MlF7mJ4VBwWyB8xhpydK0gaBjpV6BT4r9h9H
         9Cgivf9WYZ+2EWhdwFgHzsNMQ6yCfxKl0NH0UyJABV9jhhIha0QlkwlJ47Q0X1ht9eE5
         2CJ90jJ5VeYGHqC07Hok1KO0EMserDDXiSZuwsbPC5zgJU+jfEoF6NdmRQA1aALbuWt7
         ZQQoPzAEpeeUwfxQAwW0WyL9SMYaqM2r8g3/Bggf5zG/a2Bto7uN0DOWIH8WPtaDTBJR
         7a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:mime-version:content-type
         :in-reply-to:date:cc:message-id:references:to;
        bh=SEPFfsOV2WccPJgClQrCbcTiazYBuFo+GFzEMje/SgI=;
        b=dE5Iwxksn4L2GpVX7H12JAXty1vvcrkhqzu9v4K4RW8I5dCiUmB/yrbMndNIAhJOnL
         vjDZxQZrkHlKJDYbvkwjoovWUAEEvp9bU/GFdMq11jPpzriLymrIKVsK/0rFx2beKC7T
         VH4O9l0NM963S2Lqx1zBgVnp5vU0ZPsAoKbZKVOv05cnCdh4E+hzm9sjDX4chyqikjED
         UfeG6fOaCiPmf7t6NIm7035U/RTHP/ZuPKIqWGZ92L9CyTqxwjQOpgB1D8OvY/7nTfNm
         Qv/KdLChM8hQUGlTUm4QfCWDjxJCjhMM+dr4BifT3MStcb2v4Lp+M6Vq4YXL6gmUKSow
         hTIg==
X-Gm-Message-State: ALoCoQledKRHfaEzvfy2GbQJtbgMu7zO2CADUYHP5t88ikMVUyLyHQktnlcfR0slboV/Wc5DapTa
X-Received: by 10.107.152.7 with SMTP id a7mr60047745ioe.134.1448925104051;
        Mon, 30 Nov 2015 15:11:44 -0800 (PST)
Received: from [10.0.180.115] ([69.165.253.231])
        by smtp.gmail.com with ESMTPSA id 124sm18476479ioz.10.2015.11.30.15.11.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 15:11:42 -0800 (PST)
X-Google-Original-From: Owen Jacobson <owen@heroku.com>
X-Pgp-Agent: GPGMail 2.5.2
In-Reply-To: <xmqqr3j76qxp.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281824>


--Apple-Mail=_BE6229E1-215E-4D4B-B253-00A38CB7CC51
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Owen Jacobson <ojacobson@heroku.com> wrote:

> Within the constraints that
>=20
> * we cannot control which version of Git our users have installed, and
> * we run Git v1.9.1, obtained from the Ubuntu 14.04 LTS .deb =
repositories
>=20
> what can we do in an update/pre-receive hook to detect that an
> incoming push originates from a shallow repository and reject it?

Junio C Hamano <gitster@pobox.com> wrote:

> Hmm, I would have suggested to set receive.fsckObjects which has
> been around since early 2008 (it is in v1.5.6, so it would likely be
> in v1.9.1 as well).
>=20
> But even without that configuration set, "push" shouldn't leave the
> receiving repository in an inconsistent state (e.g. incomplete
> repository, gaps in history) in the first place.
>=20
> Does anybody recall us having such a bug in the distant past in
> 1.9.1 and fixing it?  I do not offhand recall but I wouldn't be
> surprised.

It=E2=80=99s possible that that would fix the problem.

We do see pushes get rejected occasionally with output similar to

    To git@heroku.com:example.git
     ! [remote rejected] master -> master (missing necessary objects)

(We rely on customers reporting it to us, since right now we have no =
good way to spot this ourselves =E2=80=94 we don=E2=80=99t get the =
output.)

However, this happens -after- the pre-receive and update hooks have =
already run. We=E2=80=99ve historically assumed that the hooks are the =
last step prior to accepting a push, so we assume that if the hook =
passes, then it=E2=80=99s safe to take side-effect-ful actions like =
deploying the newly-pushed branch tip to servers.

Git=E2=80=99s native error message also provides very little guidance on =
how users should resolve the problem. While I don=E2=80=99t think =
that=E2=80=99s Git=E2=80=99s responsibility in this case, it=E2=80=99d =
be nice to be able to insert our own messaging here, or to detect the =
problem earlier.

Owen Jacobson <ojacobson@heroku.com> wrote:

> Right now, the best strategy we have is to observe whether
>=20
>    git rev-list OLD NEW
>=20
> fails, and if it does fail, whether the stderr output includes the
> phrase "revision walk setup failed=E2=80=9D. This feels like a fairly
> weak fix =E2=80=A6

Junio C Hamano <gitster@pobox.com> wrote:

> Actually, that (with "--objects" option) is essentially the test the
> receiving end does internally to detect the "gaps in history" when
> receive.fsckObjects configuration is set.

Hm. Well, if it=E2=80=99s essentially the same check, then perhaps =
running it ourselves in our hooks is the right fix.

Thanks for the input! I=E2=80=99m also interested in any other thoughts =
the list might have.

-o


--Apple-Mail=_BE6229E1-215E-4D4B-B253-00A38CB7CC51
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWXNetAAoJEAnOjZoiyXdEv1AP/Rq2l355AscvHU75Z7GorjQJ
yZwRXCqC0YrJI7BppzQjWALKWI8dLRHqmhmkQYtQrADIeudGXyIcrrVNp/IKXqev
mXoB0mPdHQQ+5Xt0OWbSF1k0gbnL6AuFMMSlc/cgyhQmI0j7ADNaThg2FMdRqdjc
l0sGyPoRgVKXpg8w0JBcj/4X07hR05BR1whxR/EmeGoj2fMqNNMPveDHd44fvLbs
KRdazNSsIGJU4Z1lD6JsPWBByuirggVgq+3J6iBUDUanFKVHv0jGEynD4YY5Vyg0
W6iPiKi4EmgOq6qG+HrciJyB9ZPX7CULHiVMR2xUcMIOnVetJf+FI8in3T9c2CgV
c5abqxV2zu9yYYjJH8Iek1dF/YG0MfUQI3aB9SA/YPkyeVqn9MGnx3osqTvX8Ohk
/degVUWlO3xkMhIwLQUTKCZCHzGVX0e38NmefkDzCbtOpAYqO0z77b8CR3nM/2EL
v6yPGBqiHW4UM1i9GhoLJcVNXPtVNmhnShP14xcTAfU1F5OVH9dvY1Vacd94LE/x
EJlqZvOMW3G2O4a7TbRpTGo1x+XT3yLm0kFB6lq41TADqgsRP9rkeQv8OTbj/0I2
H9nhqChy3nbVPhQcQbTqMCjnuPHl1ocZLcP39I0AiPEPlncoSOJIN7ze5+wWcpq2
HHA9P9vGQGhqFuOwpPpr
=iyf8
-----END PGP SIGNATURE-----

--Apple-Mail=_BE6229E1-215E-4D4B-B253-00A38CB7CC51--
