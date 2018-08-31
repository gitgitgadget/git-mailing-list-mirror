Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AD21F428
	for <e@80x24.org>; Fri, 31 Aug 2018 01:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHaFTP (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 01:19:15 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44454 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeHaFTP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 01:19:15 -0400
Received: by mail-pl1-f178.google.com with SMTP id ba4-v6so4613054plb.11
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNUJ0CyVhZPvNuj+b/qN62i/BnIfylLJcf213kgZ9XM=;
        b=HuQVW2ptLU4sIgGg6VUETy4LqXgF8t2lzB5n256UmX/pWOb55mnjmKVUAttF7TDk0V
         W1kdap2d3GmY69mzqgF3/OaI5u5UEMFRzkWMnpLQzHsoG9eQw+dXNw4etqAYvoBs465y
         UUhLUjwU9jO/CJ/mJtszC/6YuKo6vjxd/9CzIQHiL/wJMgkwBTgBahb6Gk72Nf/1b1QO
         B3IikO6QiIDjAGK0L7guzyYSC4oyM6/Mn1HiTMvn1v8fDcbLoubBVNEr5a5vDUvh/fDK
         iVaRh1PnQ6dY5X2xwZXZuMAeuaBkkTUsEUb3Xl5uU+wIfEng6enWRYXM1YEJtEvmF6J4
         nxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNUJ0CyVhZPvNuj+b/qN62i/BnIfylLJcf213kgZ9XM=;
        b=bpnNHtAHco/pt6VmC1nDvU2U2joWvW9jzYXx7eq6YYM0yHyEZdfj/rvh3ABwXaIoAd
         S4aKLLocUwt/yfCJtW9FpyCfmqU9rrRo6o4GLkQlbgP08Up3aBnOBleYrDBDckhbZry9
         Y+a/xAASrEfgENnX5IZ6X9qfQKP+b+ZejH6wokspAUqO/Ea12XJ8CJSZr6FZd9Hy4ZZX
         8p43y/L16ss7yd7DyYpxQ+hQ1o/Wev4RWpIGJvnVgYPVa6QpxDmUkUb8KgCOvDn95eEW
         8QWpMHVTPUG/+2lTBiUGh0ZAAGSKBRRozmzOFjynk/BV39f1jncNf/TBIO3Gx07li6as
         tvFw==
X-Gm-Message-State: APzg51BCdFkjJyVykzdTyj5ofttnZaaVlF0LBqzVGsuKqILk8fkBASkJ
        Lr6aGbw+/vMNAgvtcZKIg1K+lrSU
X-Google-Smtp-Source: ANB0VdYO38aWacOgYLjReZN/ooe29SZNWgKZz4NalNegs53EqjkzGqlqJuhtFkU/zc5LbCasNXDFXQ==
X-Received: by 2002:a17:902:9f90:: with SMTP id g16-v6mr12918180plq.34.1535678060487;
        Thu, 30 Aug 2018 18:14:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s27-v6sm18839070pfk.133.2018.08.30.18.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:14:19 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:14:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180831011417.GA98946@aiede.svl.corp.google.com>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
 <20180830035609.GA140348@aiede.svl.corp.google.com>
 <20180830072043.GA14514@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830072043.GA14514@dcvr.yhbt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jeff King wrote:

>>> I guess I just wonder if I set up a mirror on another domain, would
>>> anybody actually _use_ it? I'd think most people would just go to
>>> public-inbox.org as the de facto URL.
>>
>> If it's faster than public-inbox.org and you don't mind the traffic I
>> would send, then I'll use it. :)
>
> Is performance a problem on public-inbox.org for you?

It's pretty fast.  I'm just very, very picky about latency. ;-)

It's good to know you're interested in which corner cases are bad.
The next time I have a noticeably slow page load, I'll contact meta@.

[...]
> I've also been sorta considering downgrading to a $5/month VPS
> (from a $20/month VPS) to force myself to pay more attention to
> performance while saving myself a few bucks.  But I wouldn't get
> to dogfood on SMP, anymore...

Sounds reasonable to me.  If performance gets bad, that's just a
reason for people to help out (either with patches or e.g. with
donated VMs for hosting).

Speaking of the latter: what are your current resource requirements?
E.g. which of the dimensions in [1] do you not fit into?

Thanks,
Jonathan

[1] https://cloud.google.com/free/docs/always-free-usage-limits#compute_name
