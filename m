Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE3E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdBXR5Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:57:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36569 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXR5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:57:24 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so3803589pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cDZBEdTzX9TlLJiRi0Fs4Pwk+A4Zt/0Y7YekqMsLt5c=;
        b=flwRnuJFtipSCPSf34SlIUcSn4+Z4ED96uXLFkdbgRW26uoucjbeftwjjqsoo7EQmN
         p1mzDUQvjnUZhTLJ/QQEBT8dmbsblvGwx0Fr1sHLUQaQ9j0kdW2c7tT8Xscko77tdLUC
         sQkoPWWZ+AHoD5I04F0xkonFoQ2ElBkiMQlhUuNjJo71OEzwAyX/2i614acGVXHh+M8D
         UIQOcJMaUJQk5jGBPyQEozZIipACz1pjIBbuntEODPLz5jXXtLam5qlEI5qKbbmepZbn
         9NkRan4Kp/ob2rO7Jbt4GGKmJ7hToS/ktF/Onc5YWctC4UD0Yri2rrfiQkv8iQ0SeGvr
         sC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cDZBEdTzX9TlLJiRi0Fs4Pwk+A4Zt/0Y7YekqMsLt5c=;
        b=R4q0U4lVe+krr09zsrHNnBnotYNChSOfJd+dZU8H8S5CqaCIjApUOCiijJuI7fK+I/
         6GeMlSRqlt/OjFkPDahjCezqNsWLIA2uzIbOkKv3B9GwXzoS97g2sQmrJ4TBXjvM0Sq1
         t5Wvx6tjAJ6m/ywjVIrRkWhgNN7bIwrJoID881VImgHsYwav+2p4mq2gEllJISNiGkWV
         Q5d189PkpRpNjEBLAXTEMkdQTdHzov18rjaSmlFAFiF0z/v0P4V6LxKnRl5WV50I9v78
         0YQbvfOL9Ll/wRqFp5FPwOed8jq3R7/NR5gZZ8sMZgI0hbMM0ZOk869fmyC57T1f/J0l
         LMew==
X-Gm-Message-State: AMke39k3fXBKvW3eLn7bT46c/YeD6NXRI/J8IgNXG303nQoUVDkNmxO094HTfwiVXtJ4eg==
X-Received: by 10.84.177.36 with SMTP id w33mr5549647plb.105.1487959043153;
        Fri, 24 Feb 2017 09:57:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id w123sm16298658pfb.44.2017.02.24.09.57.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 09:57:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.12.0
References: <CANYiYbHPahB6CAUMWTRL19SfG2eYqEq7vqH8SzAPjUSV_qiNiw@mail.gmail.com>
Date:   Fri, 24 Feb 2017 09:57:21 -0800
In-Reply-To: <CANYiYbHPahB6CAUMWTRL19SfG2eYqEq7vqH8SzAPjUSV_qiNiw@mail.gmail.com>
        (Jiang Xin's message of "Sat, 25 Feb 2017 00:29:34 +0800")
Message-ID: <xmqqo9xr4gla.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull l10n updates for Git 2.12.0:
>
> The following changes since commit 076c05393a047247ea723896289b48d6549ed7d0:
>
>   Hopefully the final batch of mini-topics before the final
> (2017-02-16 14:46:35 -0800)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.12.0-rnd2
>
> for you to fetch changes up to 1a79b2f1795a6ec4c70674ce930843aa59bff859:
>
>   l10n: zh_CN: for git v2.12.0 l10n round 2 (2017-02-25 00:19:14 +0800)

Will pull.  Thanks, all.
