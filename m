Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD97B201A4
	for <e@80x24.org>; Mon, 15 May 2017 01:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbdEOBUx (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 21:20:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36316 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOBUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 21:20:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so10123314pge.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=enL4YN0RD7hXHqLV9evqHO2AcpRvOr5sCp/H4QJQndI=;
        b=WsW7YPJWmT58NMynLJK3Xd1A0O7hJTuAwtkMssNk7AS4JAIadZ4R8h7cpsYpWZZGnE
         BgboYwjCEtV5MUN4ferLrHmnKRMawgjusf4wwJ6AJwJmEwErqxNDdczPcU2sY3t1fu6/
         ogpozO0Vs4mKH+On8DU8qjvQi5YWKA1KxsZcwxrLYQNKxfIsAp10q4diHVWuqGAzkZgw
         mTUfIQ/H30zJHKa8zO7JDiduK6WVeCYLhkcGiGdFgi+WbzdjtlRALoGelt0FQSWxa/P0
         lNKubBA8c3d1xrWMSTMbJzt8JvYJw78FT3M6bSK5OuiquTOPf/MkbrAxOpbb+z5r0Un4
         NA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=enL4YN0RD7hXHqLV9evqHO2AcpRvOr5sCp/H4QJQndI=;
        b=j0mdC4Rx8Pk5aoRs61+G4xPNmwBSpzwYFv9qvMHows3Lm8wCRGoHQfDG4ucoERwxuW
         8FljtZzLYAWR9Iqj6a3Fe07NzYtiy85utoRc4NBiuLPUJSm5C/Vhb1Qs8qn0WAv/lLVD
         Y1WuiQBbwXiXOinK6gjARsvmCDMQUZ9FbGsw6OVDkYPyKg+yvKN6VPv3poFXYCmqLAx/
         GnVMDD80BkEWGgz3aPHXlO7m/p9iGQURqLyOd9/zqCKnkL7iDaH2QYpFxvesF7GgytHa
         UTkq/6shVsYNOlnCwiCLtI4NCHe0pcTScCfVJPV2mN3NDPpfkw+8FImJQYQFTcR6Bz1d
         i7sw==
X-Gm-Message-State: AODbwcD9ChGZIGjs9bb24PdEOlPrC4ZLr56cPdKMrixM+lLMOqVnY6t2
        Umdqlp3AkYMd/w==
X-Received: by 10.84.196.100 with SMTP id k91mr4999551pld.165.1494811251763;
        Sun, 14 May 2017 18:20:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id j11sm16792108pgn.38.2017.05.14.18.20.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 18:20:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     arnold@skeeve.com
Cc:     Johannes.Schindelin@gmx.de, stefano.lattarini@gmail.com,
        ramsay@ramsayjones.plus.com, neleai@seznam.cz, j6t@kdbg.org,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance guide
References: <20170504220043.25702-1-avarab@gmail.com>
        <20170504220043.25702-2-avarab@gmail.com>
        <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121214470.146734@virtualbox>
        <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
        <201705141914.v4EJETGf029570@freefriends.org>
Date:   Mon, 15 May 2017 10:20:49 +0900
In-Reply-To: <201705141914.v4EJETGf029570@freefriends.org>
        (arnold@skeeve.com's message of "Sun, 14 May 2017 13:14:29 -0600")
Message-ID: <xmqq37c6zzim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

arnold@skeeve.com writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > - rather than scraping the files from the CGit website (which does not
>> >   guarantee that the first scraped file will be from the same revision as
>> >   the last scraped file), I would very strongly prefer the files to be
>> >   copied from a clone of gawk.git, and the gawk.git revision from which
>> >   they were copied should be recorded in git.git's commit adding them.
>>
>> Wow, I didn't even notice that was how the "original" came about.
>> No question that we should be taking from a known-stable snapshot,
>> not from a moving target.
>
> Gawk's regex has been fairly stable of late.  But marking the revision
> from which you take the regex is a good idea in any case.

I do not mind taking a snapshot from an untagged commit (instead of
sticking to the last tagged commit, being suspicious about newer
developments).  What I was reacting to was a loop like this:

    for f in $(find . -name '*.[ch]' -printf "%f\n")
    do wget http://git.savannah.gnu.org/cgit/gawk.git/plain/support/$f -O $f
    done

i.e. allowing wget to grab paths out of possibly different commits.

Thanks.
