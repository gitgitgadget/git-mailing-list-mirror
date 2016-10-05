Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DFD20987
	for <e@80x24.org>; Wed,  5 Oct 2016 19:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbcJETVB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:21:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35101 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbcJETVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:21:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so120603wmg.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Q/PGnCcdi8N3do5dO6kFEHSv1sm3bvX0TUNXkuQvTYY=;
        b=EVbe92jFem0pF+idrCyK3Lg5zXKi1ZThhU2ybgfdMog6rojacGIiE4SDi0lmEfrjag
         Npd+ra8OsFrOxvrGGsoOcy5GyfvZEzkHVV5TDmH2HrFkdMsjJJkyayABA5BRAcVLph8W
         HGtTbYHANzlo+OnVR1StUkRZUN8+VWsYSAOBbuqqHtDxG74eqzabbnVqYLcjFLIKnT1I
         wIOsKPLoSckKgp1KnwLJ+n40BKGOWJ+CYqKkR8C8fCK+qs5oIQef17oOKvl5cmEyt10y
         dZAQnuXEoGwpbwj3r3RN32zH327JdCxhxWpBJOdlYzpROE3V+frCG4+5WsGyiPY066fn
         VdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Q/PGnCcdi8N3do5dO6kFEHSv1sm3bvX0TUNXkuQvTYY=;
        b=Y1qcWOYc2HpCxkXFchiZpTiy2MCDu1GMhB83ZCGXUXHrpguGHYpRO3SzfO35PbfwLz
         veGouDRX9h0SuXKes+wTNMIJuU2VI5zWfDdLo65vxyhM3PUquLoSXMyZFuq1T7Q8h/oi
         12xplYyNy1xtMo4aZvEGG+X6hbM1uiQtWEYA1/DUgv0c1FzqVHi4o4LaM42HhFHcTSoJ
         sz/qocei9CFc+6mLov3T6CAjQC7HcwDzKl9N635GXm91AKJv7xr1RGwkT2g0z3AMceNl
         A+MFEyJeYO1FbwbK5uwd6DpNZOWQL9GeBSAxn3B0wCSfWRNZpgcugME42Sb1t9ndQP8U
         V48g==
X-Gm-Message-State: AA6/9Rmwfo9PwWmb/W7bDqOL/9dG7+cURjs6L3zKhI986HOLmdUESn8BOSLlUQsxUmvOiQ==
X-Received: by 10.28.210.21 with SMTP id j21mr10997912wmg.74.1475695258694;
        Wed, 05 Oct 2016 12:20:58 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id wh3sm10390460wjb.49.2016.10.05.12.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 12:20:56 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] Export also the has_un{staged,committed}_changed()
 functions
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
 <cover.1475586229.git.johannes.schindelin@gmx.de>
 <017586232230ad87dd7cde5801e011cce9255bc0.1475586229.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e5f0ae3b-c65a-4cd0-0726-23e7a2985b5e@gmail.com>
Date:   Wed, 5 Oct 2016 21:20:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <017586232230ad87dd7cde5801e011cce9255bc0.1475586229.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.10.2016 o 15:05, Johannes Schindelin pisze:

> Subject: Export also the has_un{staged,committed}_changed() functions

s/changed/changes/   that is   d -> s

Those are has_unstaged_changes() and has_uncommitted_changes().

Though I wonder if "other has_un*_changes() functions" would be
more readable (while shorter), if less specific...

>
> They will be used in the upcoming rebase helper.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
[...]
> -/* The following function expect that the caller took care of reading the index. */
> +/* The following functions expect that the caller took care of reading the index. */
> +int has_unstaged_changes(void);
> +int has_uncommitted_changes(void);
>  int require_clean_work_tree(const char *action, const char *hint, int gently);

Nice to see the fix in comment too.  Good work!

-- 
Jakub Narębski

