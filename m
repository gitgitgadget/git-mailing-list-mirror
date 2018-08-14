Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E051F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeHNXss (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:48:48 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33808 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeHNXss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:48:48 -0400
Received: by mail-wr1-f45.google.com with SMTP id c13-v6so18377075wrt.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uCpraLUregA01nEnFaE+m7yZMndvpCDhvKb887TClpI=;
        b=CVNHCuHfF6ORW/e1JhVlCmCvJtvbRsqcjwN5o9Ee84qWrgpNYQUk+O7OuL0hEtx7bd
         s64Y0Ypyd1hgFIxMLeooqAZbqANib5siOLDyh5xKnCqgIQyt8x2jwUDj3d3ZeSQCFeeN
         FLnTa5fGfV2fNsAmghA9yWh79pAOkB13uagtA7oj2bTWwLGRto0NMsN6p3a207M8NElK
         Lc2RFDExxK9fSlwDbKM/N1qB4Z0A+ifCiq3M9hzM/ijZNbMO6nA66OApauuZsiesz2Rq
         pu4bDcxymjJwOIjMNVsJZTzhXzT2qshWlBmTM5n7NMZTI+687nXr9S+wDFdklt5sjmje
         x3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uCpraLUregA01nEnFaE+m7yZMndvpCDhvKb887TClpI=;
        b=TkmEMs1ww8gkrx+8KtI3sol7cGqi0jx2cGIwuafPvkQNIiPcjILJ5nBs/nSDXNC7Ol
         IdIDah+G8cSOamDSEfFzAQ3RqzKs4NQC3NMI4qAMDGc0oc9mpGKfvJ/W/uK8Rp+JLZyC
         JU8Tpx/EcUsFadwYt0e/+XX+ZZtbTdagfYNtYEE0y81Mhj88scpkJUguKLomlnNSAKxS
         JA1kLq0/c5sx2q8QLeNlperOqRx7hUOTuf5CQFIj7JHZByWA5URGI93t9gTc0Zf3P8OV
         r4OhXPI6ncKwfAMx/Qqu+S+EL3BDuYH+g//rJACK0BDS8ye5+OUaegPgruGOmsRS0dO5
         XJQA==
X-Gm-Message-State: AOUpUlEU+68tEiIEEtm+bCNrAiZFRAz/vHAXOVyi5akKZF0UZu22puDJ
        hGAO61BS0T8nn+Mr8hZjQEc=
X-Google-Smtp-Source: AA+uWPztkHEHa9z5OhfPfA+xL9mWUcDmnWeDE7y8VW7wvUBNBDawY+l8NpztHmS98SuI+lP9FcLlQg==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr14256963wrd.187.1534280387928;
        Tue, 14 Aug 2018 13:59:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w3-v6sm16356624wrn.16.2018.08.14.13.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:59:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Contributor Summit planning
References: <20180813163108.GA6731@sigill.intra.peff.net>
        <87h8jyrtj6.fsf@evledraar.gmail.com>
        <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
        <20180813210617.GA19738@sigill.intra.peff.net>
        <CACsJy8Dbf6+ZjLk0vgYvzhwweOdp+5QTno+ejoA-r2YYsdpzrQ@mail.gmail.com>
        <20180814144711.GB3441@sigill.intra.peff.net>
Date:   Tue, 14 Aug 2018 13:59:46 -0700
In-Reply-To: <20180814144711.GB3441@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 Aug 2018 10:47:12 -0400")
Message-ID: <xmqqzhxoy88t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One problem there is that the prefixes are ambiguous (e.g., Jacob Keller
> shares with me, and I think at least one other over the years). You
> could look at the author of the tip commit, but that's not always right
> (and in fact, counting just merged topics misses bug-fixes that get
> applied directly on top of other people's topics).

Yes, a fix by somebody else to a bug that was recently introduced is
safest to apply to the original topic and merge down; that way makes
it more difficult to merge the original topic to older maintenance
track(s) without the fix by mistake.  So a "topic" with commits from
multiple people is not all that unusual.

Thanks.
