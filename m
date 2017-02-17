Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26B8201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964779AbdBQWbj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:31:39 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33899 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935114AbdBQWbg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:31:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so5914207pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yemGPj7c6OO7Dz7k5EsmFEj7R5cpJMVuyQCP/o99gtg=;
        b=tb+bleSOJmC7SWcaDLtrMuHQutZ6PThLj8cHuIhvRtnVBhBLVZuAmy5f5VtCLYVt4X
         bhrxgriIcKd8lbeeWj5ZgxitvX3JudL1Zz2qwtzEeYtQBeTbbKH7cdxWXMrMJ79FO2Xn
         RLnh+M/PTakLkRyF4Tcpwq8rAqup/WG+JMaB6DSB+R7VjAdtWRcEbuYpsCttRqYc/KVY
         A7KTtb8DunRm//u9x+nAppJ0r/vQNqlSJ2yZcKIqCUhLo+7BNJMFfJpHtUo4pVkI4WFI
         51Fb25HHCRwOVrm2xzkAvPWn1Z74HrNCVR6o0AOxD1QsaqV3rjzlfWdOCrCWXasWiZ5o
         HVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yemGPj7c6OO7Dz7k5EsmFEj7R5cpJMVuyQCP/o99gtg=;
        b=px6dJV0VOXtz+NjitLKChzPuAhOYmN34e4WBJjLKJjedBbpxE0PN0Y0JCOt0X1u8jO
         lQNtAcnzpp/A3yjK03ZB9oqPNyB9c/GQVRYiMa8Wtu8XTXOXo54O8OJOSoH7FhMj4RsX
         Rf/uxQ6FM42y0gZ+T122r8LrZO7620DHTesVjak5CdqfdAOhKlaaLAlj7Tp7GxQO06XJ
         0iLl30R3bF13kYg1LAYdKHJksi9cdZ8NrRKQNGHr2G0qYybJYbA3pkPsg75J6dKP/tdo
         0PegOfn8s7LmRx0ekAnXBQYkoWfw4kj5QR39Wxt1caoV01Jk0gKzKCe0ZhCgJQVIWP37
         a4Hg==
X-Gm-Message-State: AMke39nnzmU0evzTcI5ZLNwWok5K7wgmQWHvMSzMX9G4YYBrE9gZxWLolrt+sdvPB+h7oQ==
X-Received: by 10.84.212.136 with SMTP id e8mr14391567pli.140.1487370675008;
        Fri, 17 Feb 2017 14:31:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id m136sm21523697pga.22.2017.02.17.14.31.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:31:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        hIpPy <hippy2981@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git alias for options
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
        <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
        <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
        <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
        <20170217221317.e5kby2jwutdznnlk@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 14:31:13 -0800
In-Reply-To: <20170217221317.e5kby2jwutdznnlk@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 17:13:17 -0500")
Message-ID: <xmqq4lzsqwjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 17, 2017 at 11:10:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> The most gentle first step would be to try to turn the existing config
>> options where you can override cli-options into some declarative thing
>> from the current ad-hoc code we have for each one.
>> 
>> That would be no change in behavior, but would make it easier to
>> migrate more things in the future.
>
> Yeah, I'd agree with that. It does not change anything for the users,
> but it makes the implementation less annoying.

Yup, as long as that declarative thing (presumably it would hook
into parse-options that is already sort of declarative) allows some
command line options not overridable with configuration, I think it
would be OK.

I do not think anybody wants to see "reset --hard" and turn it into
"[reset] hard = yes" configuration, and we should not even allow for
that.

