Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0DD200B9
	for <e@80x24.org>; Sun,  6 May 2018 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEFNWf (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 09:22:35 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:37162 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeEFNWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 09:22:33 -0400
Received: by mail-pf0-f170.google.com with SMTP id e9so16778015pfi.4
        for <git@vger.kernel.org>; Sun, 06 May 2018 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=WbCCNo9r7Mc9bPId35jiHuB07kysSKXie2g3OSLnOWY=;
        b=D+C/SvOqho4ZTvOoKvgAEU3KmQNxXZEWWC7cizOxAOnV8UOxI6IygJrX5vLZxMLEiu
         uxeaZ692NCnCr/WLCYPkS8JKfwoGTRc+4uUiBSZnvtCFHdjANUVdhr8qRiGBAMRZyERe
         KmfIYQpbX3E2J/idhwLgdjo8FOXkn6D9y9WNLr0xXF1Fl+t28oozr+dWk0g1kg4jSXWW
         qP3wT24ovjYHpz1pyxUio9CfcxihlGBe8cNxptT4khmcWx3cPm/w9w+752gTTr0NrXjm
         aaRnLcDT6ypZL2tQhNBeZDrjDjSbg4PDYpwUC7ncc4NHYkZ+Z5kAQk2eonEd1PYf/d10
         kPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=WbCCNo9r7Mc9bPId35jiHuB07kysSKXie2g3OSLnOWY=;
        b=KtyDIHx43+kRrrQV+bnWDSnqNEMfL5biI4aCUcxBH9ykS3fnR+OeAL768h8MlPiVLn
         5NYVZzilCNcqfeFEDCgfu6GgYHNv9i3jLsYFA9CwH9nAKIs9pyvfHoerK1/GEX0ag05H
         p9CpJL/up0JUf6WnmQqf4NML8nzv6ccrdvtuZ6TuadaUN1bbh4TMWa5JuXzPRTnSmdoZ
         XHa/3mxwf3WHupnbBRt8f89vOaT2YGPdIjCkxFUmZ4cESRwkl7ddx/+ysqZJtlGysGpf
         3avNhAI4LoINRRCwlXW0NQzL+JcFwCP4wfzaKd4l5bI0eohsYxRwgdy4LB0DbnjTA5j9
         3NSw==
X-Gm-Message-State: ALQs6tCtwit9w/ZBClOKEZdMhAPyc7reu9mtxXKc1JZhWjO8eSmzC6VD
        FsYPekZOAk5/eySb6z1+Apg=
X-Google-Smtp-Source: AB8JxZpsjIFV6R/EqKnnga0ZWDu7YBV0CP9+QlZc3OxsZ8EhBEHanZY1X9G6aKl5sUTRvgPS6ooOAg==
X-Received: by 2002:a17:902:1665:: with SMTP id g92-v6mr35040069plg.195.1525612952915;
        Sun, 06 May 2018 06:22:32 -0700 (PDT)
Received: from [192.168.206.100] ([117.242.92.14])
        by smtp.gmail.com with ESMTPSA id x5sm44708491pfh.115.2018.05.06.06.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 May 2018 06:22:31 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
Date:   Sun, 6 May 2018 18:52:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e9LRt6F70gPcoTHQVEbmkLp5hMtEP2q4n"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9LRt6F70gPcoTHQVEbmkLp5hMtEP2q4n
Content-Type: multipart/mixed; boundary="DRyvps6tpNbVCPsitc7aFV885qocpTAiE";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
Subject: Re: [GSoC] A blog about 'git stash' project
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
In-Reply-To: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>

--DRyvps6tpNbVCPsitc7aFV885qocpTAiE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sebi,

On Friday 04 May 2018 03:18 AM, Paul-Sebastian Ungureanu wrote:
> Hello everybody,
>=20
> The community bonding period started. It is well known that for a
> greater rate of success, it is recommended to send weekly reports
> regarding project status. But, what would be a good form for such a
> report? I, for one, think that starting a blog is one of the best
> options because all the content will be stored in one place. Without
> further ado, I would like you to present my blog [1].
>=20
> Any feedback is greatly appreciated! Thank you!
>=20

The blog looks pretty well written. I also read your proposal. It also
seems to be pretty much well written. I like the way you explain things.
Particularly, you seem to be explaining the problem and the way you're
about to approach it well. The plan seems pretty good.

I just thought of suggesting one thing which might possibly be
redundant. I think you're aware of the fact that the Git project has
Travis-CI builds enabled[1] which you could take advantage of to ensure
your changes pass in various text environments.

If you're interested in testing your changes (which I suspect you are),
you might also be interested in 'git-test'[2], a tool built by Michael
Haggerty. Unlike the Travis-CI tests which test only the tip of the
change, 'git-test' would help you ensure that every single commit you
make doesn't break the test suite (which is both a nice thing and is
expected here).

Sorry for the off-topic info about the tests in this mail :-)

Hope you're able to achieve your goal as planned and have a great time
during this summer of code!


References:
[1]:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L7=
0

[2]: https://github.com/mhagger/git-test


Regards,
Kaartic

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky

KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--DRyvps6tpNbVCPsitc7aFV885qocpTAiE--

--e9LRt6F70gPcoTHQVEbmkLp5hMtEP2q4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrvAZAACgkQveda2sPW
GWmKiQ//SYyh2At4Mo7qF2gSfnnW8UFFlAbmvPxAuX6MNL1u2PyXy6SBk2oGhkXT
vWA5XshgIfZ8qwQIK6/TNxwQbH16mieVkOHlTCTlGTqoUuy1msxp/TDymrslym8G
92VFiVj1DqxPvTSg3Q8lDgUpmKpSqpe2/lsFPityWYffBRL1mFhxx/2eLgKgnh32
3RmprXNYKWfnIzCGP2Ie3FGxfSRezuekSjiByXEPgJWp/JO2Guwrinfmd97WS8QQ
ofvhYfQ7LExBIj9ygSteJf2Lu8U7DBwFh0QmrmboMFQce2mOHq7WLczE7+7m+6Qm
DLq8/fwZ9k6NVd8t2u4u9GYemsB8XFGmhsV7xWjI2KLy4loYLl7ZLK9wuu97fEw2
rYIN/818cQZAcX6DbtEIun8MC/Ha0dh3Mq9RT1VjJBhBN5rnPtemsz53MUzxelwt
irmFrbNU4ZRdPKdCD6ZmQDx5zOI+MLyFUum2B5NLWPce+9ovALZc5jSzpS8aqdN1
41pluylRvJQH0yrlBZvjRCopbq0I+B8ZJQ6bqSN2lU6Drz94rpuobc5XjufgbCVJ
CUOtF5fk9EPmIGw/gtO2RaTIRoRDtEdpzmLyRUdul+jbSKIJudXRBSEhx9PQ5OnW
2pKvKIiAHd+sBg1eeVbkj7xTECnzJZUFRf/ivPpY3XP+uVPUdLs=
=DjT0
-----END PGP SIGNATURE-----

--e9LRt6F70gPcoTHQVEbmkLp5hMtEP2q4n--
