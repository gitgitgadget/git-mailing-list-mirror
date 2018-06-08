Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00DC41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeFHWxL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:53:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52832 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeFHWxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:53:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so5764384wmb.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zD11sJxh8VMHnr13VPTd8xouyC8fWzALPPUnR5LgzoE=;
        b=rxSeyG4dQizdZNWJYjzsOqZL8SMbnQysdM8n5IeKuZjnNyxmxF3zamfTD9Ygk6NgyQ
         GgGpo4yWqmJpsGnZIV1QrJSc6CgxEj32u+eO/AzV5/mJjJu2G/RXfUPSovoT1ZTGLR4t
         8P53nOidplwY/ITnFPXXqRf2XLs9jdoCDL+Z3e8GChWqGYQ291w7jXFOTBrQiRo0U1Yk
         ZEKeWHCryrUuNetJ/FPTPBiCECt0dWXUmt9dLnZbhTM04M9VDo3RU1NR+0azj+5b2Hai
         /tWfJFe/b1ic6WLRZc2b3xZ6lWu3QxRefu2NZ6bPTt0o3Im0XEZ4GeFQ5APY/TR+Eayx
         7VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zD11sJxh8VMHnr13VPTd8xouyC8fWzALPPUnR5LgzoE=;
        b=nHCCYecTvXU8xiYtQ28FLa2p70rbtCDoUQ+WP06JBEYgINswcUTeT9rf2d8mRhfiWm
         14ZhqaQAvkTBQKs/MtLtgLe2fO2HEcuWOFKXw2XYUCDKYArD1cobkpVjIg3p77+MoIhL
         peg2aJALjWXo0uwUP8hfVhQEaK2Ng82qiYLqCe3D/wwxultqF25goqhtp25+vVfMKl1d
         uCgP7kIDVHq+m0iIKSQMnnKaB5BDBOw1VzBmWB2hz6uXbPq0OjTE4NuF1NASSpDwSTeP
         YmDqFKB4BQpkkcA10ZjJi9efqaoulhloTMxcfdTLg2wicagRUfUzSwqhnP7rIxPElJyX
         0RVw==
X-Gm-Message-State: APt69E0wh8FPcrWqyd/nu1nNa9FwGn1myzPLiOVhE1X7//2VSlw/flha
        4cb6gC4vRWqoyJk8WDywMkY/hOZZ
X-Google-Smtp-Source: ADUXVKInQmQ/A6CmGJZMKDw/PqmXPilPhTker/BsLIbNqzKDYb0Wt0RIKhCrSYNXYDMsikDeMl3nnw==
X-Received: by 2002:aa7:d84a:: with SMTP id f10-v6mr8808628eds.157.1528498389200;
        Fri, 08 Jun 2018 15:53:09 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id r10-v6sm7695321edo.77.2018.06.08.15.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 15:53:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, David Lang <david@lang.hm>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
        <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
        <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
        <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
        <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
        <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
        <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
        <20180608025313.GA12749@thunk.org>
        <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
        <8736xxzof3.fsf@evledraar.gmail.com>
        <20180608120320.GB12013@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180608120320.GB12013@helen.PLASMA.Xg8.DE>
Date:   Sat, 09 Jun 2018 00:53:07 +0200
Message-ID: <87efhg51rg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 08 2018, Peter Backes wrote:

> On Fri, Jun 08, 2018 at 10:13:20AM +0200, Ævar Arnfjörð Bjarmason wrote:
>> Can you walk us through how anyone would be expected to fork (as create
>> a new project, not the github-ism) existing projects under such a
>> regiment?
>
> I don't see your point. Copy the repository to fork. Nothing changes
> about that. Nothing prevents anyone from forking a repository which had
> some of its author names removed from the commits.

This basically the same as saying the whole notion of Signed-off-by
should be abandoned entirely, since in this case the fork will only have
a partial set of these.

The point is that we're recording information so each line in the
repository can be traced back to a SOB.

These sorts of take-downs would destroy that information, and the
proposed solution of having some party retain these creates a special
class of free software users who are capable of following that line of
attributions.
