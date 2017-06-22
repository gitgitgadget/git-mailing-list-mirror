Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B3C20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbdFVUVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:21:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35658 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbdFVUVC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:21:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so4493326pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j6E8chvu49muB+z/5N8DIVV1/sWdtRPO2LhSkAmLGmI=;
        b=oY/7BejL+cOk3OeQYEQX6aNb5JzT7nQPsbzRS13u/ul/PuoFU9pJp79X68Z8o/1uYx
         u8sNtHK/RY+BG/TR/PfdKS2ExAlpWc9Qmz88uHQhX9abkVd0UGGemYGvTjiN+vV2wOv7
         nSMxqqF3m0KTgjv9eKoySIfeRBLgHjGMkuo+dAI6ws5hktSzLnEXMPjmXRYN1rSIGm3l
         2jkFnAMkT2gVwvKw/ga+z3x3+ixOy1gQ7tA/wsa3S4rhs77u9ZxMVzbmqO8C1drA8OR3
         yFh7IPqtvtWHR9KIwrKrydMpkb7Iuoel478593GkpHfYseWadOmF4IJP1ldCXT4ZGZwJ
         I7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j6E8chvu49muB+z/5N8DIVV1/sWdtRPO2LhSkAmLGmI=;
        b=ljeyVqQfXnn0gHWVCjQcs63oEXul6/jpU0+/kUnts5h5+avXyl6YEgsW08mdddj8xX
         PkQufeC2BG9I/HzQifFv+giNy/z3TEZzGUW53vi20xn87BeHu25dFBfiRPp9Afz3jMdh
         hR8verMie7IkzIbbVBWhH1IzyYxw5tTzcl1EdwdjW3dU0A9WFri1BxqAxyJBwLwkURGC
         O+GEvSJgw5gJkDiM7c8Lpy4yftUlf+NmBdcXKmllw70shTrXOgR5S5d2firMaY71zWF0
         wRThwcSAQF6ghI2/5fS9MbAfMZqUgJP1abcMSCusoxXwfEq2xYgEQPkC07AFA4LKXPoU
         6pGg==
X-Gm-Message-State: AKS2vOzjXunsc32T1Dr83fkZuyA/bkXy0dykRfhvLfixb5JUGAAJMjs2
        wcZncs3Ks60qLA==
X-Received: by 10.99.122.3 with SMTP id v3mr4353396pgc.98.1498162861296;
        Thu, 22 Jun 2017 13:21:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id 189sm4875856pfd.50.2017.06.22.13.21.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 13:21:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCHv2] submodules: overhaul documentation
References: <20170607185354.10050-1-sbeller@google.com>
        <20170620225650.7573-1-sbeller@google.com>
        <20170622174659.GA124061@google.com>
Date:   Thu, 22 Jun 2017 13:20:59 -0700
In-Reply-To: <20170622174659.GA124061@google.com> (Brandon Williams's message
        of "Thu, 22 Jun 2017 10:46:59 -0700")
Message-ID: <xmqqlgojixjo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/20, Stefan Beller wrote:
> ...
>> +The configuration of submodules
>> +-------------------------------
>> +
>> +Submodule operations can be configured using the following mechanisms
>> +(from highest to lowest precedence):
>> +
>> + * the command line for those commands that support taking submodule specs.
>> +
>> + * the configuration file `$GIT_DIR/config` in the superproject.
>> +
>> + * the `.gitmodules` file inside the superproject. A project usually
>> +   includes this file to suggest defaults for the upstream collection
>> +   of repositories.
>
> I dislike this last point.  Realistically we don't want this right?  So
> perhaps we shouldn't include it?

I am not sure if I follow.  Without .gitmodules, how would you, as a
downstream developer, bootstrap the whole thing?

