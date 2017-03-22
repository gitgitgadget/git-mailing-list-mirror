Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F2C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760031AbdCVPRA (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:17:00 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34362 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdCVPQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:16:58 -0400
Received: by mail-yw0-f169.google.com with SMTP id p77so129759058ywg.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cm6j0iT29JVdT4OhuejLsTvdozSdMIKOgwXKz3lRcqg=;
        b=Asw3mfE1jEbnTC56vVg3EEu7N7HJb5cKVVBijgjEsrbs6IUcUgGgFh2DvaOzo846v0
         vbHtAAD+M+HW7ENtW+z5Lv0C+fyD/CKfC+Uuhp9afhTGa8skTTHKgjEaMujg0T9IG6+M
         K8PhUxldrNL+/jpd5jm5Nc5z59X0zR0yVapNW+XHKzWqUa6MQ7TiNdFckpUB/nP4Lh7L
         LpzUiVAC11G3HFIoHY1WPoJdAJy/8FwpB9h/TmiSgqE4gsy0X4QYBp61+awwTjwl0L3T
         EMALi3G71wXtuulreQ0g4RAdZJZe8dgUGy3U4k1TPfK9IW+ES83UFswdmcyJi9og25Ha
         w8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cm6j0iT29JVdT4OhuejLsTvdozSdMIKOgwXKz3lRcqg=;
        b=nZ2zB1dCvrxB9Lr73zD4JslBdUEgt2sFDWAisGtRnnfwO/lVJEoDgId22KSN8fApXX
         v354rhRxFw0o/ciDq0/n/vWEBZXfkj7qQt1x7eMFCmHfYtlCos8mWR5f37FUhzakWqWh
         2dUHayfPMU/9IuBZFzAzJrZEZR+n7z2w190CDFvMy/fYD1y2Lv6a8oNI70a7CaV2nSB+
         +IntBwcpICyDVHRp+3qCFPG0u67MMGOEDi41C9EyjYnLT48KGQqW92diUptXX8xiBzCf
         P6bXNbKI4CsilbAbyQ8ELmJhvrRjo2XXhiTkKfHRbJslG/ObQIOOeMfuIW1ekDC97PwK
         22cQ==
X-Gm-Message-State: AFeK/H3qscIu6F1mBj44jc43b23e5D79VWvaBESLPMZmTOLIYoPmNBMaRLWbUv2FA3/4sNek/sdfC1cbG5PpGw==
X-Received: by 10.129.175.27 with SMTP id n27mr12265487ywh.229.1490195806570;
 Wed, 22 Mar 2017 08:16:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.172.32 with HTTP; Wed, 22 Mar 2017 08:16:16 -0700 (PDT)
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
From:   ankostis <ankostis@gmail.com>
Date:   Wed, 22 Mar 2017 16:16:16 +0100
Message-ID: <CA+dhYEWo3v+ns0zt_hWu-7i-=E0g_tFaXYcv7Q0j2ozx1SCVmQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     git@jeffhostetler.com
Cc:     Git Mailing List <git@vger.kernel.org>, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        markbt@efaref.net, benpeart@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Jeff

I read most of the valuable references you provided
but could not find something along the lines describing inline.


On 8 March 2017 at 19:50,  <git@jeffhostetler.com> wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
>
> [RFC] Partial Clone and Fetch
> =============================
>
> This is a WIP RFC for a partial clone and fetch feature wherein the client
> can request that the server omit various blobs from the packfile during
> clone and fetch.  Clients can later request omitted blobs (either from a
> modified upload-pack-like request to the server or via a completely
> independent mechanism).

Is it foreseen the server to *decide* with partial objects to serve
And the cloning-client still to work ok?

My case in mind is storing confidential files in Git (server)
that I want to publicize them to partial-cloning clients,
for non-repudiation, by sending out trees and commits alone
(or any non-sensitive blobs).

A possible UI would be to rely on a `.gitattributes` to specify
which objects are to be upheld.


Apologies if I'm intruding with an unrelated feature requests.
  Kostis
