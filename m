Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BF720958
	for <e@80x24.org>; Sat, 25 Mar 2017 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdCYLzC (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 07:55:02 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36514 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdCYLzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 07:55:01 -0400
Received: by mail-oi0-f41.google.com with SMTP id r203so5860829oib.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 04:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvmhtGq0MaxqEnSYGJVyfOPfxbWEYR02Bm5Fdn1hgYs=;
        b=CTzZy4ZqMmn+LzJoGALi7Ovp/b97N32Co4RW+attjOlemr9iYGsZIer3Ubs23qfG4W
         wyEze1YayqeDGVH8KtBicLd1OS9UEx8OLk5Ca4Q0kXygYGEdIlKENSzZemmdiW6QTxo3
         nZzzItOqXS9cDojjSaLgCkY5t6PoiYiKhhkit8Z9mh1QJJp0MWNsXgWlfOHj3HWTGwPH
         FhQ8VGSYf9HOflcK+K30R0Il5WfWGKJYcZM0ZSs/kqON2lVmY3LNqt0115ihDZ6MF2vq
         U+jq1teqfyLQ/tDhAQe+LSaHcQYacw3PSwZsXZWljS6BygOK4StqVRWy/6LZOpbD/F1x
         p7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvmhtGq0MaxqEnSYGJVyfOPfxbWEYR02Bm5Fdn1hgYs=;
        b=VoTfSWhFtQLr9Rc84g19r4Rnm397NJZ9IihTfcCsYSUvGPUJOLK0zlaxanawaNno7U
         lCxHmllxSEl44ucC0IDMTe/SVSlmWkfz5twat+aPTeH0JVD0bWn5akMXhyCxKwH8wLSp
         jRHG7fRIuYI0p0J3uXeL3k3kob+ifIPDwYAK4OUMIafz+/wFf1JWuj6AUybKSvlvnYz6
         b5gPVkcjqkbhq18i+cNMqqm8rth7I7mFuhR9eGYTHHeuaa2BkfyQLyRhyc1kV3fzV+YU
         UNHqIYrBg58CwE0gPsUXsTLsv8hNrI2Plg9kLmNItIsvPbCwuRYPebPD9HIXKketQgOj
         mTFA==
X-Gm-Message-State: AFeK/H0vm26HJapH+V4P8bSKgF9IM/zzYfWPPRKZhIeWbmTvqZ8cp0+joYuKyxIQcTS125ncVtuKJS970lF6eg==
X-Received: by 10.202.212.20 with SMTP id l20mr7275822oig.146.1490442442926;
 Sat, 25 Mar 2017 04:47:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 04:46:52 -0700 (PDT)
In-Reply-To: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de>
References: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 18:46:52 +0700
Message-ID: <CACsJy8B1DWL9uHPZoQEO+ytkt1M+qV-x0F5CWFLFSG1utxO9EQ@mail.gmail.com>
Subject: Re: t1503 broken ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 5:46 PM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> ./t1305-config-include.sh
> seems to be broken:
> not ok 19 - conditional include, $HOME expansion
> not ok 21 - conditional include, relative path

let me guess, your "git" directory is in a symlink path?
--=20
Duy
