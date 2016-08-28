Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FAE1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 14:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbcH1N4b (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 09:56:31 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37143 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbcH1N4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 09:56:30 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so55007645wmg.0
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EexZd6P1nSDwR0jZxk9EnD9vOJObN7eigpyUYjniRvY=;
        b=x/wTHFvnPJBCjYoHth8g9CX1vaaCOOsYVAz9FEIjrb5rCClTg/iIu1oecGkuIsMB2z
         1IYj3uGr1Ay4Ikl7GXeTzxJ/DMav1nFF2Af9ecoXbyyzsFhYI8rYdmItTIlFa02HNmly
         ZCsgAYeC6pTYGpMdJePVz0MqZSCCFmGI1yeI7+nBunk9CiR4d+AYEFa2licgTXrjMqm5
         S+Ms+fv/PCDvPqTrepiZi0K8vLXldwVOzt1x44+wsZlqMtkjIwHgy6fyCwvykx/ocKvT
         J7JcWtYM7N/prHJagjOQmMbCxqg7iLz1X92fk8QBE7smqpNclrv+CZwd+pyLn8wf2yHJ
         hPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EexZd6P1nSDwR0jZxk9EnD9vOJObN7eigpyUYjniRvY=;
        b=fgbcEWiRCzXIIZLrhQ95SpKizLGepocns1KqSDM7KLgJRIakVHKzYS1SLxPKoo/MuP
         RTrhi2tOImxi//EGIJP9PNWbPs4baGqgV2kAlJd2LLRfH6dNQWrjcmxIclH4O7KG8J7e
         QHAKWFRMPnIns5l/DXTDOMliArD8SXL3SsQIbatqbbov0u8sYE68eieJPdivJjKtuC3X
         tUY4JlVxBK1WGCF2RZsBIVTlsx1h5mqdsKKjeSso3xoGv3AslAOeOfr+kp2nMg5/zEel
         +224w9K+f84u4GkfCN4seW4dCbG+NFOK3j7/fVuclBtOIW1WVwS2WqAzxyHKtMuadWbR
         9fvg==
X-Gm-Message-State: AE9vXwNm4UnQ5wzfolnQqkYKpjnsQsz53NyWAj6hexEdOrVnzbQ+T1jkTiB4K+KM7Xk93Q==
X-Received: by 10.28.37.67 with SMTP id l64mr6729920wml.105.1472392574350;
        Sun, 28 Aug 2016 06:56:14 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id z17sm8657789wmz.23.2016.08.28.06.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 06:56:13 -0700 (PDT)
Subject: Re: Notation for current branch?
To:     Kevin Daudt <me@ikke.info>, ryenus <ryenus@gmail.com>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
 <20160828105159.GA5477@ikke.info>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
Date:   Sun, 28 Aug 2016 15:56:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160828105159.GA5477@ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 28.08.2016 o 12:51, Kevin Daudt pisze:
> On Sun, Aug 28, 2016 at 05:58:18PM +0800, ryenus wrote:

>> I wonder if there's an easy to use notation to refer to the current branch?
>> which is expected be friendly to scripting.
>>
>> For HEAD, there's @, which is short and concise.

What's wrong with simply using 'HEAD' for scripting?

>>
>> But for the current branch, it seems one has to either use a not so friendly
>> plumbing command, or grep/parse the output of `git branch`, since the latter
>> doesn't even has any option to only print the plain name of the current branch,
>> or maybe an option can be added to `git branch`?
> 
> Scripts should always rely on plubming commands, never on porcelain, as
> their output will change, and thus, break scripts.

It is not something theoretical; the output of "git branch" for detached HEAD
(aka anonymous / unnamed branch) did change.
 
> To get the current branch name, the best is to use `git rev-parse
> --symbolic-full-name`[1], which either returns you the current branch name
> (eg refs/heads/master), or HEAD, when you have a detached HEAD. If you
> only want the friendly name, add --abbrev-ref, which would then return
> master.
> 
> [1]: git symbolic-ref HEAD would also work, but errors out when you're
> not on a branch.

Note that in some cases current branch is implied, like e.g. in
"@{<n>}" notation.

-- 
Jakub Narębski

