Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA7C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbiCHM2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiCHM2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 07:28:20 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A046657
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 04:27:24 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id B19437E74B;
        Tue,  8 Mar 2022 07:26:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646742412;
        bh=G1RoKofvbkP4jL9vBbMhOHXzk22yBBdP4M+HqsOgFOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJS6SVFnyAmj+X5J1VwyD9wgBPVNsoZ692YnOyrWv8tTapFr5KgNYuD846Uwk3RSq
         RgitC15XG4bdx1CPtYczI1yvvKcgThEEXaGBuCN8hYCPLNP2B0/Q1Lns1tBWFyeS5J
         r3jUA6ye025tzl7qwsIoxH419Kb2JWwG0Xp8Mc5JUSzNfEOMJonNez6ZlE5YBLTcKy
         zo4uqs/HT61oPEiykrEETks73jDeonuFl7XjaJreKNY4TVE8vm7Te7BJZVjXLbYSOl
         8xXhmFHRCKlQ3YtxDeC2AofXagnJ9Pdn6IgXf9NJbH6zajL87/55GxKwePic/p/DFo
         dAz+Y8LLT9rLQ==
From:   Jason Yundt <jason@jasonyundt.email>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/2] gitweb: remove invalid http-equiv="content-type"
Date:   Tue, 08 Mar 2022 07:26:51 -0500
Message-ID: <4386099.LvFx2qVVIh@jason-desktop-linux>
In-Reply-To: <xmqqbkyhp4wv.fsf@gitster.g>
References: <20220307033723.175553-1-jason@jasonyundt.email> <20220308010711.61817-1-jason@jasonyundt.email> <xmqqbkyhp4wv.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, March 7, 2022 9:13:52 PM EST Junio C Hamano wrote:
> About the <meta> thing, it seems that brian already commented on it.

Thanks for mentioning that. I now see Brian=E2=80=99s comments on the archi=
ve. My mail=20
server was blocking him (via zen.spamhaus.org), but I=E2=80=99ve added his =
server to=20
the allowlist.


