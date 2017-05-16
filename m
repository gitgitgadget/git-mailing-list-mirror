Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0C2201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdEPAq0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:46:26 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33825 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdEPAqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 20:46:25 -0400
Received: by mail-pg0-f50.google.com with SMTP id u28so67841177pgn.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QJhqglOJhd2Xzm+eBWM12bklwuOacKNV598oGrcjO3E=;
        b=rRX0GamMdF4kkl8QB6ttBBhjuxfr8A2/9Ho4HMgKQ0GYF5OukVXLWvwweNuQnWsy7A
         ehfGSiTbKfzePaYd2OfEgsbfDSkpsSrEGBZt/i0VQLRnslHJJXzwJXomh+dPMZFHi718
         dlbg9LNMlNo/vfL1jbqH5h93xA5h4jTcahVJZT4q5FlnwY58CfvS+vqFDGH75dUemXbX
         xnnc5deuiOUZT2GotoMmMtqsmRlDS9zQbSk3VNcoAiyt9owVQ+Pecj6MHStSLLwXZwMi
         3EBM/DYoYHlnYAgH1fpjHj+Brbbok2SajbcePUbcS93Aff38HrRjwPBsJNhpdHhSmrxr
         EzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QJhqglOJhd2Xzm+eBWM12bklwuOacKNV598oGrcjO3E=;
        b=DfuXgpYDwOVsYHIaOJy9fvvt94elT2GZLny/SAmxBNGibTJlN8eAdZ/EPClSteJUR7
         +NuHO2lBtXxcdzeUgeV1HYjOHp+tFrJWv1S5BJ40txuqEl/TAJUjE61hz5Hba+CCJVUw
         TGVbJT42mghyozKUDG4QxaUzQM2krVBMi3QC6EJFDq21tRlsNYLhKz9P++7BC0+etlY/
         xlzzLZoRd7qs5TMPmXUzrdTF4qvBdPwJhbOK6eQGydaVqH3zjlzNPouqS/b0XzpFR6g1
         VMdgCuUm1ql0xxTiVvSOlRLWNLO/q1fW7ZwAOSA5JTsW00xHr84rUtSQp2iN823w+GTF
         zncQ==
X-Gm-Message-State: AODbwcAo58JdTtEDbeakYJK9cRiz6wGI/oGpj68wBMukhFBFV1/CtrGg
        YDmb2p0ceIzXeQ==
X-Received: by 10.84.216.30 with SMTP id m30mr12147370pli.161.1494895584638;
        Mon, 15 May 2017 17:46:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id l63sm6240850pfb.68.2017.05.15.17.46.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 17:46:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style options & config
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
        <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com>
        <xmqqbmquyiae.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705151418000.146734@virtualbox>
Date:   Tue, 16 May 2017 09:46:23 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705151418000.146734@virtualbox> (Johannes
        Schindelin's message of "Mon, 15 May 2017 14:19:27 +0200 (CEST)")
Message-ID: <xmqq37c56334.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 15 May 2017, Junio C Hamano wrote:
>
>> My knee-jerk reaction matched Dscho's, but grep is about contents,
>> and we should be able to test this if we used a sensible tagnames or
>> didn't use any.  Glad to see somebody can step back and think ;-)
>
> Maybe somebody should step back even further and think even more, as we
> could adjust test_commit to mangle the argument into a tag name that is
> legal even with a refs backend relying on NTFS.

Perhaps, but I am not sure if that is needed.  

The point of the helper is to serve as a simple "we are building a
toy sample history by only adding a one-liner new file" convenience
helper, and I think it is sensible to keep its definition simple.
The callers (like the ones being added in the rerolled patch under
discussion) with special needs can supply tagname when the default
one is not suitable.

In hindsight, perhaps it would have been better if the default for
the helper were _not_ to create any tag (and callers who care about
tags can optionally tell it to add tag, or tag the resulting commit
themselves), but that is lamenting water under the bridge.
