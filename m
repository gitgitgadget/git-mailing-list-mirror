Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA1B2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbcKKRbm (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:31:42 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36538 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934006AbcKKRbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:31:39 -0500
Received: by mail-wm0-f42.google.com with SMTP id g23so110490354wme.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7JUuMidepgJu6oFoYeinHZdSdyxv2n69OizYQ21YAfI=;
        b=ENmKNvkRyU79Xmp/qM3479sEnVXi+F3ku9rqiSfKTHqIr3PebeWwQKxprW4kCct69U
         fgB9b8vgD621u0y//6yACkaNPA5BRnMmNWUgzS7BpMzwnzI26MHAGUoOTJmjQ8a01RxD
         732tGSnI9i6149/hQNM3jYny6WEgt+n+Fq6Q6xFi+2jtYvxNb/ivU3tK+wCS4VrY0Pic
         7jdQhZfiNPURuStxslnUqtUjSuLlsUEaaJm1P0KfHVP+Xx8fBhLHpjI9uitIwXwsUdTF
         xd+57nu07kGBemPiHCzDpWGG2iTY46RMqfc6wpz5Prsoz8xszvV4T+0QrLkLtPtYbtx3
         9VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7JUuMidepgJu6oFoYeinHZdSdyxv2n69OizYQ21YAfI=;
        b=OfRukDLa7RBUVDfG8c0fCODdKdmBRvZVtT5Bw/RBqE7UZkKWAFPeSgtIYRaQ0wIzE/
         4i35cOakz45fPLV2TSQYeGm+FN36Ibe8lmQPA8Pv4P7hkzVQBPbz0WrdtPRkUpp6LBFw
         gUopVJsmaTBuqfrwPezlxm6Rt9cb1NFlaVg9jAqWN0HC1eCLYXnL0O2KJJkFBZqEXb1n
         P5kDSTKZ6+OWStqorJHx4pkyUwac26DnG7t7E9/Qyz9CFyyL2/lv2Bd/fEdgJTzeZgC7
         S/CDD1pxWJM/uL25rP2tjKcvToWvKDhrRTzfFYGKmFH/y23+XXdr7vbZ/thbBH8KMYLV
         TVOA==
X-Gm-Message-State: ABUngvd5I7lU3jFzyWvjRSyKprf+eernS5rD2PhEohJDwLrzCpgFzc1RlNtQZxOmdj17eg==
X-Received: by 10.28.94.76 with SMTP id s73mr11241351wmb.107.1478885497790;
        Fri, 11 Nov 2016 09:31:37 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m9sm12290926wma.0.2016.11.11.09.31.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 09:31:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
Date:   Fri, 11 Nov 2016 18:31:36 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611111711210.3746@virtualbox> <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Nov 2016, at 18:05, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 11 Nov 2016, at 17:13, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>=20
>> Hi Junio,
>>=20
>> On Thu, 10 Nov 2016, Junio C Hamano wrote:
>>=20
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>=20
>>>> I'll report back an updated schedule when able.
>>>=20
>>> I pushed some updates out on 'master' today.
>>=20
>> Which means that t0021 is now broken also on `master` when running in =
Git
>> for Windows' SDK.
>=20
> Part of the reason is that Hannes' squash got lost:
> =
http://public-inbox.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/=

>=20
> @Junio: Can you apply this (see discussion with Peff linked to email =
above).
>=20
> @Dscho:
> There is still one remaining new issue with t0021 ... investigating!

"17 - required process filter should be used only for "clean" operation =
only"
seems flaky.

I don't have any more time today but I will look into it tomorrow.

- Lars=
