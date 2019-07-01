Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3181F461
	for <e@80x24.org>; Mon,  1 Jul 2019 15:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfGAPFB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 11:05:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43044 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfGAPFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 11:05:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so7487460plb.10
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52u+Ls+p1TE2S4GRVz0lBBWLWrd+6d7SF0SBHqKA3fc=;
        b=DDZd7DdwlY+Q66a9lVMKNJC3aRN1kUq5BrsGTvaJR0aB7+B/LzgPJynknikaKAiNfS
         FepCtoyxKcn3wTxdwGro/nqYu8xb5dct4tmEgla+cJLCDt4fjpw0g3TaE+3dWiuaQ3fj
         JBBNhejMHSJb98DetXNe+XMTXiCIeK5uWYkOW2VEb+H22ya7I8sASxRXdVAm3K/AMIbq
         BJUA3X8s8+btcKUilvlLOqvStFDUUir5YlY6VAlO/obGOn+8oBYruEo+PhwerAxbgp8a
         UOpGniNAOBfzjfIM3xmfNT5fbhEn1ZQLmGbMF0lYbpQ2OMPbwoWHeFUmPVsPWjMrBZ1d
         s7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52u+Ls+p1TE2S4GRVz0lBBWLWrd+6d7SF0SBHqKA3fc=;
        b=fABsk10TDryqBGUI11ycYbsp5ZCbi2oCYWK0u7XWWRlVjB54Zgf36VZG4FVEpq6dXc
         hj5UlqK0Yv9y2N52n0N7G/XdTiAin1OfTCExhQsjklSSWkRxl3fhsro+9QWTFm30Sd1K
         jyfmnSeXNi//asHJvdIsmzcMS2VS0HkYDUEsYRRCr6oAQXCii7dclOxJ6HaL4HJ14VHr
         xfBVixc+gbRMfBRhxjgo2/0oyaPjtBKRl9CEHeniPkjjv2dRniydIm7345YELgBmGTpN
         23JfIyJ64n4X5doGNhQeJ8kgNvVM3HQE8/9l4gCg9LMs9YtpIhIBaxXRNMehIwpzq7ee
         7/yA==
X-Gm-Message-State: APjAAAXFTOUuKe7BK8T6aoGrdIEVU2XkdlwDVyTpubOS4qwh4jIjF3MG
        km92rrSz3JKC4ndQd7ITxaV0JCTnoFY=
X-Google-Smtp-Source: APXvYqzqvAREqtj0J/P3qSUGSOdjz6IUFWy+5PnvCGCcqKE6ovSoqACnOeyDhDnPSWefkHaW6wJEGw==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr29449470pld.174.1561993500252;
        Mon, 01 Jul 2019 08:05:00 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id d26sm12208350pfn.29.2019.07.01.08.04.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:04:59 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        t.gummerer@gmail.com
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
Date:   Mon,  1 Jul 2019 20:32:28 +0530
Message-Id: <20190701150228.18471-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Fri, 28 Jun 2019 15:17:42 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>
> [...]
> * ra/cherry-pick-revert-skip (2019-06-24) 6 commits
>  - cherry-pick/revert: advise using --skip
>  - cherry-pick/revert: add --skip option
>  - sequencer: use argv_array in reset_merge
>  - sequencer: rename reset_for_rollback to reset_merge
>  - sequencer: add advice for revert
>  - advice: add sequencerInUse config variable
>
>  "git cherry-pick/revert" learned a new "--skip" action.
>
>  Will merge to 'next'.
> [...]

Phillip[1] and Thomas[2] suggested some changes which I believe will
improve the state of the patch series. Please wait for a little while
so that I can send another revision.

Thanks
Rohit

[1]: https://public-inbox.org/git/4f69c62f-f38b-7630-cd8a-ec152a8b6ad0@gmail.com/
[2]: https://public-inbox.org/git/20190625091822.GB2423@hank.intra.tgummerer.com/

