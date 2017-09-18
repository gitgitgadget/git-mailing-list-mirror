Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7D12047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbdIRN3x (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:29:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38119 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbdIRN3w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:29:52 -0400
Received: by mail-qt0-f194.google.com with SMTP id f24so318724qte.5
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0FmyqUMDmZCV9AXamiNnCj0dEkIAcj68TcxR+tyOVLs=;
        b=JbsEhaQ83cJlaWTrNQmRI3Os4VK1zKGRrIy3zxY+dbk1S3LkyjYhBjcu9+zj5a2UVV
         J8FCJfeXiCMI4ecRJPluJeuLZblqmvyIs1OLC07GUlszCK4NUXSDUtjRMLainDKdLAUo
         3UOBXKVZQle37NOxY5sjbxqsgb7+iULVC5uhdOolx9rPELif/1/1Y94g3ReNzvlJ7NF1
         +HozevbOOrMGt8JI0OwA3bDX8tnTEjC9rfuOoz2M38TQbqySCFFAdhwGdtHMT7qQFRGH
         3qSPtsfWOFQEog/EjVx/ik9wCrbTpTorbcCD24aLt1gZgxgQF8GY3J4diIAG7xvWc670
         RFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0FmyqUMDmZCV9AXamiNnCj0dEkIAcj68TcxR+tyOVLs=;
        b=aodaBnS/yPSa7HF0w3ML+xpa1voKEF+tJ/ghLGdzJXs95/QlOwmWYAE6BEzeJrNWkQ
         s///n9iwcGPreo736vvYAlThwvon2NGtverMnfbQWIdYWHMbnx4vqkNMK1sX6yNqCLJJ
         V8lniA5411AH5qjkXAT7IFyHotwCn0zhuGHxIXGulOm+xnDyzCX2zqXn3ucbH/zsIZtj
         DQ2GgveVd9e5LPsVk6lKIY9rYOzwoXY/Wga34ZsC25StdCtqY+cnU/ueeGVow7p4fywT
         p42u3T1rCSCd8WCtYoSFlFvysUYIJECbXyS9UDoWVSd9shXFeLttrGcfcqqasrWXM/au
         MZ0w==
X-Gm-Message-State: AHPjjUgWvWIavOG5Oe3997Hsr3fZsQuKQ2sShjNTEsjUj/4p+qVHhlQD
        Q1QnWEnV1PQVzA==
X-Google-Smtp-Source: AOwi7QA4DaBzBmOZbScAcYQUncimmooHolXSC6Nw3cBK36wKsVABpN9ZrRwN2lYbKlS8ZEqn+HHBmg==
X-Received: by 10.200.54.3 with SMTP id m3mr52391363qtb.197.1505741391816;
        Mon, 18 Sep 2017 06:29:51 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w134sm5164672qkw.38.2017.09.18.06.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:29:50 -0700 (PDT)
Subject: Re: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
 extension.
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-6-benpeart@microsoft.com>
 <xmqqpoapu4yp.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6edb012e-0553-7356-3f27-11479e4326b8@gmail.com>
Date:   Mon, 18 Sep 2017 09:29:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoapu4yp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/17/2017 4:03 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> +[[fsmonitor-watchman]]
>> +fsmonitor-watchman
>> +~~~~~~~~~~~~~~~
> 
> I've queued a mini squash on top to make sure the ~~~~ line aligns
> with the length of the string above it by adding three ~'s here.
> 

Thanks, I'll do the same assuming there will be another re-roll.
