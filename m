Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E4F1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeLQWlp (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:45 -0500
Received: from bonobo.maple.relay.mailchannels.net ([23.83.214.22]:21771 "EHLO
        bonobo.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731877AbeLQWlp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Dec 2018 17:41:45 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1EC2E5C48B1;
        Mon, 17 Dec 2018 22:35:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (unknown [100.96.19.74])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A55F15C3C71;
        Mon, 17 Dec 2018 22:35:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Mon, 17 Dec 2018 22:35:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Tasty: 78d33a0670ea73e1_1545086137843_942282651
X-MC-Loop-Signature: 1545086137843:593773342
X-MC-Ingress-Time: 1545086137842
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTP id 656088187B;
        Mon, 17 Dec 2018 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=date
        :in-reply-to:references:mime-version:content-type
        :content-transfer-encoding:subject:to:cc:from:message-id; s=
        novalis.org; bh=aeZIZtwZV/oX89EpwJBJzd7WURY=; b=MZuePrygTzbZKRQ5
        JCl5fL3VFej/M+5HzgsoI9vD2kEFNTUoweizbvfzsq/9XDHKplemPknXWfBPQZQk
        nG4Gebkqm11mJGO7P8N2qccYd3NL3gax1Ix8mUpEgUZH2zVKTXNwrlMjfTPYXzcB
        3MEbg1mMFfxphGpOoJywVVn24dY=
Received: from [10.254.208.165] (unknown [107.242.116.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 9F9958187F;
        Mon, 17 Dec 2018 14:35:35 -0800 (PST)
Date:   Mon, 17 Dec 2018 17:34:33 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20181217221625.1523-1-avarab@gmail.com>
References: <20181217195713.GA10673@sigill.intra.peff.net> <20181217221625.1523-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] upload-pack: turn on uploadpack.allowAnySHA1InWant=true
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        git@vger.kernel.org
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Fredrik Medley <fredrik.medley@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
X-DH-BACKEND: pdx1-sub0-mail-a62
From:   David Turner <novalis@novalis.org>
Message-ID: <F368D768-7DC6-479C-8888-2A41360B0B6A@novalis.org>
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeifedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepffgfjghfgggtgffuvffhkfesthhqmhdttderjeenucfhrhhomhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqnecukfhppedutdejrddvgedvrdduudeirdehieenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplgdutddrvdehgedrvddtkedrudeihegnpdhinhgvthepuddtjedrvdegvddrudduiedrheeipdhrvghtuhhrnhdqphgrthhhpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqedpmhgrihhlfhhrohhmpehnohhvrghlihhssehnohhvrghlihhsrdhorhhgpdhnrhgtphhtthhopehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvthenucevlhhushhtvghrufhiiigvpedt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, I like this=2E One nit:

On December 17, 2018 5:16:25 PM EST, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on" <avarab@gmail=2Ecom> wrote:
>--- a/upload-pack=2Ec
>+++ b/upload-pack=2Ec
>@@ -54,7 +54,8 @@ static int no_progress, daemon_mode;
> #define ALLOW_REACHABLE_SHA1	02
>/* Allow request of any sha1=2E Implies ALLOW_TIP_SHA1 and
>ALLOW_REACHABLE_SHA1=2E */
> #define ALLOW_ANY_SHA1	07
>-static unsigned int allow_unadvertised_object_request;
>+static unsigned int allow_unadvertised_object_request =3D (
>+	ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1 | ALLOW_ANY_SHA1);

ALLOW_ANY_SHA1 already includes the other two=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
