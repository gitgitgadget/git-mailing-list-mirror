Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B8F2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbdCTM0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:26:25 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36176 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbdCTMZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:25:56 -0400
Received: by mail-ot0-f178.google.com with SMTP id i1so130950061ota.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OH36GHAuIxugIr5IP23Ag11klcTgrnbd9R6cl5LYTPw=;
        b=IFkbtyXjOSR3julBEuKfP2JQCV8cG/Xzyn6mF/9eswWpmMlx3ccp1mz+clXmebVmgC
         VuR/Mw5pfoMTx+BiIzCe/MN69JP0iYciW9OT8cbPO+sKF84a9xdKsaAUzDyFsXVR6xKn
         OsGX3FVa6r4U95yJk7AUCE8T5W5Kt3+ds/Miw0RY53ooKog99CYJD3/A+XD+jp1ipqf5
         wTPZmYOLUBuO8XKW7oWN6/EIXTtJ+6Q2kvDucjK19mERStjSO/FmYv7F7JdcJDLGiAMS
         lMNoMZz9h/7wCCHtk99BHruE9CJmCN4tcecMit+2Lw//PX4Wdi5oKJhzOfPk0EDvLRXJ
         vEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OH36GHAuIxugIr5IP23Ag11klcTgrnbd9R6cl5LYTPw=;
        b=BpJ6TGfK4Zz+Rb/E1Ks3HkvwbTxojR1jJ/PoSW1YjS0itTFYZxVJ2YlF3mZnPF+9vm
         +WjnO/1/5rbriPFMuRCczdrf+LWvqOapZ0PDaOpciVUNn8ryqLxNcwIXTgDcinsNWKtz
         XN98kV5lM4PcrgkmCW/585mNJqG2xyUJC1mLgRo0CSDn5MEC0JHKRPR7GbEMpe1lWY1K
         rtKHWDKyKhm2uaeb75wteyRHovFW7IRhyZXagjo21oldIK4yCa8jlwTC2eqOWb4oZrsH
         TAh4Lq5pfh/sXlgyhInbYdv62V6vzF6xvrlTzGbPlSl4bH5z2J3h1QhpSsGInwPVj9ck
         f64Q==
X-Gm-Message-State: AFeK/H2eQLqcMpAsHr8s/aV8ugmuQRgaSsII+Jh9fjCN+jZ/waqdiM6aWKp2sC+JxqkiUnL6dBkMMRbF0h9vEQ==
X-Received: by 10.157.46.26 with SMTP id q26mr16789939otb.28.1490012755611;
 Mon, 20 Mar 2017 05:25:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:25:25 -0700 (PDT)
In-Reply-To: <20170318211954.564030-20-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net> <20170318211954.564030-20-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:25:25 +0700
Message-ID: <CACsJy8B1HhSWBMThoiy_F2s3T62nwNAO-Hd9E+d9k82Y=Ku+FA@mail.gmail.com>
Subject: Re: [PATCH 19/20] Rename sha1_array to oid_array
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since this structure handles an array of object IDs, rename it to struct
> oid_array.  Also rename the accessor functions and the initialization
> constant.
>
> This commit was produced mechanically by providing non-Documentation
> files to the following Perl one-liners:
>
>     perl -pi -E 's/struct sha1_array/struct oid_array/g'
>     perl -pi -E 's/\bsha1_array_/oid_array_/g'
>     perl -pi -E 's/SHA1_ARRAY_INIT/OID_ARRAY_INIT/g'
>

I see a few multi-line function calls become unaligned because
oid_array is one character shorter than sha1_array. But I'm ok with
that, no need to manually align them. We can fix those when we touch
neighbor code.
-- 
Duy
