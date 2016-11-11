Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7469B2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934003AbcKKRFF (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:05:05 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35695 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbcKKRFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:05:04 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so436156369wmd.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=36rz5Q5hLarnUQBa/Eh3ihRMxPtv7p9Hr6UiXUmZAKo=;
        b=Xl+ugglkIIAnb9Ws6X8vxSrQbR/FOHdJX7Vb5wBNy/TxOWLYCOx1OGGG9curyE+fYE
         uIheWe9dw4v/X4ePCB3EC+m49IwsUt1ob6A1bsRSuh5RUraRPPfBVhxqnLU2s4YIBX7M
         H8g7m4b+7fXRCeRbo+m6saqyteh8wSGskceNB6LQbasOf5I7EzIqsDT2PbMx0RR1I7Y3
         M0KQT3iERhB1H/JMrCoZ6fe+4ClvkeQp84o1rpihRad85XfAyQS84Ixi2F4A3t8BOloe
         BpEreFEpk59YD3HLUKEJsRn8MHrq743HdEMScJ9FAc3DqkLyl8DT0Cn6koHsCWh3pnyx
         EILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=36rz5Q5hLarnUQBa/Eh3ihRMxPtv7p9Hr6UiXUmZAKo=;
        b=NeuGyWKTyIj3i29MJ0QOlA1ANC/Nt2BendkdWXQV+tpMfUvRnT7Cu+c1xRM2Mq2KRg
         oG1Bw0rPsszRLZYodr6JIqxDWOuu8i3c646rHe8Ycs7NgS9PlCV/6PQflWT5m/wxuF8l
         nBgnoLP5PtvGL1vFFm18X4jAOlmCGVLCmhi6uEk2tb7xqRQS1eOTE9nU+XVX976dXAw5
         AeEWq99OHSPw2d5jasM1fJB+7Nm1CQLeJtjo8o0GNYIdFunTnSsB57LlFbZhRC6FptST
         T8yrTopjwPDDmK3yWaVIvxIeil4BsrEbk18zDOrZc8m2g1iqBTrjO4DbtXfw+qAo0Th9
         jJcQ==
X-Gm-Message-State: ABUngvcaM39y2iBdH4KEOwoekZ8oTsydeYIbS54706i7gzC80v1s0uk9lI/+m5lrOZmohw==
X-Received: by 10.194.96.110 with SMTP id dr14mr9893815wjb.209.1478883902849;
        Fri, 11 Nov 2016 09:05:02 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g6sm12406319wjp.45.2016.11.11.09.05.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 09:05:02 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1611111711210.3746@virtualbox>
Date:   Fri, 11 Nov 2016 18:05:00 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611111711210.3746@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Nov 2016, at 17:13, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Junio,
>=20
> On Thu, 10 Nov 2016, Junio C Hamano wrote:
>=20
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> I'll report back an updated schedule when able.
>>=20
>> I pushed some updates out on 'master' today.
>=20
> Which means that t0021 is now broken also on `master` when running in =
Git
> for Windows' SDK.

Part of the reason is that Hannes' squash got lost:
=
http://public-inbox.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/=


@Junio: Can you apply this (see discussion with Peff linked to email =
above).

@Dscho:
There is still one remaining new issue with t0021 ... investigating!


> To add insult to injury, t5615 is now broken, too. I do not recall it
> being broken in any of my CI builds in any of the integration branches
> before.

Confirmed on my machine.

- Lars=
