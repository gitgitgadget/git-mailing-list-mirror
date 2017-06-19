Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4AB1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdFSRyY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:54:24 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34908 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdFSRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:54:23 -0400
Received: by mail-pf0-f172.google.com with SMTP id l89so57159798pfi.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xUqaUbQ7ZVTkrRVQ7R2CCUpwvRn7sV422O79JcDyc5w=;
        b=Kdi1xxwicAH+1HgVcRa8HvIv+WUnZycHoVnkyRiU5NwD6IY8WuYNcXeGjTrPmp89KT
         Fus+SKNunNXCJ26YUFxVKQ1M6Udl2IHAdq40ObvsfbFzCbCA8ZabP1rfcUErBAklAakU
         aI5nSq6kcuEtl7YhiUFwjJ56x82lEtXP70VL5M6MTsxkFBpzdny2pDv71RlIAXDsrNuD
         YnvgbexiWDxKPT3DBatozQbZkjB1uy+zsdQqFF9Y5tlnYpTcEykkxUEEkRB9RulW/+MK
         280U19CoXlzFoUQbAka7qwocMWdiQ4Cy9ivWzJZIy7IeLpv1upA8jZIbCSriCztw8py+
         BNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xUqaUbQ7ZVTkrRVQ7R2CCUpwvRn7sV422O79JcDyc5w=;
        b=ReoJGhXb+wbJrI0GdvllXVmOiKdqVu2eXXDT20HkUYPeDOcrEXaf6YEAlDkW5f0rjD
         +428d4rFIkgIKNOVTI/CefZBGjN0DQOpV4v6qO1uTciLk4JcVRjioF6H/tGMHCkMSni8
         euKt6nrCGEuFKCdMfaKfuY8b4s2KWb4QdLK5xNFbtMpYZW0bAHgHOOvheAAcb6ybuGBu
         NNbZTh9g3W3hHgYaUVLv0vQchP91N+nXgLUEiNueEBx/Fp55SmOSyH5U4F9FP76mros5
         NuUrZUVbolayTVqryQLCFyIe0Sy6ldgDaReaRD8u/9Zy+ofQXjKry6b6t3woWrqWRTqF
         uawg==
X-Gm-Message-State: AKS2vOylyle2C05cu+QS2zC1lfhOGgG2MXxk7VeKYCq1MLU81dobJmtA
        FxxhJnWmGj1TdKs+G04lD8OCoqBNIwjJ
X-Received: by 10.84.137.165 with SMTP id 34mr30572752pln.167.1497894862467;
 Mon, 19 Jun 2017 10:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 10:54:21 -0700 (PDT)
In-Reply-To: <1497893625.18850.2.camel@gmail.com>
References: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com>
 <xmqq1sqgv9ax.fsf@gitster.mtv.corp.google.com> <CAGZ79kbqBXZ5S2TBk6B5gRk+Y-ev2rdgkQZrF-MmHQc0Thj7EQ@mail.gmail.com>
 <1497893625.18850.2.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 10:54:21 -0700
Message-ID: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, mlevedahl@gmail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 10:33 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:

>
>> Please markup the '.gitmodules' either via single quotes or `.
>> (or even link to 'gitmodules(5)' )
>>
> Marked it up using `. Help needed to link to 'gitmodules(5)', as I'm
> not sure how to provide alternative text to 'linkgit:'.

I did not mean  'gitmodules(5)' literally, I rather meant using linkgit:
as you know it. :)

>
>> I am undecided if this is really removing (2) unclearness, but the
>> (1) redundancy seems fine to me.
>>
> Sorry about that. The commit message should have been,
>
> ...
> 2. Removed unclear back reference

Oh that clears some confusion here. :)

> Note: Will follow up with a patch, soon.

Thanks.
Stefan
