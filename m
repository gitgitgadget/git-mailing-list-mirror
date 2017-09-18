Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0C22047F
	for <e@80x24.org>; Mon, 18 Sep 2017 14:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbdIROWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 10:22:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:45770 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdIROWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 10:22:06 -0400
Received: by mail-io0-f170.google.com with SMTP id g32so2467979ioj.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZA+csZXBZQIZ59Kvp6lwIFkMjODlpdrnbObgJGwT7VM=;
        b=AoucCFxTdHrM9axb7RjfQlBLVq+npNCOqI7suTqA/dkQo2ngvm00nhiCav0IIsG1GK
         BbhnZASvzWpMHTfLaGQLnAQdx2/M8o9XrEryn5WF1kPxX64FB6zB/KRTR3cdF18994qb
         oOWufiVRME14/A/8tG4FNeAdBe/FRA3uqdtw77L5KtMeOnlqCpEZTBEpJxeL69tApZN0
         JTCWlCMjpyeUYfVn1TjDabFSt8phOSuEehQn5uKCcT+Oy9rK1Apk4537SqlXX0ULOGq0
         aWyl+LjcXDuQ9bTODFdBWIIPCtG5YVEmgejHfiFtxQljWYz8D2tLg3fiNlDvc8tYPNQC
         +WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZA+csZXBZQIZ59Kvp6lwIFkMjODlpdrnbObgJGwT7VM=;
        b=rmFV3SmJj+eGFJG7O0cpWxhxpmibbonQQII4JsGHW09d9tiEbndC00mHP6IlkWPQlk
         yfMjy/yoYPuz8FwBmwJll31UMLxXTkKENXYHu6uIMVT4g8DPsb8qU8cm3Tfv5SYOu95D
         PA/cLeY80K1XuuTJEkLjT9Qo5bYP8cE2oncKEYLODqREY2nGy9gbwqdf6m9rBoWq5vdO
         GSxcUj+8BhXqJdeifFCppC0OOBrljshvS+lx+mi4yKJB5ZtUrF/Sp7pwxowoogvAhVfx
         XA+FjVGviIyWefT0dRvLG9fK8ioN/OB96w5vGtbuRg82Eoi0+hGmHropedpyrHsALmPU
         fKqA==
X-Gm-Message-State: AHPjjUjpXa9Wec9AJqGH2Ulf5YKB2sHz7TOP7TmZvWaWESvICKZT55WA
        FCcUbSH1A32mDSO5
X-Google-Smtp-Source: AOwi7QB3exh4Bdie0NSsPasze445JtqKC+wVIGx81PcocGnbfS3ugxAyLBe6NXO3Y8EVInnUPWuNpg==
X-Received: by 10.202.223.7 with SMTP id w7mr11246257oig.237.1505744525401;
        Mon, 18 Sep 2017 07:22:05 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-131.NATPOOL.NYU.EDU. [216.165.95.131])
        by smtp.gmail.com with ESMTPSA id f6sm682477oib.27.2017.09.18.07.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Sep 2017 07:22:04 -0700 (PDT)
Date:   Mon, 18 Sep 2017 10:22:06 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shikher Verma <root@shikherverma.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
Message-ID: <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain>
References: <20170906093913.21485-1-root@shikherverma.com>
 <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
 <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
 <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
 <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
 <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtuvov3knkjy45hn"
Content-Disposition: inline
In-Reply-To: <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dtuvov3knkjy45hn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, everyone.

Sorry for being late in this thread, I was making sure I didn't say
anything outrageously wrong.=20

> That's Stefan; I wouldn't have suggested any approach that uses the
> blob whose sole purpose is to serve as a temporary storage area to
> pass the information to the hook as part of the permanent record.
>=20

Hmm, as far as I understand *this* is the status quo. We get an
ephemeral sha1/oid only if you have a hook attached. Otherwise, you will
never see the object at all, even if you have --signed set.

I suggested preparing this RFC/Patch because of the following reasons
(please let me know if my understanding of any of this is wrong...):

    - I find it weird that the cli allows for a --signed push and
      nowhere in the receive-pack's feedback you're told if the push
      certificate is compute/stored/handled at all. I think that, at the
      latest, receive pack should let the user know whether the signed
      push succeeded, or if there is no hook attached to handle it.

    - *if there is a hook* the blob is computed, but it is up to the
      hook itself to store it *somewhere*. This makes me feel like it's
      somewhat of a useless waste of computation if the hook is not
      meant to handle it anyway(which is just a post-receive hook). I
      find it rather weird that --signed is a builtin flag, and is
      handled on the server side only partially (just my two cents).

    - To me, the way push certificates are handled now feels like having
      git commit -S producing a detached signature that you have to
      embed somehow in the resulting commit object. (As a matter of
      fact, many points on [1] seem to back this notion, and even recall
      some drawbacks on push certificates the way they are handled
      today)

I understand the concurrency concerns, so I agree with stefan's
solution, although I don't know how big of a deal it would be, if git
already supports --atomic pushes (admittedly, I haven't checked if there
are any guards in place for someone who pushes millions of refs
atomically). It'd be completely understandable to have a setting to
disable hadnling of --signed pushes and, ideally, a way to warn the user
of this feature being disabled if --signed is sent.

Maybe I'm missing the bigger picture, but to me it feels that a named
ref to the latest push certificate would make it easier to
handle/tool/sync around the push certificate solution?

Thanks,
-Santiago.

[1] https://public-inbox.org/git/CAJo=3DhJvWbjEM9E5AjPHgmQ=3DeY8xf=3DQ=3Dxt=
ukeu2Ur7auUqeabDg@mail.gmail.com/

--dtuvov3knkjy45hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlm/1osACgkQRo8SLOgW
IpXWXxAArPPjaxbooTly7ksZrv87Mqz5rdbywFgfjxV1Fy7d+4WL+xDTZQ3Dsbri
KMzAbC0xA8j2XKMgS3+uBfUzlR9KJCVv3X5PUnbUXnAArxsDOVKYn3LB354Y76wP
u+/NAX9LKJU8YPyHGwGMf9yyC7r0075IX5Z/ctdvZYExmVfS4bX2gnf01rl2a87k
OHYkrpWvC/PadQvDY7Yqpg4z6nwm47yIZKZJqnUfvFeAwYNH5saqgUTBGkKqtW3H
V8EE0H8wu3oixXVln/Zu8Llx3h1AtgoFZvnIjjShKFMYC7egab+Borge+om6mQX4
oP6oOhDwZ6SpPEtamc4dJF+l+pW8yXIBO9JQbARlNc2VChXFb2DiQUkgi3v6rtQb
NdTLhKVZ9Yf5vWLFxTsl0X3uHEVYgw5XA6fkQ8gEuoly39vShGZiuLPjPM0RbHeo
wpN4OwAt6jus7Xyao4GXf9dYdoa+xt1LUmevPK7dnb4gBLNMNZ5RfdvGXjnh9bWC
CQf2RTYuAEFgwe/3BvcRNoYoIYV9HoIZDrOBTI1noPoKpUFAnKqyP5QSGFHFu/c1
szTBsM+pV/z5i1vQ5tF4bEGV2pPI70Q26VbgdRGTAp5UB6jv7SpE0KVfZI9ILNpU
+54GWniXwqsGt32fKgsqMrljsXx3Nhvzl47vCG0I39Wq6ux6/zs=
=kF0r
-----END PGP SIGNATURE-----

--dtuvov3knkjy45hn--
