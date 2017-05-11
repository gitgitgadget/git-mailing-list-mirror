Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E661FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbdEKJlq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:41:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36182 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbdEKJlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:41:45 -0400
Received: by mail-pg0-f66.google.com with SMTP id 64so2921999pgb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X9+6f0CTftP4meLJeTNA3RRedvh6yVZEq5krZkLfi00=;
        b=iyGScpaOoJ3hZmq3/HMrcGnUkgatci4AW1MPCb462USL22WTGJqleKSQAOvsPwH8cY
         k4nsZ3BdXOvPRoSwq5SN/d6SJk+of81/R2JDiAZvSzeCT8Rzng2Uzz1xSiazol46C8im
         ZQlLHn4OqlOVsOH703ZEG/eAuBbLxEQBNimQGSVruLfeOrPX8WB4RcvYG2XLPBKDPkqJ
         hrk8jT3yQDoroGMgHaJM0KLaAfU9IbfMywuzi1ezzsFgsFDWUJMiMWCU+MA8OYhNSrcA
         hrRx3QpKHYJkJHymUjhg47NIAkjKoEwK6UfmJIiIp351MPkd5UYY8DbltffOk3HD0HXn
         m5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X9+6f0CTftP4meLJeTNA3RRedvh6yVZEq5krZkLfi00=;
        b=jBA/+reW9PbmPgKLuoy8pG81NZWKsQac1vzclm7phzVGfJofpOd8f2GB1dfbIDSNF2
         NbCtLCulmIAdg79i1AUHCD0fQx9cUNVYsLgvigS9+y9QllHoZ9LysXC8OOGYb62BthYT
         DBbORm59Ih1WonabadjMvmVsjvTi8wSxhNZ5ytbB26ZLZ9IH6mYRhpi+3cKc3wkkByKz
         KDJgQpyOFycM5bcJDrPs/cC1w273f0OKENmhjYQLpCjs6Ld+q/z4P7ffymGBG5CQoojW
         rDe2wwcRDQUkSNWl7us0l8Px3b4zjBthuO62TuSeBIW6eg2idThcnaB+1ARhs/AGEuvf
         D3Ew==
X-Gm-Message-State: AODbwcB4wWll1ROVodSOSLS5+Me4XMhn7+/UiPgJ85+qCQcbwoMaZvzp
        b2B3cKnYJ9hZ7A==
X-Received: by 10.84.136.135 with SMTP id 7mr15190145pll.33.1494495705120;
        Thu, 11 May 2017 02:41:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id r1sm2614867pfj.68.2017.05.11.02.41.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 02:41:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] docs/config: consistify include.path examples
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
        <20170511091430.jwpbyca3m32wterq@sigill.intra.peff.net>
Date:   Thu, 11 May 2017 18:41:43 +0900
In-Reply-To: <20170511091430.jwpbyca3m32wterq@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 11 May 2017 05:14:30 -0400")
Message-ID: <xmqqh90rafxk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Most of the include examples use "foo.inc", but some use
> "foo". Since the string of examples are meant to show
> variations and how they differ, it's a good idea to change
> only one thing at a time. The filename differences are not
> relevant to what we're trying to show.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And yes, I just invented the word consistify. "make X consistent" hides
> the meaning at the end, and I couldn't think of a more concise verb.

Yeah, "remove unnecessary variants from X" is the best I could do.
In any case, all four looked sensible.

Thanks.
