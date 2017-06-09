Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E161FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 11:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdFILKR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 07:10:17 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:32834 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFILKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 07:10:16 -0400
Received: by mail-wr0-f172.google.com with SMTP id v104so29187090wrb.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wye2NRqBC2BA9l4yYNHVLsPV8ZlqFAnPRSBiOwH6JZU=;
        b=LUmsj4cy4rcSbgE4XJOWzplMwitIL6vux/wKS2KMl7OJUUoqPRo09n3PmDXXwcgXHZ
         V6qmsEuHnkVTWaog9RdZWSGnKrjk0J0EbLs+ltabWNzhvYucMvFmMKGP4nSWTiV3pKIw
         ZxseUaWJCNtdZcXNqpJ+RYE/ZuXUL7fhrBw+rQw96JyHitRZKUD70cXTh0UzkCcy/AAB
         RdAJRyyKDWITHryvZ2WM+n0qBvl+9jVCJnBPRBg6mYKAL0sjGKeRGHEN7JAZFYxTzRwp
         stuoMXjRftEyPUi1zN8sxwUC8m2KOVNUSwSgEVEhhtsXZZ9yx05mOw5FpvdwGkikwc1Q
         0TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wye2NRqBC2BA9l4yYNHVLsPV8ZlqFAnPRSBiOwH6JZU=;
        b=ooC0x3EcusY9kOgVyFinOves6EAv8jTgYUbOixwjd4djEGCOCb0+LDgWhr85CL/kLh
         TtLcdAypkE+9/qLa6R++CnrtYeC/G0/eQDKHOMDSh7CXy6ux0zxYIBGS5bsrgrHB7D+1
         ujl+blRTV5Cy+VzVYXeJ+DrndJm8MIu3DZ6mRc7tOf5IjuXk7Qxg84qY7EHL+vxeHRG5
         3fxTeqyWw2Aicrc2buKDF0pjSboKhGSFcEqPRTLs45e1Jbffpyz26jThFrGtuLDxi6Wp
         6f3Aq/VemI7vhKwpieP1ySO+7sjd9D07A+S0Fp5YqMUO/fy0Iff0JC5ywqzX6xduaQGj
         iA6Q==
X-Gm-Message-State: AODbwcAlmbxsEED/7X+GxNNY8W+4mJwmVhaMREGDH++ssRD21T8vFJgg
        WUdw0hSL2n1M6tK/DQc=
X-Received: by 10.223.160.178 with SMTP id m47mr6624128wrm.194.1497006615183;
        Fri, 09 Jun 2017 04:10:15 -0700 (PDT)
Received: from buc98hyl12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s13sm1452924wma.21.2017.06.09.04.10.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 04:10:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: There are too many unreachable loose objects
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170609053643.k2skjxf55xtjty2q@sigill.intra.peff.net>
Date:   Fri, 9 Jun 2017 13:10:13 +0200
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C13D221-1F42-4012-914E-53634DD5BC79@gmail.com>
References: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com> <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com> <20170216225710.6nnbw65qoeb6lrw5@sigill.intra.peff.net> <987153C6-2F10-4229-8E59-B106604896DF@gmail.com> <20170609053643.k2skjxf55xtjty2q@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Jun 2017, at 07:36, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Jun 08, 2017 at 02:52:42PM +0200, Lars Schneider wrote:
>=20
>>>> It may be that it's the server side that needs to git-prune, and =
not
>>>> your local side? I'm not really certain but you're doing a push =
which
>>>> talks to a remote server.
>>>=20
>>> Yes, certainly the position in the output implies that. These days =
you
>>> should see:
>>>=20
>>> remote: warning: There are too many...
>>>=20
>>> to make it more clear. Perhaps the server is too old to have =
860a2ebec
>>> (receive-pack: send auto-gc output over sideband 2, 2016-06-05).
>>=20
>> Do you know if GHE 2.9.4 has this fix? (Is it OK to ask this here?)
>> Context: =
http://public-inbox.org/git/9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com=
/
>=20
> It's probably not the best place to ask, as I don't think there is an
> easy way to find the answer unless you have the GHE source code. But =
the
> answer is no, it's in GHE 2.10.0.

OK!

> Actually, I guess you could run "git version" on the GHE box; the
> version numbers show the latest version of upstream Git that has been
> merged. This particular commit is in Git v2.10.0 (coincidental to the
> GHE version above; the versions are totally independent).

Thanks for the `git version` tip :-)

- Lars
