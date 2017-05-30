Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F55D2027C
	for <e@80x24.org>; Tue, 30 May 2017 23:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdE3XSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:18:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34175 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE3XSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:18:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so108752pfk.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AAzeVI8F6nfJj6jYoVuYmwxN6qyTPXPj4W0dsRuzZ9k=;
        b=LA6Dlg8MctjK4LePjhQeJSv7T3qyAIQ9y87XPqojtHV8nw66usj7mEcq5df06AYJAr
         0BRPrukNmo26VPlKXs/nQ0/wYwjVOGbEMzdCw4Vm3SATYAHVDhiEh29QUMMBWeSfRE40
         CXMgCSs9UNiLxXZcrr3ZEvk85KYlE0bVO3dcGrPtv/q7Lcxho/I4aGaCWYI6E3tMZ91E
         kmTHM/uUh3yaUz8GN6jjcMbLvhhV74F186zzmZZmpALw0KUjvBgvsJFJk9zWOisqlRkv
         jqA5ubbODqRCbiHAvN1kbfPNU1rBpy96cKJ5hUrsufkP5SU8iGTjUNJS651T3uFDKC8o
         8kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AAzeVI8F6nfJj6jYoVuYmwxN6qyTPXPj4W0dsRuzZ9k=;
        b=bWh28VTJT+hO1D8gu7FVw1UiZhk5D2vldN1ev/P2NEjBjKao2HgJaIFhYVjVQVqflC
         kHSXRPc66a7BKMOPyi78BMzcpbZGbhk/RQj6re6UPecNEiWWjm2rjBr7y04TsM4WKDdd
         7Ciq3a3OyzbjmIaUyq/4TLEdXVvP5qyRyfkRnXDg9fJ4c48GPPia6gmtqXlVEcvYYdfQ
         3lpi9kHo+B1+Pn/At5GzVd6rz3ZFprcS5kgY3veIrSviYxhBCqFe0ivZCN7RyZh3J+SE
         HIOpf05TKftb0w8fkp31SA54G4nyAdDz6+H+0CiIPvVMgMRjkxXk7xIrB3sIgHasPx0t
         3+iw==
X-Gm-Message-State: AODbwcDSqBOCHFshayAFsdrHlJM3XZEr5kq1JvBYKmBSpDWgc5jAydT1
        YIZavi4Q4hs6aQ==
X-Received: by 10.84.167.168 with SMTP id d37mr59604512plb.125.1496186314074;
        Tue, 30 May 2017 16:18:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id b1sm28573875pfc.27.2017.05.30.16.18.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 16:18:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: Improve description for rev-parse --short
References: <20170528143322.8580-1-asheiduk@gmail.com>
        <xmqq1sr7dly4.fsf@gitster.mtv.corp.google.com>
        <787ad1fe-9923-d47d-79b0-8b0aebd8eb9b@gmail.com>
Date:   Wed, 31 May 2017 08:18:32 +0900
In-Reply-To: <787ad1fe-9923-d47d-79b0-8b0aebd8eb9b@gmail.com> (Andreas
        Heiduk's message of "Tue, 30 May 2017 22:40:47 +0200")
Message-ID: <xmqqfufm9bnb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> ALso: Did you remove the `linkgit` by intention or just by accident?

By accident.  I agree that "Same as `--verify`" is a good way to do
this.
