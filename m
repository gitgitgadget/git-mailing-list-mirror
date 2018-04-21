Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915501F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeDUKSQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:18:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:56661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbeDUKSP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:18:15 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHokD-1f8RUF0OqL-003f6J; Sat, 21
 Apr 2018 12:18:10 +0200
Date:   Sat, 21 Apr 2018 12:17:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is
 not present
In-Reply-To: <87efj9dmx5.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804211217220.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de> <87o9iedwqn.fsf@evledraar.gmail.com> <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
 <87lgdidt30.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1804202110550.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87efj9dmx5.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2014061861-1524305890=:4241"
X-Provags-ID: V03:K1:DjLBK+ew78h/RK5fN4sMQYRZLTy9rtzCLbYKPVq03vk4jLRxpAO
 Ro69fOoSapE+ikNZON8Vngb4u60nhQg7/3ZELf8A2ydEEabQspE9Bgm22FZhx+Uv0d5IlMF
 7FRkDkH/DNrsPYgxSUFQgH6CeP5ET0PX+xhPrtDbvOLMmXQxb15ghhP+556rmDuvb2iEZiL
 LZE3jPq/TeGr20/2CvA/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8Z4r8xDlVWI=:OL/XT9vKUo0bBnuPkHjPZG
 C7Ks2QzMTrwJRBTFWyeZhwJf1NxwRDMn6zIEbFNDcukkdVrl1mpWQ3dBdwNaVUDuS+YUl4fB/
 O1l0dYRnGAcv8QiDfEFNhFdRuEtcbQzeSzO7EHSjSSKdpVnqp+zJUGFNCSvXxV+zt4b1Fvxsl
 KwVXllHmhk7wG0dbnFOu0n8j46D4WCQW/wWe648EGmOUot1fBwPgJ7zU/MLj/oF5r2IWVSgeM
 3r1h1uVYXYpgUXZ+jaEDVjWDepRhrgqDCQ2laqGabp9Mc7wcc7GfovRXFn4Q7Gypy11mFQaUa
 tjm2LP24u3ffbSqvLmgV4wfmqWiZ9kCN4PjvmfgsY6bq0jFooa4vdfrcBlnNotaKRFOeWP6MN
 9PdxkNhmcgsNg6r1i5rZnCeFRETB1ljyNKA8k+VKGtH46JsaH6CosFjiKz66JjIYPdyA5I5Dk
 JNFpTnHKkbPb3/oabhyvgfk7heF5foGN2NE2vs/nbYzOKUUqeuqjcgsfWRWzbmUEq9aEoBxfm
 BFe0UF9EIvuoAkgWh5+BcnjSVvw7rrx8HqLoYdAzWyErEBHc3/ZBNGWp8ANyukHG+nRbCBSKf
 05eMHsCTbSnJmYC2EpB5gvXDu4L6Jnr9/6iZQY3L44juvLGOaJVkUFDms2PkjTrtB8E6FLnBL
 /iSyeQhlsDOTR6cpMisN2Z+JRK5acaxr74fLeFTo0kIsdNQTJZAOwUytpdDF7C3OkNMi/wmBJ
 aNgZ4bZJkHGVm9oSRTXjUtnoQBbNqmScjHMVgjL9/lNI0VulDOYXPzESbaEWwSChsL5SX6+Xw
 Ybp6HsEnN/p4mG4y68QH6NvShRQLOHNTRy448k++yvItRYvh+8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2014061861-1524305890=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sat, 21 Apr 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I still stand by the observation that the "why don't we" isn't clear at
> all from your patch's commit message and that should be fixed. It
> doesn't mention any of the actual reasons for the change which have been
> revealed in this follow-up thread.

Fair enough.

Will fix,
Dscho
--8323329-2014061861-1524305890=:4241--
