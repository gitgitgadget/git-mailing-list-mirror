Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0725D20248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCGA3u (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:29:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50432 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:29:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so7639911wmj.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E4yEwGEztAZ6nV6y8m3Dg9OqJhJFKDHJoWHomcvS+dA=;
        b=gS4h1iuztlMOlGzSofLZ39QbZsFIelZwvniEczWXH4RGda25rxMZAStZTPiyZ65hVm
         E73WfhgWyy6mPDFBLqm6rQ/9KqJ5NLHrbS1NiqKoHXsFgF7NnxXt37L4OHO71KgiD2zh
         pwP2ZuNtmibp0/kpfNStFLQVo4rQFGoClLP6rbCipTsfTcZO5sAJyXDlyt5MxkL/UeRL
         hVoW9EGlMccv9Hqp43+1EMbyVzITOSnyL3EG5Utif3xZBrTtp1I4uhWDpMo92QyX0YJK
         qwlOiIDB6ZuWOErGvUSRL+GijSSBZVnOPcdKaqZLoLwd7159HU6RPwpEpPZJjviqEC13
         txTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E4yEwGEztAZ6nV6y8m3Dg9OqJhJFKDHJoWHomcvS+dA=;
        b=sRtZQCoOnfKi9o2G0tihSlaZdozpPms7JI1YWTQ34BRjhSzbrqK4+w0AWe7EupHBdA
         2G9tEHj79LLRcdi1WkII64zQBABfbv07MynWFebNBPyHKh5TPKiJWFn2TcgukVomhd3U
         j7Lv/HFNf88NP+8nKTZqX63HXjr/xASHxAle0n5WM/HB2QzfaOpxerIfGZjCj5fW7kno
         Dv6x3lTtuQ6/35Qf3AlgJ47gz8s9Ss0kj/Zd1eMIHBqeP/k/FkcWx2loT50lpgLhdgnx
         kk/ldD4MaGgpuT2Db72Bw9p4DadVr2zQBKA/2X/NzpkRuw3o7i7nPs1Sut2lLjAOqRRe
         YrQw==
X-Gm-Message-State: APjAAAVM/u0ZqNlcZdBRZevLkFC+dhAJ2DZpdkSQGbtX3MG0/rFHO4bv
        42bVmiSKgzjtMeg5mDZGeP4=
X-Google-Smtp-Source: APXvYqyLBCAOR4OXBkNalF3lxbT2P/+8H2WqXcwufImtedod2YDHicDXd4fKi3MAYqgqPdkDzxScuQ==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr4122387wme.45.1551918588257;
        Wed, 06 Mar 2019 16:29:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h126sm2430073wmf.2.2019.03.06.16.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:29:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] Documentation: turn middle-of-line tabs into spaces
References: <cover.1551853194.git.martin.agren@gmail.com>
        <4348f7b1b661181b90bf25f43c07529fa9757422.1551853194.git.martin.agren@gmail.com>
Date:   Thu, 07 Mar 2019 09:29:46 +0900
In-Reply-To: <4348f7b1b661181b90bf25f43c07529fa9757422.1551853194.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 6 Mar 2019 07:30:18
 +0100")
Message-ID: <xmqqr2bjo7b9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> These tabs happen to appear in columns where they don't stand out too
> much, so the diff here is non-obvious. Some of these are rendered
> differently by AsciiDoc and Asciidoctor (although the difference might
> be invisible!), which is how I found a few of them. The remainder were
> found using `git grep "[a-zA-Z.,)]$TAB[a-zA-Z]"`.

Thanks.  This was a fun-to-read patch.

> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index b9fd3770a6..0b057cbb10 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -31,7 +31,7 @@ OPTIONS
>  	displayed.
>  
>  --refs::
> -	Do not show peeled tags or pseudorefs like HEAD	in the output.
> +	Do not show peeled tags or pseudorefs like `HEAD` in the output.

The quoting fix here is also good.
