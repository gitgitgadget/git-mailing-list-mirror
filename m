Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6024D1FD4F
	for <e@80x24.org>; Mon, 28 May 2018 09:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeE1JsN (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:48:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37640 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754353AbeE1JsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:48:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so30499861wmb.2
        for <git@vger.kernel.org>; Mon, 28 May 2018 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mp/pD1absrv0gOpYlGztrFX1dToZ3sDHcfi7IBIZm38=;
        b=I6p7UxE1+TzvF9VV7tN/6y3yqTAMohxErEQewea1SH5oeOVXGGK/CZ+ARCATZvbgWi
         schhF5NjiVK1ZYnKQvrPVdLosLmEyY6OShNBoRTYqjBQg9uDukU1HBD9eIqITCx4Qatf
         FWqnxQ9V+mJnyzjPDi6wuhxvrXOPQ8BmZ5g/2ZpneygjAsYW0R+F0MaIxhequMaJqGsb
         e9oXYWd3gFOPbdbDOKgtSk00LpkjjEj3nwvAFWrCgHZE2WYMIf4R6yASC95ATCJzlL+s
         LjCg3jiD0J3xerCyUFijs1y1zw99nNmMiL1ZOmity2WAa8/2zxw90COpRbbKBpqyvAM0
         LTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mp/pD1absrv0gOpYlGztrFX1dToZ3sDHcfi7IBIZm38=;
        b=myAYhn1V1uHdYfhGzyXhaHutS5+h4Ruo7kVFIPozPo5lcYuUSs+JoVew3wvuZXD+5m
         c9P+cmlZLKWfAO0nK9QsMuSa/LrlV94IfBBoRFZ6TbrYaBtT5lIVUzqwT/a4HYhNadMI
         qcSsLvb37gD/WY+sndHbVTeu6q0bP2X5gDSFE5jgfadCJjUPT5f872yZJRYPdKfJfudX
         dqMttmOrDXJlxcbHPTfZ2dv0UlowxmBzU5i8o0QHy+8Lx/3Tt8z5RFPO3/rIrYh1UEFQ
         b/zLi8A5hJ8QCA7sIKEedMWPOfB8aKBRpkh5X0AdgIVOeE9zlJoxQ9shuCH032OldPke
         XStQ==
X-Gm-Message-State: ALKqPwco4xKkSTbEuZv3M18snmoSffyhIW54ML+OWE5jKiYIcaip3/7J
        flmqn3Kwkal3VIRwR5aM2V6VLXWU
X-Google-Smtp-Source: ADUXVKLNbBq/g0gURuKukePQhlXtkU3j7+PDSlPsixeuef+vpZNHa6i7xmPDhgTYG0DkQssI0wyLGQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr7191241wmg.87.1527500888567;
        Mon, 28 May 2018 02:48:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d90-v6sm11854817wmi.26.2018.05.28.02.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 02:48:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] fsck: doc fixes & fetch.fsck.* implementation
References: <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-1-avarab@gmail.com>
Date:   Mon, 28 May 2018 18:48:07 +0900
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 May 2018 19:35:12 +0000")
Message-ID: <xmqq6038jelk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> On Thu, May 24, 2018 at 9:02 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, May 24, 2018 at 07:04:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> That doesn't work, because that's for the server-side, but I need the
>>> fetch.fsck.* that doesn't exist. This works (I'll send a better patch
>>> with tests / docs etc. soon):
>>
>> Yeah, I think this is the right direction.

It seems that this 4-patch series is sufficiently commented and
earlier parts can be further polished soonish using help made by
others.  I need to re-read the last patch (implementation) but I
think this generally is good.

Thanks.
