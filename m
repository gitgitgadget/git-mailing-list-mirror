Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30381F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfBHRYB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 12:24:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56259 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHRYB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:24:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so4244001wmh.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 09:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MoKAKQ1gLK4lAceLLcw625hirzxk0UlwiY6pRPAm8nk=;
        b=pykfBXRMLKuE0IzAEPbrZXpbFcexHVMsGsEhapvqvw/XkQKY/IKU9qI6dLl2muwW1L
         Wvv2+XFAw+p3P3v3qFLI2U+et0qwOr6jVEIHEzR44Ju4jd4IBQqYlzg7yuul5rrHc5FC
         21c74o8mAl7/UPFvFdbSVzE4BKIQXD/vq/0jFGHR9TIkxvwtdtSagUu9mtY85UZeIHuu
         IVVrfCHtNbg9J5vjkpC8xiVhiFjQJipWa+4cUkbsicWCLJNoMMCtuseogY56e7egSFI1
         klvshk5aOw1qfivHfzGVsSurQbeVpzrCUQS7bKjxK5F5HWGxLhkzj/SlxeG8guEqldnc
         FZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MoKAKQ1gLK4lAceLLcw625hirzxk0UlwiY6pRPAm8nk=;
        b=T66gwrNOO6DiRXOvaCL0coSHuXvMsgfrMW366II/Jd2JSTqdFlcctJc24Q/B6sONoo
         XMDDjF5mn19glhEneMgHxU3g8r3/Pwf91gJBXglcxD3vKUy7zYFkre0qxPxA5yoiX+wE
         XbUO9Poykmt5HtGT9ZyqnXUBEEfilkxgau1FsTEjhzFfN9tN+d8O0wFoNeJvAVUdpL/d
         7iu/wThYWFbz7VRhFWHrJb6Vavh5WkhCRFZSHcqJ3m1+NnzKhHucpERcdpNXrSfbhmEd
         E9Y8RplPixMZlbYQ+6Ivlfdzwu6rR6ie00l0YXOR3qpzKp79xi0AFpWDbMXB7DGIVijv
         sRpA==
X-Gm-Message-State: AHQUAuaGisvqGymXrrJhARVVoAjB80cFIYtxdBIJ+1v8u90mrkG9SsPC
        a6xFn4f3I9hCpCkBxcjQTS0=
X-Google-Smtp-Source: AHgI3IYE75832JKwppuMXiDXEOiCcBe9nlFf73zAz7MlTNbLyWzGQyUv5s6xaBwjpgmzdnjTt36vBQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr17143621wrh.250.1549646638956;
        Fri, 08 Feb 2019 09:23:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w18sm2425876wmi.12.2019.02.08.09.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:23:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
        <20190208100221.GA22283@ash>
Date:   Fri, 08 Feb 2019 09:23:56 -0800
In-Reply-To: <20190208100221.GA22283@ash> (Duy Nguyen's message of "Fri, 8 Feb
        2019 17:02:22 +0700")
Message-ID: <xmqqzhr6kxcj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
>> I've recently started seeing a lot of this message when doing a rebase:
>> 
>>    warning: could not freshen shared index
>> '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
>
> There are only two places in the code that could print this. The one
> in read_index_from() can't happen unless is_null_oid() is broken (very
> very unlikely).
>
> The other one is in write_locked_index() which could happen in theory
> but I don't understand how it got there. If you could build git, could
> you try this patch and see if it helps?

... meaning, if it hides the symptom, we'd know the codepath that
causes a NULL si->base_oid to appear here is the culprit?  Or do you
mean that it is expected si->base_oid sometimes is NULL and we should
have been pretending as if si were NULL (i.e. split_index is not being
used)?

I take it as the latter (i.e. "helps" to narrow down the bug hunting
field, not "helps" by fixing the bug).

Thanks.

>
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index f68b367613..5ad71478dc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3165,6 +3165,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>  		fill_fsmonitor_bitmap(istate);
>  
>  	if (!si || alternate_index_output ||
> +	    (si && is_null_oid(&si->base_oid)) ||
>  	    (istate->cache_changed & ~EXTMASK)) {
>  		if (si)
>  			oidclr(&si->base_oid);
> -- 8< --
>
>
>> (There's a repo called dev_full, and I've got a worktree where I'm
>> working on my 3rd attempt to make it work with gcc8).
>> 
>> That file doesn't actually exist but there are a bunch of
>> sharedindex.XXX files in there with more convincing looking names.
>> 
>> 2.20.1.611.gfbb209baf1
> --
> Duy
