Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD392027C
	for <e@80x24.org>; Sun, 16 Jul 2017 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdGPNmN (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 09:42:13 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34330 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdGPNmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 09:42:12 -0400
Received: by mail-lf0-f53.google.com with SMTP id t72so73597003lff.1
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wnRxhybaOROJFDbCY/hTPG4uRRy5Ni/thLSXVB0dtV0=;
        b=IRElPpjKmwIeBVs98YOZwJkToZZPlsnX3ySTvd0lhj0xwM3httBT7P/OQMDJKsiGck
         FAhEPSebueQxOD8E9SmqKHhHjVO3c/dhlXmSQMwQGvw/4f/5tbNf4Rs2qsey5/aCVQBf
         THi69N38FhDun/1ZwNGB9XOkoSrPOIH61vvGRn61OMCRQNZNgcSo+XlPx8xlAws6mvtw
         unM2IL05qBiVSOoHi97iwHcAkhOjvEsPcWdoLTKp2ZLfLGYCCP9LVrHRlR+bNjmf2Rz6
         UBuBddwdhQQ2M23y75XYe41Vi/NTnTax4fi36DxE4UJJUJr24HxuNbdZLB1qst25MtIj
         jZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wnRxhybaOROJFDbCY/hTPG4uRRy5Ni/thLSXVB0dtV0=;
        b=meDUvPUxitUZDyawlE7FU0S9KoEpuSLBfvfCgF4FAXixnzfJThLC5nFEw0ST4dH2Pj
         k5UWSLuPcVYh/U7jjwOcGtZPv4/BQdqLpDO0J/8gQ+xOGefdTAwYBwmp4GdAidwGpsSU
         BCUR59VBjGmfIceKqor2Zx5I5+Bv2WC99yhK10BtfG5VcDfsbTtgRDyTMf5ty4cQI483
         pdIcPaVv6NC8zRNWUirSgGx/Kf8oiClnNoA3c0ErE0pcs3jYx9yyuQ0A//AidzU+vkd7
         mSaUF7ouQgS5Llnt5GVShPp0UPkNcg5p5Dk4orNm0jPzMUVJa2Zuo5+9s9XklxI+MA6h
         agaQ==
X-Gm-Message-State: AIVw1114Zmn3XVub6RE01gt6wAf2kW7E647I/Ajtz6s9arZ/+Ermxi6c
        OCmtpdo7l+Uu3A07dPs=
X-Received: by 10.25.206.205 with SMTP id e196mr4704973lfg.126.1500212531054;
        Sun, 16 Jul 2017 06:42:11 -0700 (PDT)
Received: from gauss.local (81-235-138-217-no63.tbcn.telia.com. [81.235.138.217])
        by smtp.gmail.com with ESMTPSA id m16sm3095577ljb.26.2017.07.16.06.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jul 2017 06:42:10 -0700 (PDT)
Subject: Re: Keeping a non-1:1 mirror in sync and keeping private branches
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <699d0274-285f-3d30-654d-d9ca59fe4dce@gmail.com>
 <20170716101045.aslfct7g5vqfqnhi@sigill.intra.peff.net>
From:   Jan Danielsson <jan.m.danielsson@gmail.com>
Openpgp: id=C714C43356FB8176822FC591EB087C6291361CDA
Organization: La Cosa Nostra
Message-ID: <eb5e02da-662e-5561-7548-e50efba13dca@gmail.com>
Date:   Sun, 16 Jul 2017 15:42:09 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716101045.aslfct7g5vqfqnhi@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/16/17 12:10, Jeff King wrote:
>>    This seems to accomplish everything I want except that the the "git
>> push" deletes any branches I have created on my self-hosted
>> repository.
> 
> A mirrored push is basically:
> 
>   - push all refs, i.e., a "+refs/*:refs/*" refspec
> 
>   - enable --prune, to delete any branches that don't exist on the local
>     side
> 
> But you can do those two things separately if you like.  So your options
> are either:
> 
>   1. Drop the pruning (in which case deleted branches from the sync may
>      accumulate, but depending on the patterns that may or may not be a
>      problem).

   I don't think that's a problem.  Or rather, I'd be willing to try it
and see if it becomes a problem.

   That said; does "drop the pruning" mean simply removing "--prune"
from the remove update?  I did that, but it still deletes my test-branch
on push.  Is there an implicit pruning happening due to some
configuration option or the specific commands I'm using?

>   2. Use two different namespaces for the synced branches and the
>      private ones (e.g., refs/mirror/* in addition to your branches in
>      refs/heads/*). The obvious downside is that anybody cloning your
>      downstream mirror doesn't pick up refs/mirror unless they configure
>      that refspec explicitly.
   This sounds very useful.  How would one go about setting up this
configuration?

-- 
Kind regards,
Jan Danielsson

