Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE421F405
	for <e@80x24.org>; Mon, 17 Dec 2018 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLQXHt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 18:07:49 -0500
Received: from bonobo.maple.relay.mailchannels.net ([23.83.214.22]:18817 "EHLO
        bonobo.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbeLQXHt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Dec 2018 18:07:49 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8E69B68397F;
        Mon, 17 Dec 2018 23:07:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a1.g.dreamhost.com (unknown [100.96.19.78])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 104E768291E;
        Mon, 17 Dec 2018 23:07:43 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a1.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Mon, 17 Dec 2018 23:07:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Inform-Belong: 38f33bcc4fe3e327_1545088063419_4006812649
X-MC-Loop-Signature: 1545088063419:2919634290
X-MC-Ingress-Time: 1545088063418
Received: from pdx1-sub0-mail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a1.g.dreamhost.com (Postfix) with ESMTP id 9CE397FE25;
        Mon, 17 Dec 2018 15:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=date
        :in-reply-to:references:mime-version:content-type
        :content-transfer-encoding:subject:to:cc:from:message-id; s=
        novalis.org; bh=9jJ+DM07uQzayd+tN5miYl1XJ7E=; b=VrBLjh9tnOcX+J4N
        ldAlH0nKLy5C8xOqx/ZftT7PL+EoJdReenlp+0EEuKcXZMp5BmLsKXB3TapDZdHG
        KHpXrVmCHScYUwZsDtYlW8XIFGYprR1DbexeZ88U8LQfVOptKAAMBkUH7dDiBdYq
        2J2SwP9Lw7taJzn85q/BgiImUPU=
Received: from [192.168.86.57] (ool-18bcb49e.dyn.optonline.net [24.188.180.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 01C0D7FE7B;
        Mon, 17 Dec 2018 15:07:39 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:07:37 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <875zvr2235.fsf@evledraar.gmail.com>
References: <20181217195713.GA10673@sigill.intra.peff.net> <20181217221625.1523-1-avarab@gmail.com> <F368D768-7DC6-479C-8888-2A41360B0B6A@novalis.org> <875zvr2235.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] upload-pack: turn on uploadpack.allowAnySHA1InWant=true
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Fredrik Medley <fredrik.medley@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
X-DH-BACKEND: pdx1-sub0-mail-a1
From:   David Turner <novalis@novalis.org>
Message-ID: <879B301E-C36D-404C-8354-5CFAF48B3B7E@novalis.org>
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeigedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepffgfjghfgggtgffuvffhkfesthhqmhdttderjeenucfhrhhomhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqnecukfhppedvgedrudekkedrudektddrudehkeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplgduledvrdduieekrdekiedrheejngdpihhnvghtpedvgedrudekkedrudektddrudehkedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqpdhmrghilhhfrhhomhepnhhovhgrlhhishesnhhovhgrlhhishdrohhrghdpnhhrtghpthhtohepmhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On December 17, 2018 5:57:50 PM EST, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on" <avarab@gmail=2Ecom> wrote:
>
>On Mon, Dec 17 2018, David Turner wrote:
>
>> Overall, I like this=2E One nit:
>
>Thanks for the review!
>
>> On December 17, 2018 5:16:25 PM EST, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason"
><avarab@gmail=2Ecom> wrote:
>>>--- a/upload-pack=2Ec
>>>+++ b/upload-pack=2Ec
>>>@@ -54,7 +54,8 @@ static int no_progress, daemon_mode;
>>> #define ALLOW_REACHABLE_SHA1	02
>>>/* Allow request of any sha1=2E Implies ALLOW_TIP_SHA1 and
>>>ALLOW_REACHABLE_SHA1=2E */
>>> #define ALLOW_ANY_SHA1	07
>>>-static unsigned int allow_unadvertised_object_request;
>>>+static unsigned int allow_unadvertised_object_request =3D (
>>>+	ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1 | ALLOW_ANY_SHA1);
>>
>> ALLOW_ANY_SHA1 already includes the other two=2E
>
>FWIW (and maybe I made the wrong call, and have no preference realy) I
>opted for this as part of "this change doesn't do any of the hard work
>of extracting the now-dead ALLOW_[=2E=2E=2E]*=2E
>
>I=2Ee=2E the diff context I had doesn't show all the ALLOW_* values, and
>with the context given it might be easier for reviewers to look no
>further than "this is what you'd get before if all
>uploadpack=2Eallow=2E*SHA1InWant was true"=2E

The context I quoted said /* Allow request of any sha1=2E Implies ALLOW_TI=
P_SHA1 and
ALLOW_REACHABLE_SHA1=2E */

But up to you (or Junio)=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
