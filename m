Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0390A2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755205AbdCTNYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 09:24:23 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:36125 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbdCTNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 09:24:17 -0400
Received: by mail-ot0-f176.google.com with SMTP id i1so132008065ota.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zc7VcMS5BH3YL09Ho+eO8DnJA2zGnSwhrmdHC0dKEsM=;
        b=iq44i1KgymlwTO8w5vOZCjkomWGdt2J25ubnsvOg3+cewrhQEolNxeS/z98Cyz/9kQ
         KFmNZehNwgDaa6Rbni8j8Qp+9A6Q3/VOVKkZcq8OKLd/fZ5AN/fpOjzL/RUrdoOYCNYQ
         OnVRJQSrZSzebKzIi7YvDjkfvSW/8O3UunPQ7WokUqfzNfP+o6RFYxuLdTgbBygOTuvv
         LLp5N2BVCW6yidrd+Re67mzro7hxR2ZjZweDBO3OgJv39dORiBt4cZygc7MLA9trLc3U
         rBg+RfTGoOYfTCruJr52NaO1VgWaJTpucTKEC3PJmHNr9ki4gJPwjkgjhDH50nKd4iEl
         9y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zc7VcMS5BH3YL09Ho+eO8DnJA2zGnSwhrmdHC0dKEsM=;
        b=XMHb/wvsdkflHcUPfNnl1zIbPOvxnbOAqpHzMGYEX9NG3IizCHCaOMZP/u/ta926Qt
         uGpj1dPRF5vOOLnG8qnDFugjc/r1x3wJdAQF7p80Hn0a4mp0D0MzKFqeeW47UetzE7Rt
         tGstDwKRuphIaRS54wMow0Ej7bLX0u8nC/OPltQVtAOtZ/3H+7CxaRQCW4BZ5zx7Fovo
         EGPpvfNAPsOeOErr6phd3VJRZdCA9i2sdDRcUt4iK8GVTwHHIdWkBuOKanWUsKj5NmgP
         o/zGvGAsMzkGuVC7Vs19F43LdElFYtFJn/FZ8tPfUt4VRQuOScqQsDHnGBBthumrN0sZ
         BzYw==
X-Gm-Message-State: AFeK/H2HHGZPYDWMzfquVIzxjQCJorjrEzcXkcYPFpvte3YnUfFjdwnGtxTt8rGsA91fhI2aLRzOpnuHkVzvmw==
X-Received: by 10.157.25.18 with SMTP id j18mr14512334ota.128.1490015691164;
 Mon, 20 Mar 2017 06:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 06:14:20 -0700 (PDT)
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 20:14:20 +0700
Message-ID: <CACsJy8D1ZjO1pQJv2TmoYDyptyvhEfrcK=RMSeJE5VPG9=Jh0A@mail.gmail.com>
Subject: Re: [PATCH 00/20] object_id part 7
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is part 7 in the continuing transition to use struct object_id.

It feels very nice to see many ".hash" and "->hash" go away. Looking
forward to seeing you kill sha1 in sha1_file.c, object.c and friends.
That one (and read-cache) must be a battle.

I'm not familiar with many parts that this series touches so I may
have missed something subtle, but overall it looks good to me. Thank
you for working on this.

> I chose not to rename the sha1-array.[ch] files

You'll have to rename sha1_file.c, sha1_name.c too and might start a
code reorganization revolution by renaming sha1-array.[ch] ;-)
-- 
Duy
