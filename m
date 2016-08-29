Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E1B1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756741AbcH2JvC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:51:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33443 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756705AbcH2JvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:51:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so8754313wme.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=PpBS2TFQShrYYqnPSKYnSmqbt3LkX3f/mHzL6YwXq4Q=;
        b=Y6g2h8vijvXWcrlBInaour3meRBnHsYbpnGuDWziKBd/7ntzW6gs8F5OBqVjbbrAFH
         pUTZhhMGWbI+OhsWapgq3kW4pig7m6ZNvu/8lUIzQ9TkIpKbhf6qlAq75QXeRoH5JWDy
         TSb7Dc7HN1rCCRKs80DZtAWTORnD6dL5Ttryj0fXjznLdG9STmtzHGwU9R8xHgB0gYRs
         JP7HSMhLjuffC+QueIrMCsYIGPeR3moQc2YRu3JH13TMQ11ApKinypnCR3UlYc0NSqnd
         /dpR2OVDWe6j5J6YM9fok9/tOc/UA/m7robzD2r6k2qobllfxdWXhyArt5K7/HiW4u4L
         kcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PpBS2TFQShrYYqnPSKYnSmqbt3LkX3f/mHzL6YwXq4Q=;
        b=PBLDLfibhWVZKpZBXIIaZWOIGS9QyCUHR7nQRo2VG6eAuuHCSE/Qmpnk7MJoQSvNwF
         MOtwRJ6HKGLifBH0nDq2oG1I+p6h7Aim2eLTuhncWYhd2yG++hbYRDMjiNIc3CYrlevt
         50kooz/jdqmJrqG/Z/4JoXymszDXjc5bWGwvuox/ukwg0PRJ/hkhIVdMmGeapP66P+fK
         AuJkwZdex6ifk1QcoWhAumhUCTt1lyhARFfJYguh3+el4DHtcpLLeM1GUApY0AtXyYnK
         Hz19NwAB5SQQHjnEcUDXWCQBkgOsTPhSQdVtKV9Q8O+Q3sZR9qicNfiOJc1ezZxVyQjw
         GbTQ==
X-Gm-Message-State: AE9vXwMGomtg4I5LqRNpRdBw5tVLZxTXVwHiikiio5WJz4JubX6NpyUZJKFQPwnZ5qD2xA==
X-Received: by 10.28.168.83 with SMTP id r80mr10390272wme.44.1472464259278;
        Mon, 29 Aug 2016 02:50:59 -0700 (PDT)
Received: from [192.168.1.26] (abpp123.neoplus.adsl.tpnet.pl. [83.8.57.123])
        by smtp.googlemail.com with ESMTPSA id g7sm33552554wjx.10.2016.08.29.02.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:50:58 -0700 (PDT)
Subject: Re: improve 'git pull' status message
To:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
References: <276561472461862@web6j.yandex.ru>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <88ad64e4-9c46-e3a9-7583-4556ae2ce1b3@gmail.com>
Date:   Mon, 29 Aug 2016 11:50:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <276561472461862@web6j.yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 11:11, KES pisze:
> 
> When we do git pull -v --rebase
> 
> We got this:
> remote: Counting objects: 7, done.
> remote: Compressing objects: 100% (7/7), done.
> remote: Total 7 (delta 5), reused 0 (delta 0)
> Unpacking objects: 100% (7/7), done.
> From ssh://slab/alexclear/ontico
>    2b541e2..2c17d76  master     -> origin/master
> Changes from 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7 to 2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08:
>  xxxxx | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> First, rewinding head to replay your work on top of it...
> 
> 
> That will be better if this
> 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7 to 2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08
> will be replaced by this
> 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7..2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08
> 
> This will allow us to copy/paste this string into 'diff' command
> git diff 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7..2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08

You can copy the fetch line, "2b541e2..2c17d76", it is
the same range / set of revisions.

Shortened SHA-1 works as well as full SHA-1.

-- 
Jakub Narębski
