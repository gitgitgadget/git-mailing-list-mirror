Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4A41F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeITSeS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:34:18 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41989 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbeITSeR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:34:17 -0400
Received: by mail-qt0-f169.google.com with SMTP id z8-v6so8300719qto.9
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=THkXY6QDFGgWf3qLvEwkMZkp2uPj1eDHYOVZ3Xu6CYg=;
        b=G+JfBbZgQb8QaQ/ZauExw9kmWVDYuNgU37/xsYpN24nT4snVQ6eY7ynrl3OE/h3/OI
         My2fuA5BKaEdf5jR+dXN6nIPr8XMQTt0mo0fPIvIoqVENJEwKpMYqokdDnEudFII/5TC
         Tx3a9V2rwgFrCMRvJ/1DJTsiR53mSSqyYo9upPE++/LBBASH5OTmRWD5LNVbWqzJTq2U
         29mzoVPGUDDJ7bO2TviuZ4BwXPRhm+dkJuerJ5cjRgJ0Ww10BbVw9XdgZlyMFAN9YoBk
         Ss4j+kjCNgEq46u2Q0bgZlDi0apYjGGR1s5uEkgpRL49NWlDwV33WeI4Enn3aamdBZ7f
         DF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=THkXY6QDFGgWf3qLvEwkMZkp2uPj1eDHYOVZ3Xu6CYg=;
        b=V7KGqgH0wp3AEndJwm3/mc+RedtLGn4xYaN04eMZRBE0vcLeLiQM7jQWoNF6CATAnS
         9udopVx0qYPUABd3bbEw0upyRIWZzf9Lsmj3VfKvX+yih6Xr8/4DREragtChnRgM8vRL
         dn5wYTcarEwmVfhpZWHpPlzORnvxm/3g4aqgBuDUFGYJwDXYSE3gTVgkwu176PzTz7eT
         T4nS/agR/tW3qXQJlWrkOmqnWu97QQaJxh8MewIvpixEUcB/r7x2rcpHHSsL2pD9w5Id
         u9pg+FjMmlzmYTCzvJ4NC6RFyY+2tjMJWapMyrZm9BBjz2wYOnLp4MW/8b84tQ4xP/Xv
         nn1w==
X-Gm-Message-State: APzg51BCHeugOfev8vou+842RyNiRd8/ZO53QOyhxsgH5G/o2k18sxLq
        k8WI8vR8fbTaoVz+sVY/fZLAmmI8
X-Google-Smtp-Source: ANB0VdZo1wk/fBqYQz7WvxQCj7Dmtd0+XDyWk30de3kTl7ZlF7k2MOJxyL5RWqu49DWDwwhwJuUrcQ==
X-Received: by 2002:a0c:9c09:: with SMTP id v9-v6mr28568533qve.186.1537447854626;
        Thu, 20 Sep 2018 05:50:54 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id y27-v6sm16339329qtj.58.2018.09.20.05.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:50:53 -0700 (PDT)
Subject: Re: [PATCH 3/4] git-commit-graph.txt: refer to "*commit* graph file"
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1537374062.git.martin.agren@gmail.com>
 <65f42c947aa2b392075740673a5dc889fd6e64e6.1537374062.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38803edb-de41-90db-33f6-f1a0d5344608@gmail.com>
Date:   Wed, 19 Sep 2018 19:32:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <65f42c947aa2b392075740673a5dc889fd6e64e6.1537374062.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2018 12:30 PM, Martin Ågren wrote:
> This document sometimes refers to the "commit graph file" as just "the
> graph file". This saves a couple of words here and there at the risk of
> confusion. In particular, the documentation for `git commit-graph read`
> appears to suggest that there are indeed different types of graph files.
>
> Let's just write out the full name everywhere.
This is a good idea. Let's be specific.
> The full name, by the way, is not the "commit-graph file" with a dash,
> cf. the synopsis. Use the dashless form. (The next commit will fix the
> remaining few instances of the "commit-graph file" in this document.)

The file is literally at ".git/objects/info/commit-graph" which is why I 
tried to use "commit-graph" everywhere. Why do you think that "commit 
graph" is better?

Thanks,
-Stolee
