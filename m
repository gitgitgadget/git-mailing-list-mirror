From: Robin Moussu <robin.moussu@gmail.com>
Subject: Re: git-owner, was Re: [bug] first line truncated with `git log --oneline
 --decorate --graph`
Date: Thu, 16 Apr 2015 18:54:36 +0200
Message-ID: <552FE94C.5070302@gmail.com>
References: <552F8B85.2000908@gmail.com> <xmqqwq1chz2s.fsf@gitster.dls.corp.google.com> <7139e45030c23bb642c5fe35e4074c6a@www.dscho.org> <20150416.115628.1228076242478955092.davem@davemloft.net> <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uUMdswreFb2S1itlcKf8q2eBKpDiW4MPL"
Cc: gitster@pobox.com, git@vger.kernel.org, git-owner@vger.kernel.org,
	David Miller <davem@davemloft.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yin4N-0006Vr-49
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 18:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbbDPQzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 12:55:10 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38357 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbDPQzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 12:55:08 -0400
Received: by wiun10 with SMTP id n10so104604755wiu.1;
        Thu, 16 Apr 2015 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=fMQVR/vu1YN0EzscyYnsqrTRSWMt60vdUlr4TDZa8VM=;
        b=XgJNnRsw3dminqzWZb3yVemU4ki0d7E6EXTTc0hBF1Wl3bh1hOkWR0J8inUrvZg2G7
         x89PolPa+cU78EGFpNj62x5J/nBBw+xUaHLXpQD2d9g9FyUMVKi3jFPbG/prduzitbCh
         9TTXtYZeUrVFqCAixIZ/cVAyZokuWGi+3cwJ3wyfQrK2sMuM6+eMSdjvV179UvKKJxkN
         c2jSrbw4FLQc7n8noGRINW6iEKjLPGRKdJxsR2BM5SmwrbhtZBe2n/Tre+JiwDHVNMiv
         e+TtDkYeQgrPhn+W4tLx78DP1IryjbNcJFLLkGavRHTtWDAFvE+v4xgDaNGjoq0wuwUS
         Tt4A==
X-Received: by 10.194.77.230 with SMTP id v6mr63296563wjw.25.1429203307369;
        Thu, 16 Apr 2015 09:55:07 -0700 (PDT)
Received: from [192.168.1.11] (AOrleans-651-1-268-217.w92-160.abo.wanadoo.fr. [92.160.163.217])
        by mx.google.com with ESMTPSA id l10sm11139546wje.15.2015.04.16.09.55.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 09:55:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267309>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUMdswreFb2S1itlcKf8q2eBKpDiW4MPL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio and Johanes,
It was effectively a less problem, and not a git problem.
My $LESS is '-r'. If I make "export LESS=3D'-R' ", it is fixed.

Thanks a lot.
Cheers.
Robin.


--uUMdswreFb2S1itlcKf8q2eBKpDiW4MPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVL+lMAAoJEGxGpQTg62H142IP/3sse/+hlHZmOYv1qgxJrDrq
2f5qj3hVUeuj5RzsyGjRrij231Ok51ahGoEx9Dd4UwhON95uFfzaI1anWQnXO0CE
YtAnr1EdXqtWiUS7UkNG4uBNze8BUXvljcIhraYVl/8/J3hIpW50OdgFqn4OXc8+
cDDZ2lDcbspzlk6yRUvvRWaglLyB5VglsQFAsbXjyqduhGVp0NceO72nydfbiOHX
m9ZlJboMFxukLxHtG4nEKNWkSdHJQXfU+MBzZesGsNCEt+PNQ41zLdd64H5JwKoL
AX5tslQfzSxdyMORkxJ/TEbbhDiVvU52hJ4NYG4neGNcA8SXtmINmb+iPR0l6R5n
Gt5GTE5vQLiqV4KumUGcntUH4vL+jiyfd9hCkxSv/cMwgNl6ShWsTUG3EjgC64YA
lWYwPdKgKFfQUX6QXauZg19wrWCyIKyrIDkw7noZnvqizJtmA8H/9wfjW5v204fH
kLsHG+441n8TipDCKh9ZwanoAoPpfo6GdAhIiOH3mOFagCTDs1WELbWdDa4DhSLF
sHU6fWmaA+tKoj0O6+0+7k05ocNUi6WlNAxqeu1kWxMglfIMB9sSee2Zq13mamik
18UdVUT1GF3jkR0bDhYS8rZxApAhJkF/a0gZ7a9J2+di5W4YPEVA5I98mWhCAPT/
pVdlMCt//2ZizYDbMZid
=wRFA
-----END PGP SIGNATURE-----

--uUMdswreFb2S1itlcKf8q2eBKpDiW4MPL--
