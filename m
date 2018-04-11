Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA081F404
	for <e@80x24.org>; Wed, 11 Apr 2018 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756917AbeDKTKl (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 15:10:41 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:41785 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756889AbeDKTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 15:10:18 -0400
Received: by mail-qk0-f175.google.com with SMTP id s78so3087433qkl.8
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EPR9FSHeYFyrCUvzKyvzm1vfsXMziFGKiM8wt8yOt9I=;
        b=ucD+7Ge9Kf8Cx3kufLgFTnOUm1ph5n6mv5NvGtp2gWOjJ2mMtMM+DI04x2ghjazwjl
         y7QSAy0wOCjN/eyRoCmGknqGNCIUHTJkrHfrq5sVGjqxNbTcncCT8ycViAQ8KktDJV+x
         T0IkewWEq21DU2NXqCnziB/8D8gtGbCTyJ393x/oyGXKV/RUc0vOj2RqZpp4pfZG44AR
         usFkxaI8JurPJ/ljLa71Yy2IWO7tbyEIOuSelZm8HLGi/gmdq4UKtw3Yp9uJ3kVoDTke
         szIRt50BNVl/t3VVKfb7iui/N2+BZCP/XWoj9RkYezfeDb9q0ZB4lH5XKS6bEh9QugsY
         O5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EPR9FSHeYFyrCUvzKyvzm1vfsXMziFGKiM8wt8yOt9I=;
        b=kgjbpI7+dH18pPknydLzc/7tf+iyTP4I5/RJpoEXIAVrylx0SJb0a895MsoXorZjsO
         S2uCXemd+gyiGacNciYSud6rqKdqNz3TwF81dPHM7Sw4dB2zujhmUXpuUXHJsfPDhn8m
         6TtCQ/FvuNpjj+powLzb1TnASsV3a8IVv9xwFqIpcLjlH8kHYG+DFfxr/nuCAM3Ny/gb
         9RJR/u22Uu+Kf3vIzbaANgi2uy+xLiuKxWFpczU48ZHhPiD5Iw7c8Egtz9pV8ycJqKkD
         Hk/SLqkSsRdxNZ4kst+NtT7BYKBY7+Sypx6JZteYbPFWzLTEFlXFAIQ24TCpy+QlmDc9
         EPpg==
X-Gm-Message-State: ALQs6tCzSsW/X3iNdgvaeYMNGNEkVQ6z551Z4KlIAJojai15r1LN6e2U
        WKlIin7WR1o7ROiso2Ce8EeC7Q0wCFf71bQ2fn0=
X-Google-Smtp-Source: AIpwx4/RBw4RUdip+gCaKD9QMU/bAVJLLw8p++V/QAvkL17E7DBYpcvLenQNFgmV9nkWRGqaCMcNo5VepiLnK2MJh8A=
X-Received: by 10.55.3.140 with SMTP id 134mr8714653qkd.26.1523473818018; Wed,
 11 Apr 2018 12:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 12:10:17 -0700 (PDT)
In-Reply-To: <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
 <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 15:10:17 -0400
X-Google-Sender-Auth: s4onvecF298KyfJsJluEXYHpwlo
Message-ID: <CAPig+cRfQgz2tCab2d9g-XznHORW0FJvDKS4fe85JkLPxm2HMQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 11:35 AM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> On 10/04/18 13:30, Johannes Schindelin wrote:
>> +The `reset` command is essentially a `git reset --hard` to the specified
>> +revision (typically a previously-labeled one).
>
> s/labeled/labelled/

American vs. British English spelling.

CodingGuidelines and SubmittingPatches talk about this. Junio
summarizes the issue well in [1]. The TL;DR is to lean toward the
American English spelling.

[1]: https://public-inbox.org/git/xmqq4m9gpebm.fsf@gitster.mtv.corp.google.com/
