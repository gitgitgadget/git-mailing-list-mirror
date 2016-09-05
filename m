Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36D71FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 18:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbcIESDa (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 14:03:30 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37411 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbcIESD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 14:03:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id w12so53667919wmf.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a4qobqYBRD2m/6QM0IZ94wb7kHNqEN1SFGnFYeAacf0=;
        b=HEGaT4sr/ignLRCXMmExPA9YPhjd49V2qVIXbygsrSEdFAlIPydY2D50kPhFhfibT9
         EIWVLhvjrgtwk/8AY1Ee6RXBpsaEy+evxT5TNHcvrihtEVps8ClDOJgE2e5fH286dieZ
         MNN+3AgN3O+OEPUEeOd3PobpNmXbS5E+HpBR0r/DPZIJ2P0HexJo4xGty2XomD9ypyU8
         07aZ9IWFZbx+Y90M0IF7eRDl2VvaqtursB3vl7eYTLQlEr8r1jUEznHLtIL+/CVYz80I
         Kz3KA4BPSpodpsmHCv/5i/bJ1mQpIqrl4KCOj/o8GfnPZLT9DPDAKk40y1vg/n1YGlpG
         lgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a4qobqYBRD2m/6QM0IZ94wb7kHNqEN1SFGnFYeAacf0=;
        b=dDcGJ737fx6p06qoWWln/xF9brF+nGD9JC3njhdNYZqPdV6+92TQnA4LRSQeYK1MA5
         nApJMxhhSz4qlofw5XDS3U55QJCdU0TK4vX7tpdrQ7Ly2yKKBIFri4b4gOBmnRG7x5yg
         INd2rNXID490Qqla9DNKr2VGevk0rLOxbgB4LnObJAdL3CepcewJoAiBk+GUPzKXFISD
         nYkoRYLVu/mL2Zo7AGCyWh9WZXiHbgWVH2XIIlsXpwW0hou2v+ZqiCBflUMVlKE2N0p+
         mWu7qoDbkUkjBWEzDmHWmE1JEjzH72X69vrQYrnHkdJ3TRCfZCsfWn8YLWbDoz+JDMy9
         SRDA==
X-Gm-Message-State: AE9vXwNh6iWTwgPtHwhFeRFnMbUOss84of9gBBag3J3ZZM/kATeCzDk5n+WHZ22GmtH1uMUuBvfyTcGANgHFEQ==
X-Received: by 10.28.105.65 with SMTP id e62mr17227143wmc.99.1473098606724;
 Mon, 05 Sep 2016 11:03:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.225.6 with HTTP; Mon, 5 Sep 2016 11:03:26 -0700 (PDT)
In-Reply-To: <DD45D15018014CB483E07425A5E4072E@Yasushima>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
 <32ec2698-7730-a088-6a76-ec6f2d379987@gmail.com> <DD45D15018014CB483E07425A5E4072E@Yasushima>
From:   Satoshi Yasushima <s.yasushima@gmail.com>
Date:   Tue, 6 Sep 2016 03:03:26 +0900
Message-ID: <CADiQsSbOgU+VhbppwfbSm_pzGAcu=v7wepkeZZ0uuC-rsPjprg@mail.gmail.com>
Subject: Re: [PATCH 1/6] git-gui: The term unified for remote in Japanese
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Sep 2016 2:16 +0900 Satoshi Yasushima wrote:
>But now, doesn't make empty string by apply msgmerge this commit.

Oops.

Now, I was a rebase work, msgmerge changed with empty string.
Hence I think this commit keeps with empty string.
