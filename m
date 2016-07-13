Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65122018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbcGMR17 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:27:59 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35443 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbcGMR1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:27:51 -0400
Received: by mail-io0-f175.google.com with SMTP id m101so52618344ioi.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:27:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vLrttQxycCktfjvsp+kSj2rG5N5fAe3mlRkuRzb4pac=;
        b=akhqLhRJ+mueZ2gQvGkreeRD9PRZ5kRtRvihoqDXt5NcEp129mha1eSGG+0vcZsHDO
         4A+Zf693y9B3hzwvGe0iMDNkNJtmrQZ3lMSa6wHAvn0czzfurjVl5oMW/MLXF5pX3Rt6
         yV9F+idYhgRLCav/IwmtTYKPL4oqxD22VWY74KHL5qNKjYHLQOc0KpiY3SPsBzRnp8EZ
         vURei4jAdjv5sdZ5ptcdpYXVV5atcguUl8O6KafwvJwFTr7764TvmBsrY+UsE3dpS16d
         xgy+mLD99Yrm0YVy4YNZp1vOj/Zq6z++BiBC0MTycOBH8EUSPKXmFpaB4kA3KHhaTh1y
         zN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vLrttQxycCktfjvsp+kSj2rG5N5fAe3mlRkuRzb4pac=;
        b=lawNlQNRiBiJ+UtC/wkMncK0MEmdHYK1QBlmy5KCyRXZOUnQ1ZKA9TcNHXT7M1gwtv
         MjaNsZpRHtB03vzwL1eODsF3meYHhCT5a4adsK7b+yIqBK7iTfvQqH8xTZa/9dv6m2A6
         GYkqkZUaPVPij4rh7wDsT4NNp+OqZGsuedts5GO076Zb8eqo44bwiBQ5Ua3XamF8P4MF
         I80P1/E24/AvoNehKIU6+2wMWRfWEJh0b/WkWd4/0LTPHcxfhrGxNqBj2aI4fri4I8Bh
         b2R9heEoCCPNK3MctnX3ihtFNx6SJbAeoH+81kl8dfm/SDS2MZUb8llywFOaSeOidlpz
         qAgg==
X-Gm-Message-State: ALyK8tIC+naUAT3+BnfIDAHjgAMyd7F0EFCVkN9Z+Bv1o6P8SLnuHg0TgYFejVuryIcxAM773jICCgG9y2tFf/3z
X-Received: by 10.107.131.38 with SMTP id f38mr10358031iod.173.1468430864735;
 Wed, 13 Jul 2016 10:27:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 13 Jul 2016 10:27:44 -0700 (PDT)
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 13 Jul 2016 10:27:44 -0700
Message-ID: <CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
To:	Junio C Hamano <gitster@pobox.com>, Shawn Pearce <sop@google.com>,
	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> * sb/push-options (2016-07-12) 5 commits
>  - add a test for push options
>  - push: accept push options
>  - SQUASH???

Squash? I do not find a squashable commit in what you pushed,
do you intend to squash the first 2 patches instead?

>  - receive-pack: implement advertising and receiving push options
>  - push options: {pre,post}-receive hook learns about push options
>
>  "git push" learned to accept and pass extra options to the
>  receiving end so that hooks can read and react to them.
>
>  Discussion continues, expecting a further reroll.
>  ($gmane/299156)

Yeah there were some late comments, so I did not reroll right away.
I think Shawns proposal to have a receive.maxCommandBytes is a
good way for an overall upper bound, but how does it stop us from
going forward with this series? It seems like a good series to implement
on top of this?

(We also have no code for limiting the number of refs pushed, so I
do not quite understand why this DoS paranoia comes up with this
series all of a sudden.)
