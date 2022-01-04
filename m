Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D8FC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiADSG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiADSG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:06:27 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A71C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:06:27 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t66so24214027qkb.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pjZweyqSkSQXQRBd3EC4BtFmFGl966BUf9MX9b8LECI=;
        b=T2qFKSSrlTZ/EKjHGry5Pu8F8ZT6yLR9bFopMF7vAvy/Ap+RBTulacPEnyy1HGcm/C
         D3pnK+A3w0CNAiASe+oUyRh6gIwMCUypd/cEdnQpq2ZmnI+mghuhCBaoUGdWNKrn/Znl
         nokdT3XjFRuYOmocbSRCiDzrxafP5NY+i0ZOp2mmsVjw8K9F1O/MmVKktEyWOcYjZUNx
         uaYSGvAq6Rg0GWEfcbHbB0uOe/iIjvnRu1cWYCb37+n5mZtlU7lW4DFqtPoKBGj3kgk+
         /1TjeXnR8VrsM6rLI94DlGw1dM+ZzEXbAYJtiNcHLG8hqSCBP0GUS8tVHE+r8J0yKbNE
         G97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjZweyqSkSQXQRBd3EC4BtFmFGl966BUf9MX9b8LECI=;
        b=BfnHhJZtOm+FEGvdPhX6m200AfJb7ILRpcKrpqWNCoFAyF9eMghv3QYQ1UZJKPAkfB
         qjuDDczh2EgJMCYJhsoCZoJeUno6c8PPkqofXiiq/nwZ6ik4X7A8RycGc+dU8VP74dGw
         CdATaumzS0Wr23AC29lwhFAJTUaOoOrTq5Ca2Y9U3rXiyFzZ7RKaDjRPCfdpBUBjnrNQ
         esg+/G+kisQ9XLIcBAzCZyb+qtov1xATM7cY1d712uWSomVGVWg+x+LA55+LQcW+J3cD
         pI8j7KtAXXVmc8Ql32dDQ0quZ0UnjtBA45IkJnQdow4l6lh+BRSBSXa9PUwxdv5x8Ip3
         2qFQ==
X-Gm-Message-State: AOAM532eiIfeNUZY9ZzqbKysPk7NzylVmrLkeuBbAmQxV817XC3xwAjc
        Rv1HO5uCl+/8CcvoaG+PMdziti8TYrdDxQ==
X-Google-Smtp-Source: ABdhPJxqNEl6R5LxcDElHIASxx9Gj6lrZeU/I4JQ4krMf+Fsumwy+6o6MwKdWuz81jfTMMXLPqascw==
X-Received: by 2002:a05:620a:218d:: with SMTP id g13mr33445569qka.744.1641319586654;
        Tue, 04 Jan 2022 10:06:26 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d9sm32298934qkn.131.2022.01.04.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:06:26 -0800 (PST)
Subject: Re: lh/use-gnu-color-in-grep, was Re: What's cooking in git.git (Jan
 2022, #01; Mon, 3)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, lenaic@lhuard.fr
References: <xmqqsfu4duxl.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201041458150.7076@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <25d00bcb-3345-c221-6a38-593f23f942f3@gmail.com>
Date:   Tue, 4 Jan 2022 13:06:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2201041458150.7076@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-01-04 à 08:59, Johannes Schindelin a écrit :
> Hi Junio,
> 
> On Mon, 3 Jan 2022, Junio C Hamano wrote:
> 
>> * lh/use-gnu-color-in-grep (2021-12-16) 1 commit
>>   - grep: align default colors with GNU grep ones
>>
>>   The color palette used by "git grep" has been updated to match that
>>   of GNU grep.
>>
>>   On hold.
>>   cf. <xmqqh7b88b3o.fsf@gitster.g>
>>   source: <20211216115622.85506-1-lenaic@lhuard.fr>
> 
> FWIW I am in favor of adjusting Git's `grep` colors to GNU's version. From
> the users' perspective, it provides more consistency and less unexpected
> surprises.
> 

For what it's worth, I'm also in favor of that change. It's been in my todo list
of possible enhancements for a little while. I agree with Dscho that it's more consistent
for users to have the same default colors as GNU grep.

Cheers,
Philippe.
