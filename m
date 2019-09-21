Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7161F463
	for <e@80x24.org>; Sat, 21 Sep 2019 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbfIUMLN (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 08:11:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53497 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407590AbfIUMLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 08:11:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so5106180wmd.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OMtts7KHZ2921PglVY4leN0wVdXTJBAxqGYCULtynAQ=;
        b=hmVGK9cs5Ol9B+7OPPlTjI1UbrgWBUOpXDwjCBEVUxYettSqgWktfBkOV4hTnFm2DY
         jcz7HOGts7f6+DyxIeu6QSqg3am4vVfEkcXPpmxsgIAT3o4ERAOSUa0eEgu7Cv+O4hzb
         ZIHPZXZg+oIUn6maUUadCVtq91AjgdopcAa/SifPMrkoDzm623UyaeJ5tRtEPZ3so5hU
         fPmwiCMcHhYtrRWc5dvZj6R/TfqlDURWfbxQ7pepjzRopy11IxGe0DJLJ1QLYU0Ynk2E
         pTrWrPgBD8yhvVJGYJ0TwEgkGUGDba6qBvTe3uCmoqW1bQVquiHz8H7Nn/IEB/A0ZbbE
         mqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OMtts7KHZ2921PglVY4leN0wVdXTJBAxqGYCULtynAQ=;
        b=HOt1zRXzClLZZ3c8kT3V0pc2zxwhlT5PpT1QqSCuH26vIpDg6V5+dcU/IWynRf90gp
         XMlpWJv89r7CLEbvCBY0/r7bHukE1AZH1vYyEN4tmCAmgmAUCPLlkiFl1aeb8yn3JaxH
         /dp94Z8CfE07eT0Lj2F3oWl/1J0l8fFqfALSC3TEtwtFb2JmRh8pyAXZlkV0bqB7MSql
         gokC60jALO4aq8iRPmeOVgewoeDr+Vo91QxVQtDYqM1LprzW5a5fV67nuZO4zApYMxYm
         lCo58bueqNzIHUxCAYNR4MZqjMKE/UtoDFlx32eIqNjEp4zF96YvK+c5atSo9pZiomZ4
         qZHQ==
X-Gm-Message-State: APjAAAWRH/DHFR+NaEQnRQGPQjG4f6rZ6hhXHAsIC5h7vhv5qrM52qBH
        /dc04CYGGrHvbRRFdR1aUmQ=
X-Google-Smtp-Source: APXvYqxjz33wZNQyUQLUv93hjN51GI9oa9MoCda0PrxYaRsTLKKu0nWI+WGQ4QTAecY3ZNJ8WggNfQ==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr7225147wme.16.1569067870766;
        Sat, 21 Sep 2019 05:11:10 -0700 (PDT)
Received: from szeder.dev (x4db43ca8.dyn.telefonica.de. [77.180.60.168])
        by smtp.gmail.com with ESMTPSA id g138sm7486577wmg.29.2019.09.21.05.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 05:11:10 -0700 (PDT)
Date:   Sat, 21 Sep 2019 14:11:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
Message-ID: <20190921121104.GA6787@szeder.dev>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 09:53:48AM -0700, William Baker via GitGitGadget wrote:
> diff --git a/midx.h b/midx.h
> index f0ae656b5d..e6fa356b5c 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -37,6 +37,8 @@ struct multi_pack_index {
>  	char object_dir[FLEX_ARRAY];
>  };
>  
> +#define MIDX_PROGRESS     (1 << 0)

Please consider using an enum.

A preprocessor constant is just that: a number.  It is shown as a
number while debugging, and there is no clear indication what related
values belong in the same group (apart from the prefix of the macro
name), or what possible values an 'unsigned flags' variable might have
(though in this particular case there is only a single possible
value...).  

An enum, however, is much friendlier to humans when debugging, because
even 'gdb' shows the value using the symbolic names, e.g.:

  write_commit_graph_reachable (obj_dir=0x9ab870 ".git/objects", 
      flags=(COMMIT_GRAPH_WRITE_APPEND | COMMIT_GRAPH_WRITE_PROGRESS), 
      split_opts=0x9670e0 <split_opts>) at commit-graph.c:1141

and it's quite clear what values a variable of type 'enum
commit_graph_write_flags' can have.

