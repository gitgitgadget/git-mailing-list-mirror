Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED0A201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 05:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbdKNFnH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:43:07 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:48149 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdKNFnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:43:06 -0500
Received: by mail-pf0-f169.google.com with SMTP id r62so1046213pfd.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 21:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=RK0ZKRNHuYBdt43rXu3tLHiPRTNuX1y+97FRFWykC4U=;
        b=KuH5q2dgAjHHJ4bsfH6r1hTc7VWh7ogdS/vEAcOBJU04Io6mr+dKWJOYQ/mHi7C5a2
         blBkC9m+rW4QNevH5eL7eo99pyAeY4yVUQCXjPXkGDHmwEhRWXfQxTR7YI1By294p8nq
         95lDHHHV8ubFTG2EEMj7aF83cJdJuvBmlYVMNz7VEmRAJGMQ0ajwtxwbNQyzFgIF5K/E
         dgfZ9GIiRcl4ArIhpyiiNosZVj39q07uPrp3FCcF6QczBHU3NrpdsWFf+GkhBL/u3bzp
         LcRdueDaiQZfNhOc5Ql7TIElh1+887j+aU4XhEEIA/8NVYlXVPreesyn4BGX9mFph+Zt
         6pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RK0ZKRNHuYBdt43rXu3tLHiPRTNuX1y+97FRFWykC4U=;
        b=d0mKQpzuBhfmrN8Vv+NH5MkxYCAUSwPTeONWb9qR/eMcTDlrvJAcc8lwFMHdZy4V7K
         MrMNb2QL4xToWKT65eRdP6J8vi1ZTXlvuCXM4468aYkHAnOhoJ9kIdMcVXz0T9X+QHXj
         KhazWM1sUdjqAo4ij9kBD1yxKh27KVE/B3by2d3UR4VcFfsg5n1VrzAMv6t0lLhvfSd+
         ZrDvNCIP07EkduwfLdRRoUDvWcqgkIXlYUwHznGPk1ElOYVHEDBjHqRoXkwQ8TTRXbgf
         YNd8y0AXHMAfh7gD/DX9anN/6F2fhvd5dluN1VXT3MpRndzTEnEUNXjFcX9QsN/kxYgn
         697Q==
X-Gm-Message-State: AJaThX6yS3LbE8TGzdorpPhAiENJkEUkc+AZvLaWnp9jDO3dh/9gwfu+
        MSksQH0yI8wTKqvZsY+krGn9LVNR
X-Google-Smtp-Source: AGs4zMbs74U46kXpx528IuZG6VDQVEcl8kVtsG+flp3L5T+pL8Q2aURFAV8f1mqGDHilprUUsSLkcQ==
X-Received: by 10.159.194.204 with SMTP id u12mr5424830plz.191.1510638185236;
        Mon, 13 Nov 2017 21:43:05 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:2f84:b67d:915d:8353:ad4c? ([2405:204:73cd:2f84:b67d:915d:8353:ad4c])
        by smtp.gmail.com with ESMTPSA id h70sm35304971pfc.88.2017.11.13.21.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 21:43:04 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2017, #04; Tue, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo9o55xny.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <5fce2d3b-c8a9-765f-46e6-a2bebcac875e@gmail.com>
Date:   Tue, 14 Nov 2017 11:12:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9o55xny.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jc/branch-name-sanity (2017-10-14) 3 commits
>  - branch: forbid refs/heads/HEAD
>  - branch: split validate_new_branchname() into two
>  - branch: streamline "attr_only" handling in validate_new_branchname()
>
>  "git branch" and "git checkout -b" are now forbidden from creating
>  a branch whose name is "HEAD".
>
>  Reported to cause problems when renaming HEAD during a rebase.
>  cf. <49563f7c-354e-334e-03a6-c3a40884b6d0@gmail.com>


Just wanted to note this explicitly. As I'm not aware how the problem 
with above series is going to be resolved, I've decided to stall the v4 
of my series that tries to improve error messages shown when renaming 
the branch[1] until this problem gets resolved. I'm doing this as this 
series and my series touch the same code paths. Furthermore, I based my 
v3 off of 'next' when this series was in there.

I'm not sure if the resolution to the problem might introduce conflicts 
with my series. Hence the stall.

--

[1]: 
https://public-inbox.org/git/20171102065407.25404-1-kaartic.sivaraam@gmail.com/


---
Kaartic
