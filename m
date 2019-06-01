Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4306C1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 15:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFAPJr (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 11:09:47 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:46577 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfFAPJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 11:09:47 -0400
Received: by mail-pg1-f176.google.com with SMTP id v9so5698395pgr.13
        for <git@vger.kernel.org>; Sat, 01 Jun 2019 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=s3gokkSnH71SUGXlrYdFEUD4+QhIsgPxWNsqIWWX4AQ=;
        b=TrgiXZjCizxZn6be/yBcRKhpVBQH9pUJyPysbQXfpWFPxroAFLtnNVgSNaXAi8+oDg
         7ErdU1Mh6cdNBCaK341h1dcTPDuSqFIrC02U1oJ+zkYs16ccySVRT3wngfTsPwE0Jiq9
         5FmDIaRm/jRv3WKGrR4H4lRRgDaLRl2ptQd3oO1RmtZmC+YMT4JNYkUUCb+CQSuOOACx
         A6ZAFbf/jtdgB4cqxVE8XPavfjas+gKfGTSoC1VpyPd/zt9Zn7y1huuSKeyjj03CZFY1
         PWXOXy17Q2hzDqxrbi17YwYGCcURLCKy/QdJH7hdwKy0hw7GcuKlyC4ro/ro81k1XZ2Z
         N8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=s3gokkSnH71SUGXlrYdFEUD4+QhIsgPxWNsqIWWX4AQ=;
        b=bhU31zMPjGnFu3HuTaPVgNN63Z9k1BUPneCPMgfIYqVE8c+augLEMXW3pf0GrkeyJA
         qzv0uvxizAiHSjSZK8h2Rktupd4Qy70YKF3oP0pJ0uPD3q1ygVhNloseQ+qLC3XLO4R+
         HFle80dWXkSBTczV9XkiE1mqF1f2Bzgb1EKWutLdbjqlmL3asmGWIq1e42qXOVuisdJZ
         YxgBCz9pRW0ZaWvLc5c/Gm4djxVV/W6nS/LrbEZLK5JL7Pqgy4VwIxfatfSLmbLzkbtY
         hmc79QDJg6xcM3BF6txoOeJLe92J3sMALY+y7NxIot7wS2iRPRfMSU5IxUhat8g5+nnK
         mEng==
X-Gm-Message-State: APjAAAVQWNvAPcVQhkfj0EVaNi2RS/gfiQgmWE79CaTQvuupKGvT464w
        VuMsqeXVJjDPmaDM9nLYOSQ=
X-Google-Smtp-Source: APXvYqw1UouP6ajUkH3udPLWqunVvcEnxRBraESHz75sZFmB/PO7JaIctG8aXTOsemdbEKZvzVUkvg==
X-Received: by 2002:aa7:9604:: with SMTP id q4mr10946106pfg.184.1559401786324;
        Sat, 01 Jun 2019 08:09:46 -0700 (PDT)
Received: from [100.77.227.186] ([106.203.57.88])
        by smtp.gmail.com with ESMTPSA id f11sm16507372pjg.1.2019.06.01.08.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 08:09:45 -0700 (PDT)
Date:   Sat, 01 Jun 2019 20:38:21 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet> <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <4FC43367-6062-4390-8A16-E4B589474E3B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,



On 31 May 2019 23:04:38 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom> wr=
ote:
>Johannes Schindelin <Johannes=2ESchindelin@gmx=2Ede> writes:
>
>> On Thu, 30 May 2019, Junio C Hamano wrote:
>>> * ds/close-object-store (2019-05-28) 3 commits
>>>  - packfile: rename close_all_packs to close_object_store
>>>  - packfile: close commit-graph in close_all_packs
>>>  - commit-graph: use raw_object_store when closing
>>>  (this branch uses ds/commit-graph-write-refactor=2E)
>>>
>>>  The commit-graph file is now part of the "files that the runtime
>>>  may keep open file descriptors on, all of which would need to be
>>>  closed when done with the object store", and the file descriptor to
>>>  an existing commit-graph file now is closed before "gc" finializes
>>>  a new instance to replace it=2E
>>>
>>>  Waiting on ds/commit-graph-write-refactor to stabilize=2E
>>

A typo which has possibly been overlooked:

s/finializes/finalizes/


--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
