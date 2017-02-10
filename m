Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020191FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbdBJTiV (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:38:21 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35815 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdBJTiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:38:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1131614pfx.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TTyKm3hn2g2LdpM3N2x6mOya6ICMP78jjhMoS5hUF+0=;
        b=gInm+YS+9zeMhLKVr+DYJbQRFFcIjRZfUE0AURdY5WL7vlyeiqEsPeN17EP6yFyUVt
         Oc8MFFYBvahtMfUvR7+T8u1/LFIUphSE1ZdamMmPywKBPd4P0wbeAOmbNBXRz67n06X/
         bAI5xZyqNMyrFXdrY2h3f2BGlB4NyeflBJw/F2eujfwlfbCfRHLHwP0KI3eQmg2qtD4f
         H4gzVDyWLGSfSqhVTexHLtycYsvfYqyqChj/pqrU1eP6Uax9eMQ6+F4AXvjecGWzj+0e
         NAe7b5SQUEukjmA+w2w6KRqWFxPFDCmTmIhU9e+M7Yha+7RNtvkBwC2uhjHh1b8/4FKa
         uuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TTyKm3hn2g2LdpM3N2x6mOya6ICMP78jjhMoS5hUF+0=;
        b=Umxcr+N7IRib00j4UtYBxP+2LXqkmkAKR65QK9CO02v7DyNila0Rw4XqY/rMKFbnhs
         XEMMGsHa1WCi2JlVNawturppnp3hfgUdWth5ExpmE5bfa5FhQLxbSLEdTE8iR44yqUXg
         gfA3sKcikQnHv2DmnClswaQLa2H2rR5Wgko76DE6KSIqBorIfBo/HmyNLyUceSMTxvjx
         6RP5T12NnnI4bmojL4FErN1PFU3+7Z/FcwLQXnSV4/NGiL+PTY8OuOwJ33rLQI8quec4
         MlBuRYHlBw5bnGYE+Lb1v00N1/d7rptT/GNTsBIoYNxFYqawW2CHyh9u0/8VZVfbM30n
         2IGg==
X-Gm-Message-State: AMke39ndPdkqWvTJjpCOltzTzfhlaHAoSmt33IGIYyrPZKIKy/o77ad/JGcA5XnqRBa/wA==
X-Received: by 10.98.50.66 with SMTP id y63mr12197751pfy.21.1486755500504;
        Fri, 10 Feb 2017 11:38:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id e4sm7150004pgc.45.2017.02.10.11.38.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:38:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     git@vger.kernel.org
Subject: Re: fuzzy patch application
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
Date:   Fri, 10 Feb 2017 11:38:19 -0800
In-Reply-To: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
        (Nick Desaulniers's message of "Fri, 10 Feb 2017 11:20:59 -0800")
Message-ID: <xmqq37flltuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> I frequently need to backport patches from the Linux kernel to older
> kernel versions (Android Security)....
> ...
> My question is, why does `patch` seem to do a better job at applying
> patches than `git am`?  It's almost like the `git` tools don't try to fuzz
> the offsets.

You diagnosed correctly.  We do allow offsets but by default no fuzz
and that is a deliberate design decision made in very early days.
You can pass option to reduce context, but that is not the default.
