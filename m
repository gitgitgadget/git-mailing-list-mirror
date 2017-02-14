Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36DB2013C
	for <e@80x24.org>; Tue, 14 Feb 2017 05:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbdBNFJx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 00:09:53 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34041 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdBNFJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 00:09:52 -0500
Received: by mail-qt0-f193.google.com with SMTP id w20so15987756qtb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 21:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=v69ole5pGgRBPXUiF1xptf0aiqyG6pbz2Xbs3B9bd2U=;
        b=uFYlqWC4+tZCU0zUjn5Pe2yctZmW++X6zYMy1uQyjuGIaB3KR9szZ40H9ofPyW6bcf
         lNoOER4nFAgWi5qzppvzjbfar2Z5PGm9skN3botSEVM40jf/hx2hphvs65XPA5inD/Jh
         kQG873JzMHgvsTpzl3K5sZ8i5+DFIJMRJZ3wLO/ea/1W3V9c2KVcoZ/bfDfr6TiL9y79
         PbpGd8ymBS6rpAO6Azm8/7w6Hm4z2LF/VfUWTBzuvkWDiYOcoXLd7rmJSazM5ZcR5Jhe
         mR/wOaj8QAEWlwC/zPSYweW4VM6UVD9jeyqKCyStRhZ1g9aC/yI5JbE56USU3JVtOapV
         y5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=v69ole5pGgRBPXUiF1xptf0aiqyG6pbz2Xbs3B9bd2U=;
        b=bU9gF1530BxQCD5CZ6X7+oNPahlERLfJ/IzZvJJOgU/tfQvTOiUav9xE4NYhrWBADG
         rGUBwkCfLLR68ivouMY+SQyCFiCm5hrPd3Dhjua4Fx4O+uQ8SzedikTcSd+K8BQZK+Zi
         4VjzQ4E0PtJ+/qfeblAZvP/xyOhft3nDZNAYjv/BUiPRMpg46PcgTMKl1XXPPk6To4RS
         qL4qxzxHUtWMk3EZNe3XcBXUtx+rAp9y/y3d+YvhNoJVoM28kwr3UDcNsQtMQVFC7suv
         p1SruVBxXLwH3ydOrenm4C9lwAjFILbVot0VAMbYkkCDtlJkchQaN85abkNpShf9g67I
         Wi9Q==
X-Gm-Message-State: AMke39kyHFdZS0vSkJfKxgAQILNxmLga5qyo6k5P75l4y9aUwErCeXeCbNDCNiRHT/BxTg==
X-Received: by 10.200.43.184 with SMTP id m53mr24525543qtm.6.1487048991734;
        Mon, 13 Feb 2017 21:09:51 -0800 (PST)
Received: from localhost.localdomain (c-24-131-5-126.hsd1.va.comcast.net. [24.131.5.126])
        by smtp.gmail.com with ESMTPSA id p46sm8897076qta.33.2017.02.13.21.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 21:09:51 -0800 (PST)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Junio C Hamano <gitster@pobox.com>,
        Arif Khokar <arif.i.khokar@gmail.com>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
 <acac96da-2404-4f7e-a83d-7648ca448d31@hotmail.com>
 <xmqqlgt99yeo.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   Arif Khokar <arif.i.khokar@gmail.com>
Message-ID: <5d7e750d-0586-15c3-43ce-4dc4452a73fa@hotmail.com>
Date:   Tue, 14 Feb 2017 00:09:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgt99yeo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 11:41 PM, Junio C Hamano wrote:
> Arif Khokar <arif.i.khokar@gmail.com> writes:
>
>> One concern I have regarding this idea is whether or not SMTP servers
>> typically replace a Message-Id header set by the client.
>
> The clients are supposed to give Message-IDs, but because some
> clients fail to do so, SMTP server implementations are allowed to
> add an ID to avoid leaving a message nameless (IIRC, 6.3 in
> RFC2821).  So "replace" would be in violation.
>
> But some parts of the world ignore RFCs, so...

Based on my testing, gmail and comcast (and my work email) will preserve 
the Message-Id header set by the client, but 
hotmail.com/live.com/outlook.com will replace it with their generated value.

Based on a small sample of email addresses of those who post to this 
list, it appears that most people are using their own MTA to send email, 
or are using gmail, so they probably wouldn't be affected by the issue.
