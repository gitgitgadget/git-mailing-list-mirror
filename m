Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA85B20357
	for <e@80x24.org>; Sun,  9 Jul 2017 07:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdGIH5M (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 03:57:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36461 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdGIH5L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 03:57:11 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so9061756pgn.3
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cDoB+4iQK8yHOW1+vh8pAAZ2+PPgfVr9mvJ1h42vzDM=;
        b=JinkDXSB6DvUhZlY2T+tXSf5xYFARm1W5p0xjHugliQvLOFutXxhszwkszi6J+GZTc
         YIxWYrJ50fiJFy+2XkbXbmM/Wq8cwnT4Uip0J9rr3N0oHJrzgK9RVbYrvV7EV17lkmor
         pVYoly0hazrNCX9BkBhA299dJOOWDLLD7VczX69F06kWMXf4wEGczTyBll1ILsGD8U41
         411dClGMbl+aZzr1uFuPSTHouWp8I1QoePuyjLhm1JLZCB9UrGtedKg6TqWdl1o/OIRe
         7smLt13BnRtmp3DVBjfQVos9CAhmQhEzRnY3UsxIICqNfwGjdowPwm2RuM3nz55u1Zo1
         520A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cDoB+4iQK8yHOW1+vh8pAAZ2+PPgfVr9mvJ1h42vzDM=;
        b=NWZu/laXDlzzgtVu7G6h5yH2XP82mIL0ovr2pKbzsKE2ub48p350mRrUz0MwB6oyuW
         Mhrb+5gFsVe3a8Ph7o31RfKuaZZhGC6wgyxqtTrYz4mIiO4U5QSLMwP5qm4EdWj8EtFi
         xyK+iOlQVepqyVLrHfYwTOKfuf5vgQWViod4Os8JZktr/Otr9/tZPFmbhON5z1uY4IEI
         z8ocYkA2ZzOSzqkzdbs2MbddWGAEuqsLgGkT59outKE9zsX6uPg9pomxUv9bOLlXuMj4
         etfv/GPAVhDZM14U611wgIBpiu3x2vSWLWaHJ6zsd2en1re1rowj1E11yK7mYVNPdq3a
         bagg==
X-Gm-Message-State: AIVw11107HkMBsCL5d11v7rh2n+8lDkMT8HWUV4GqSNszFgreyC1vcKh
        Gyd82hIAXhc3BwUeRC4=
X-Received: by 10.99.123.18 with SMTP id w18mr9247259pgc.122.1499587030225;
        Sun, 09 Jul 2017 00:57:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49f8:bc86:d515:b7dd])
        by smtp.gmail.com with ESMTPSA id w66sm17451421pfi.63.2017.07.09.00.57.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 00:57:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     astian <astian@eclipso.at>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] Doc/config.txt: explain repeated sections
References: <20170708203413.16442-1-astian@eclipso.at>
        <20170708203413.16442-2-astian@eclipso.at>
        <xmqqfue6a5va.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 09 Jul 2017 00:57:07 -0700
In-Reply-To: <xmqqfue6a5va.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 08 Jul 2017 16:03:37 -0700")
Message-ID: <xmqq7ezi9h64.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +Multiple occurrences of the same section are all logically merged.  (There's
>> +no special treatment for variables defined multiple times across physically
>> +different sections, the variable is simply made multivalued.)
>> +
>
> Looks correct; it's a bit surprising that we didn't already mention
> multiple occurrences, but I do not find it so this is a good
> addition. 
>
> I do not see a strong reason for () around the second sentence,
> though.

After re-reading this, I am wondering if the "made multivalued"
above need to be made less confusing.  For a variable that is single
valued, the usual "the last one wins" rule is applied---it's not
like

    [user] 
	name = astian
	name = gitster

makes user.name "gitster" while

    [user] 
	name = astian
    [user]
	name = gitster

makes user.name "multivalued".  In either case, the last one wins,
and it comes not from the syntax but from the semantics assigned to
the variable in question.  What we want to say is not "multi-valued",
but the above two forms both mean the same thing.

But perhaps I am needlessly worried about possible confusion too
much.  I dunno.

Thanks.
