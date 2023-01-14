Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2443C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjANW7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjANW7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 17:59:09 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127049EF4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 14:59:08 -0800 (PST)
Date:   Sat, 14 Jan 2023 22:58:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673737146; x=1673996346;
        bh=60+yV7KfDqzekCyFIYgqAJRPftcbk2Fma9oWs3oZ1tc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FOwDC2fBlXnPKaUF7rFuGygecNd918RJo88XmdfZacaEkJxYiUqN1Zlh5KF/AYCjJ
         1d9DhB2LgmNDxVfTAz8uKT7LIc9dycjCxZEFZT0etqZ7Rl1p19a5wRakC6Gt1UI3Vb
         V2n2xRvxR/lYADJ7aGMqdxe/b1Hg4kJfYR0zF9EQH9UqssV5TUsvzKYbRDtbLGWnMN
         k2vLRNccNwv/tgzKhLzYMWxa6mpIF7Bc6VEtmVyWPxNoNXPLOI+IqoeJDvOkd27HYN
         fFosQKRcqvC12P7+GVCau543Dj94zw92bWiYt3Ouksey12us95O85uUFvWMkYvB+tv
         SlUDi8EcZHfbA==
To:     Jacob Abel <jacobabel@nullpo.dev>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org
Subject: Re: [PATCH] worktree add: introduce basic DWYM for --orphan
Message-ID: <20230114225635.quyxb4vppvtv76dx@phi>
In-Reply-To: <20230114224956.24801-1-jacobabel@nullpo.dev>
References: <20230114224956.24801-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/14 10:50PM, Jacob Abel wrote:
>
> [...]

Oops for some reason this didn't show up as a reply on the lore. This is
supposed to be a reply to the following email chain:

https://lore.kernel.org/git/20230114224715.ewec6sz5h3q3iijs@phi/

