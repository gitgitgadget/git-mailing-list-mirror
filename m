Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64E61F462
	for <e@80x24.org>; Mon, 17 Jun 2019 19:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfFQTEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 15:04:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36671 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQTEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 15:04:05 -0400
Received: by mail-wr1-f51.google.com with SMTP id n4so3109123wrs.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xgcrIAnPMTHHIabCWLoA7HscspXJwsCoA4UBviNgLYw=;
        b=ENxoJ+bp0ImzTsiexZdNY9d9C4M//1AoKYiH1hJQoNqTKdEYwTnQ80i5uyG4jpFoEp
         4yOv0Fu+MFlYA6oWv7OAtjbEhyl0ImnCGGohS0A75DitVUxnXnQ8vkYUTGGNUMWwj4Cs
         2FspFzgXHBQO/qytAMLBJaBMNbl2E//5oZN2HEDWcBw0+mIb3vK8czu2wy7PvvsXc03T
         3NNQ2f3UX+YR3OgifayZ8Qw5uFks+g6PzW4rmXVjj3A6CqQXKcMxNFHMD0+Quo5SNhuc
         jcJ5ewaXGUCUf54OuipfiMFa3MpNLLMz+orMXecv9jm4q2+dFW9VQ9cFnhm1pBVJtImE
         XXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xgcrIAnPMTHHIabCWLoA7HscspXJwsCoA4UBviNgLYw=;
        b=MltOtEt4q3nGJih+5lEogveNE4cN2ZQRgIMkEC1ItO/JOZ4acJG5i+JUxjzUuVMJvN
         PQjUuz3Z+nlwLCy1RvGw7hZkuiMwMbFHcPq8jPlCbu81fQgDhHy6eyJXKI9kt197mUgJ
         kyTz8FlKcZGJZwtvZyOU0gk+L3RF/Uo6uhudcFdQ/rpwWp8x/9wHXqA9CNz8WHIxVnry
         Y0xuugt91Xe4yRK2QU58zDkdHe9YT5Mr29Y0yjonp8gcKn4PnrlokqeDjasBSKvoKtKu
         U/F006tnL2LB+ajqdNU5WeCaaBBGGyXD8wj6d4sjl37nGjFO9bZzKhTq9gGFni+ewyuW
         kcDg==
X-Gm-Message-State: APjAAAXfbs60febWoUOo1w71YsRQXKAIjaIWuTh3NajagQMPlEtj+ywh
        VI8YcchgHYW4ehSbFqtyJneQaS8e
X-Google-Smtp-Source: APXvYqwKBbbs0ITCJUHIk3Fqs9cQRV33mh4uWG+b8RqQdi0PEwtpl1xErxTYGknloHelrDhtjbsqGQ==
X-Received: by 2002:adf:f442:: with SMTP id f2mr11117913wrp.275.1560798242908;
        Mon, 17 Jun 2019 12:04:02 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id l12sm33966120wrb.81.2019.06.17.12.04.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:04:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: pw/rebase-abort-clean-rewritten, was Re: What's cooking in
 git.git (Jun 2019, #04; Fri, 14)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com>
Date:   Mon, 17 Jun 2019 20:04:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho & Junio

On 17/06/2019 19:06, Johannes Schindelin wrote:
> Hi Junio & Phillip,
> 
> On Fri, 14 Jun 2019, Junio C Hamano wrote:
> 
>> * pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
>>   - rebase --abort/--quit: cleanup refs/rewritten
>>   - sequencer: return errors from sequencer_remove_state()
>>   - rebase: warn if state directory cannot be removed
>>   - rebase: fix a memory leak
>>
>>   "git rebase --abort" used to leave refs/rewritten/ when concluding
>>   "git rebase -r", which has been corrected.
>>
>>   On hold.
>>   cf. <20190514180349.17245-1-phillip.wood123@gmail.com>
> 
> This is just the cover letter of the latest iteration, claiming that
> Phillip would be offline for a couple days (but I am certain that that
> period passed).

Yes I sent it just before I went offline, but that's a while ago now

> Phillip, I was under the impression that all reviewer comments had been
> resolved. Does that match your impression?

Yes, I think it's ready. Thanks for prompting me dscho, I'd seen this 
was on hold and then forgotten to write to Junio

Best Wishes

Phillip

> Ciao,
> Dscho
> 
