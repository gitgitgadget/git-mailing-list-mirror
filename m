Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BAC433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358226105A
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 16:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhKGQab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 11:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhKGQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 11:30:30 -0500
Received: from mackerel.carobme.de (unknown [IPv6:2a01:4f8:1c1c:4990::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354BC061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 08:27:46 -0800 (PST)
Received: from mail.carobme.de (pd9512634.dip0.t-ipconnect.de [217.81.38.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: mrelay)
        by mackerel.carobme.de (Postfix) with ESMTPSA id 4HnKR42MzdzFVVf
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 17:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaddrinuse.net;
        s=thorn; t=1636302464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkN7UXfHwaBTs82jWaeDJvbOQjuw7WrcJ04A0tSKGCQ=;
        b=SPfXSVBNEjkHB5uSvTsc5ZZH0OaTMe1qF1p/C6pm1iLY+IqbT0gQw0FU3VJbLrOhypEHKv
        48k14uLDbehEufZV9wH0ErdNjUAHKXJ08jT3pO+pF0E0fvM33i5ZeBO6BFge0zNnIJOr5G
        Qw9SFR7Lg6U0qM10tF+wBWKGnbOGOjPWr+QqueG87zkTT8H2303BqGY/PMdn7Dvy/x7HGS
        DKpq2UIsCZoQUKomBFnEfdEt4V4AaWgIqy+j3MmllKRPov4gvnDyQ5XL3wTPW0+ShwvGp1
        HLPrrDvPzgHjHhAouZ8kZWDDOZBdhat8vOtHaKoUkF1nJ2yZuWA47zSu0Gs5Eg==
Received: from octopus.int.carobme.de (octopus.int.carobme.de [192.168.78.3])
        by mail.carobme.de (Postfix) with ESMTP id 4HnKR36dClzXRQQ
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 17:27:43 +0100 (CET)
Received: from mbeck (uid 1000)
        (envelope-from mbeck@eaddrinuse.net)
        id 7e228a
        by octopus.int.carobme.de (DragonFly Mail Agent v0.11+);
        Sun, 07 Nov 2021 17:27:43 +0100
Date:   Sun, 7 Nov 2021 17:27:43 +0100
From:   Marco Beck <mbeck@eaddrinuse.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Message-ID: <YYf+f4DOtILHSNoX@octopus.int.carobme.de>
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g>
 <YXXMroOBvDERXIMP@octopus.int.carobme.de>
 <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
 <YXZpyWesc8VRWYwr@octopus.int.carobme.de>
 <bc6b915a-7aa0-298b-e1ec-bf548e4dbdfc@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <bc6b915a-7aa0-298b-e1ec-bf548e4dbdfc@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 10:46:56AM +0200, Fabian Stelzer wrote:
>
>If you insist on using environment variables there is:
>GIT_CONFIG_KEY_<n>
>GIT_CONFIG_VALUE_<n>
>
>https://git-scm.com/docs/git-config
>
>A bit clunky in my opinion but you can set any config variable via env vars:
>
>e.g.:
>GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=user.name GIT_CONFIG_VALUE_0=testing

Works for me, thank you.

Marco
