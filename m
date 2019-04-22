Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155261F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 11:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDVLVb (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 07:21:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37076 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfDVLVb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 07:21:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so14143390wmf.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=afExLiSeAgOM3HHOslIWXdr4eNxKT747CpN/bUHrht4=;
        b=IwjMx493IoX2pQVHtzbcmO3uaToO382syVJURHiQyQ8LoLqbkTllJNgKJiMb0mBkmZ
         unsyuDs+w5f2FtKi5KXEzFHuNaM08zvvRQ1IusT+lzcOiPC2HkQbZLtkIrHSF1xOawme
         BTpxv770++II0SzK/Jb5+MPBZgzzoBhdcfk+rPoeW/hYtwj5kdB63C8a+/Bn5uqHma2n
         GRQbKlXiot3K5ofph0DveCNMQ0hfwuH/8eYljJtPHF45QJaVnNkPJXQ0hiDPG+A9R+Pn
         5vvIhv5tGMFSVo9tG1qTP5odMGLBgQW/jGZKjNupa5eqgTUHieoUNwnx9r7JqtNAG0pR
         iapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=afExLiSeAgOM3HHOslIWXdr4eNxKT747CpN/bUHrht4=;
        b=lhrzLhLN1IBLqneNeK5ml6GCnlRAh/jvwsEHqwKmRBIlpgc95CbMZyhzDziLJhH/vB
         VBQV/z8lDxK0+pBgyMnEx8B6a/HZ7q8c3pqG89/b9myUHhKWpXxTF51xeGlYA0vfF6ph
         dwhEfp9EXKTEdbM1l+1y+atBHTeJc0lB6Yn7ZPbHya5bWTVMZQDdRUkL9s6cjOI/o/lA
         Y1MQl6gD4X0ntMOqM6nPEgdKeSmhQr9HKbk33r5DRkiJmRkDyZE7Me3Jr8zHCUl0TZ8A
         6Yune7dh9bSxbc5spun15fLuvc+NA5TiJwxQ6mEeUiZ0rxUqiPCprZ/6IsYLz8mbexB1
         c/oQ==
X-Gm-Message-State: APjAAAVFKSZRFRTw73+8mQy8buRvNVu+QxbAoCep9kds+kA0yS3/tHA/
        RQ+NvztmRY1yLdVAasRMzJw=
X-Google-Smtp-Source: APXvYqw5ZmQTRDZzDbH9MBkkZr9tX5YtbUk0B8hhW7vJWDnBt58vPiGHRAn5xnRjIB4W+N1fVE6ycw==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr11500191wmf.77.1555932089733;
        Mon, 22 Apr 2019 04:21:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c20sm15324262wre.28.2019.04.22.04.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 04:21:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
        <xmqqv9z67doq.fsf@gitster-ct.c.googlers.com>
        <20190422073935.GA7660@archbookpro.localdomain>
Date:   Mon, 22 Apr 2019 20:21:28 +0900
In-Reply-To: <20190422073935.GA7660@archbookpro.localdomain> (Denton Liu's
        message of "Mon, 22 Apr 2019 00:39:35 -0700")
Message-ID: <xmqqmuki70av.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > -'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>> > +'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::
>> 
>> Why doesn't this example say "HEAD{tilde}, master{tilde}3" instead,
>> I wonder?
>
> According to the doc-diff, it doesn't really make a difference:

I was wondering if "HEAD{tilde}, master{tilde}3" gets formatted
incorrectly and leaving one of them as literal "~" was a deliberate
workaround.  I've seen a quirk like that in AsciiDoc before, where
one pair of some quote that behaves sensibly starts to misbehave
when the second pair is added on the same line.

Thanks.
