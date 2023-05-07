Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7408C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjEGMPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 08:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEGMPN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 08:15:13 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541F1437D
        for <git@vger.kernel.org>; Sun,  7 May 2023 05:15:09 -0700 (PDT)
Date:   Sun, 07 May 2023 12:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683461707; x=1683720907;
        bh=6JxZaG2VYPlgN9SgnGBeHfLqC0LMTegciazcG7sIzJU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wnfyoBaK9yzgkNl8tBvQPZyyjMxudx1ZW8eXtBK6EN2eeXLXmt2qDbKMx6Ene7btI
         eHf8SEEgk5os3J14q6/vKNrFr4uN2iWjYipfWEiVEQvW1dCRrk0UmBA7HbEX+hWhk2
         SjC4YlYtqKmhujRO4pKI5L6/dvL/Fu1Fb6lm4EIKJvSJ21DR4M2Jlf1oYlshomIcgy
         U7uBKHMjFQK0K3uAsL/owTzREs9jYszlXBzHMh05H5mFhar0GvyL59W5DCeJlZoQtu
         K0SgT7MMFvRMwZBJhyjvuD0BJ5LbggSlrhk3MPLB8/JpQYsd6pti/qkY8ZovcVDMnW
         AcYEQjMbV+xOA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v10 0/8] worktree: Support `--orphan` when creating new worktrees
Message-ID: <wv62fffrtu7frn7zi34ggv25rt3v6jf4pccas3panksqdmwljc@mro5pqva4t36>
In-Reply-To: <20230507120530.14669-1-jacobabel@nullpo.dev>
References: <20230507120530.14669-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok it looks like something with Protonmail is arbitrarily discarding
email headers for me.

Please ignore this revision for the time being and I'll just RESEND it
another day once I can figure out what is going on.

