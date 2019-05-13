Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9AA1F461
	for <e@80x24.org>; Mon, 13 May 2019 13:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfEMN3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 09:29:14 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46469 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfEMN3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 09:29:14 -0400
Received: by mail-wr1-f46.google.com with SMTP id r7so14650419wrr.13
        for <git@vger.kernel.org>; Mon, 13 May 2019 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mcnbA9RoGIzuFRwmzL2kxXigA/HWQYQwV87dFdv7Scs=;
        b=Pker36XgMso6QZcvBchFGuN4eeuV8IpvDB8coKjsR0mVXphcFYjgWxEVtZe/3GlJsk
         ugHEvVLAKpDLGdACy9WJrtkbG/uM93wOFHWPS2jN6OTyZSArrvjpHqwoojQ3u3F3zZ3b
         oW7OpNX9A22UtO561fUbj++11xQcHF3BUJsY79u/R8PX1lWvgjb1WeOjChjl86YXb1rq
         KXAvd/u4ZcolhFHt1+EE2UZvVInKc182mUh1QJ6h/+tLCNCd6GQZNFyWO6Em8CVkQWZB
         VVF6PVa51wXeTlSZtOFGRL3fitxIrameuX4i1cnmRBpsEbZRX/zfxBx+kDNaZVWv6ksv
         5z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mcnbA9RoGIzuFRwmzL2kxXigA/HWQYQwV87dFdv7Scs=;
        b=MTgysTph1esCVUKNuYCyEsLImocMJlgm5aSohuVitAckH1tuYx8WqB2/33o6mzRtSJ
         iSAfWLcBK2yqLF7qkxmnhwh1XIlLDinbtlb4IJVO+rKhxN1SvoTA64F/NOnzDtFKCpER
         jj8H+nMasxS8cUgx7BzIjIn/u7LahjRnOgKGx6zbFWWhHgJSx8EVLqEYg/2fSOchgNMM
         jcop0Z4uhRSo9doe8WHpTC+zNLZXopI/sL8wZtHrdPVmA8Om6xomtJA7wyVTEjOYXSFd
         KwErJCV9tzyT2ky8G5QbQyVEnGI5CNj+fyyUo1H8MPOuA79pHXjEIIStKrcjkzF261TG
         jgVQ==
X-Gm-Message-State: APjAAAXzNaN35Na/+tcpq7i5Ioc0k4UXdVcATRjuLzQ58DmiwT80Im5S
        Gjf9gWLTSkp6H0BbVeoMa+qymM6l
X-Google-Smtp-Source: APXvYqzwk5+yaIiEmvgUBucT9D3MbBBxq4ZloCTIBo1n4Irr4XflOuFNmI7Z7WlgLTin+YuK9qVJXA==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr17641565wri.180.1557754151789;
        Mon, 13 May 2019 06:29:11 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id l8sm3842539wrw.56.2019.05.13.06.29.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 06:29:10 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
 <6726f99a-ec27-b72f-39d7-03eecb555197@gmail.com>
 <nycvar.QRO.7.76.6.1905101549180.44@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <68adf0b3-e643-42e2-acfd-804d16c2695c@gmail.com>
Date:   Mon, 13 May 2019 14:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905101549180.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/05/2019 14:49, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 9 May 2019, Phillip Wood wrote:
> 
>> On 08/05/2019 18:23, Junio C Hamano wrote:
>>> * pw/rebase-abort-clean-rewritten (2019-05-08) 1 commit
>>>    - rebase --abort: cleanup refs/rewritten
>>>    (this branch uses pw/rebase-i-internal.)
>>>
>>>    "git rebase --abort" used to leave refs/rewritten/ when concluding
>>>    "git rebase -r", which has been corrected.
>>>
>>>    Will merge to 'next'.
>>
>> Can you hold off on this one please, I think we should clean up
>> refs/rewritten/ on --quit as well (I'm not sure I've convinced dscho about
>> that yet though [1])
> 
> You have convinced me ;-)

Thanks, I'll try and send a re-roll tomorrow

Best Wishes

Phillip

> Thanks for your consideration,
> Dscho
> 
>> Thanks
>>
>> Phillip
>>
>> [1]
>> https://public-inbox.org/git/4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com/#t
>>
>>
