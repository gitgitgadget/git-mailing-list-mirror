Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B3F1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 15:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeAaPBM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 10:01:12 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34156 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeAaPBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 10:01:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id j21so8851805wmh.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ud/yVUlychgPYszToRyHWIpuot465fVn3d0IDk9+RoY=;
        b=eeX4Fktw1G4/QZV4shocBrg4LDUuX8j2iJ9c1RtHOCd0CKwLuS9XUdGwTsXdgivOpf
         Xqcq19Z+RgcdPLl6HueE/oA7vqlfVGMQgWyfG0QstrVI4q/+Vsv7dYxMMLgdadTTinBt
         BS+pqoj9tDFeNtpI0u/emoMNlLE4h5ORVnjXnMrYK3EJvM+yhDzizlh0ANpQkoQ/8MaQ
         hCuG+NiRt2hFLeDnigeEwh/vxlNAF7heX5/SWXEN1aYPz6yku+395wi8itMZVDwm4jSB
         mVia8EA4bgDFH4bt4FPFM7W9gWbatiZkitHHdJlgwptol/AhvkUnJf9srW3T7eFwqPQn
         rRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ud/yVUlychgPYszToRyHWIpuot465fVn3d0IDk9+RoY=;
        b=ZHiSzF3uF9ilS9KPhdR+9oXYQzoRAjmauhlPm5WfV0p+PzBGSjgPr9dXIbcIL8Zv8s
         5xiW0c1XX0aRqyyoyaLKen9H7fZOcS6SDR3GbFjc+ewz3IwE6VUMACd7jmzOaphmtO3D
         IzcF7IFTiLQgyYKvyC6zv1keFV3/zvvRwyaPYEWX1xQPqEUaawbnWpbwIAHS8kSykpBk
         I9XnCERia5ecn6qSCBkkN5ZSriHOJpUHYEC0G3iGWXwwjP1mEXx6+JGB7Dwc5d4slUxX
         7QWOkL10ODnAfj/O31WHs+l1DiRe1GmTWGk9yod2WuBp5LoSfPXT0YGebppP/NYfbvPC
         /o+g==
X-Gm-Message-State: AKwxytcRQx+Zd5tJ2jdPLETnvHSX45Rh4Nw0zMRUdKouYCcaZBgrzLP2
        lIORDKjG5Im0rsLq2y0BKYZYRE0T
X-Google-Smtp-Source: AH8x226IzEmlPAkcCi8wx1BNB9tKqdsCb4jGtXoBPt9KhddssnrVB6ZIvFoWlOkaq7Bt4gWC2+B56Q==
X-Received: by 10.80.171.165 with SMTP id u34mr9834145edc.167.1517410870011;
        Wed, 31 Jan 2018 07:01:10 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 15sm9919416eds.54.2018.01.31.07.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jan 2018 07:01:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/41] Automate updating git-completion.bash a bit
References: <20180131110547.20577-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180131110547.20577-1-pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 16:01:08 +0100
Message-ID: <87po5qm5sb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 31 2018, Nguyễn Thái Ngọc Duy jotted:

> I posted a proof of concept a while back [1]. This is the full version.
>
> This series lets "git" binary help git-completion.bash to complete
> --<stuff> so that when a new option is added, we don't have to update
> git-completion.bash manually too (people often forget it). As a side
> effect, about 180 more options are now completable.
>
> parse-options is updated to allow developers to flag certain options
> not to be completable if they want finer control over it.  But by
> default, new non-hidden options are completable. Negative forms must
> be handled manually. That's for the next step.
>
> The number of patches is high, but changes after the first four
> patches and 33/41 are quite simple. I still need some eyeballs though
> to make sure I have not accidentally allowed completion of dangerous
> options. Details are broken down per command in each commit message.
>
> If people want to play with this, I have a script [2] that shows all
> completable options for most commands (I ignore some that are
> shell-based because I don't touch them in this series). You can then
> do a "diff" to see new/old options.

Thanks, looks great to me, especially caching the result of the
completion.

> There's a small conflict with 'pu' because --prune-tags is added in
> git-completion.bash. The solution is simple and beautiful: ignore
> those changes, --prune-tags will be completable anyway :)

Yay! Also another good argument for this series, it took me until v3
until I noticed I'd forgotten the bash completion:
https://public-inbox.org/git/20180123221326.28495-1-avarab@gmail.com/

> parse-options: add OPT_xxx_F() variants

Not directly related to this series, but my own
https://public-inbox.org/git/20170324231013.23346-1-avarab@gmail.com/
which I've been meaning to clean up and re-submit also added some new
macros to this file.

I've been wondering what a good solution is to avoid a combinatorial
explosion explosion of these macros in the longer term, but haven't come
up with anthing.
