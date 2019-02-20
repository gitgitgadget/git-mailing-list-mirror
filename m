Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9DE1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfBTMxI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 07:53:08 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34782 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBTMxI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 07:53:08 -0500
Received: by mail-wr1-f49.google.com with SMTP id f14so25925741wrg.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fWiCd5m2wN1yucnSXfg1M9v2YQWMxnTvTETdiyNhKw=;
        b=gJR/p4KactYdhPd3M/anz80dSZnDcGNQSSm3bsgV+0BAzuSCXvzt8ywYWzh6+Lk2Wr
         TtsLiR0f4v3Rk9V2s+ud3r8G5AIzUDrZ73EXBhkJJUgla5ke3Op9Xn2zgj0/QX5Wlk3I
         Bfm+dMJLs4ihdNQD4zyvVPs+tfLdDrRydmbzgtuxriv0YnmfrAGcPL+S6QnhQlFwxCJD
         FUlOFRhJSHfD5TACn7lfhwZO8mHtsCz6NTZ4IStqqszOWuo3zc/cX6PYLUCUOUTduV/C
         xxBsc7wMlSnY9ClO7+4gLfgluM66qODGCNzBdnwmwSUF2SItwpaV2So5FbrewwnpR5cB
         xI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fWiCd5m2wN1yucnSXfg1M9v2YQWMxnTvTETdiyNhKw=;
        b=kLGT3PdxYlGgPDalbl2xs/GD82oClFMEyC+M/CQ3lXJxtH/XhjDEnjD20BBLRgRfvA
         XW6FaQROaYyDyn8ectnZwPMaZT6mJ3+VLch8rFUgJ8113ueb9xxW81U/HmP4Pw2+rPQG
         XktgHZnsuebhkKPdkVf0phbgwhsGb8JW3EtQGdQIC0zNGoUCSwyxpJq5mpku0pqYIuG3
         1uyjnk910KD/Y/ZgYOZYzKkqNSfE8K/maDIi6bHoldIaXcmY9IZseFelAMSB5Ff7Yrls
         kQankMR6PRXQCEAHp27ylYVxBRz175p4xXEe4TwIdIUXFzLnvFkba7Euv9xIR7Bq1fv/
         nrpw==
X-Gm-Message-State: AHQUAuaqmcFjsbxK1rCC61dj+7HGAs8vce6MhkUjWs0DqXKT6R1vGeO1
        KjZCVFYY8PteVv/WLqe5p4Qp7PDH
X-Google-Smtp-Source: AHgI3Iavdp5eB8XeXdaKhjp6M0s1QKWK7ssNa70u7d6K/c0bu0FH58OT9J64x/ods88fg4G1X9+pJA==
X-Received: by 2002:adf:8447:: with SMTP id 65mr23417047wrf.328.1550667186256;
        Wed, 20 Feb 2019 04:53:06 -0800 (PST)
Received: from szeder.dev (x4db9774d.dyn.telefonica.de. [77.185.119.77])
        by smtp.gmail.com with ESMTPSA id c2sm11314466wrt.93.2019.02.20.04.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:53:05 -0800 (PST)
Date:   Wed, 20 Feb 2019 13:53:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Breakage] t0021 Subtest 15 v2.21.0.-rc2 on NonStop.
Message-ID: <20190220125303.GQ1622@szeder.dev>
References: <000f01d4c915$9c4c76a0$d4e563e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000f01d4c915$9c4c76a0$d4e563e0$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 07:12:49AM -0500, Randall S. Becker wrote:
> Sadly I have to report that this subtest breaks on NonStop as of
> v2.21.0-rc2. It succeeds when run with --verbose, but not without,
> making this difficult to diagnose.

That particular test is known to be flaky, see:

  https://public-inbox.org/git/000901d4bf98$1ab08fe0$5011afa0$@nexbridge.com/T/#u

