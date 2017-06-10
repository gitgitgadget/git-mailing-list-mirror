Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2D91F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 05:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdFJFda (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 01:33:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35486 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdFJFd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 01:33:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so9428299pgc.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nCcDpKEQ7VzW8SrU1oc3EloGPQmLH+oqZqVwnFEa6fA=;
        b=drmJkkgQo/W2LE/stvavDu2kR6fUv0mbsJ8PI2lQzB4Vdboz0OFrD5gbSaWJsHPs0V
         /3KRPJoGkd847b4qBimDTA7E8WtpIYTphI8+9K+WrcKbG/KbGva9tyjYOlFjug9XrXpH
         99YfIShjq4/uyzW9tQO+b+pry/LdkV68QYgVVkas7ClhOWiQ8D4tIjzU4GV+oyIWE3UN
         756K1VNE/8CtXnFwE3kzO4wCOXHnCXcRXbv7FPhQFcvISTxzmjq6EkF1asF0HFRFhHp/
         flQTecTZ/tQzczWsBNogyEjMb5QhLsBXbAUFonUGnIjpuzU6x7S6EOal4gcoQc7BRJ6B
         hLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nCcDpKEQ7VzW8SrU1oc3EloGPQmLH+oqZqVwnFEa6fA=;
        b=sfMLIXIxU4lXUwSO4M7tOB/3Qk7BMOJ/BPHgN/bUbqonvvhlLAy7Vc+MCjar+Q1MOB
         mToFkmW8UD7wq77ul9QyJFO70+kez9V4ftRZyxIMbqnO8K3USjg9P9K1dkBfLhBTAPe0
         8EdxMrZs7XvwuTmrDreRwlPJfc2EGZxMwJWpqj6l6QTi/BGlQ7kJppnbKBGNznX71ylb
         jsiCz63m6X1V3XlY0O6/akB7lv/hBh2NxcNYRuGDIGbO3mP0PiaK7xG+ilVqCGXTmGZY
         cX7OBx/+6gAGjx83EV7YC3pV1YsDv1XmoYrKpjU4lxJUSCX6fTGWEXJ3JX5ywI9lqszU
         pavQ==
X-Gm-Message-State: AODbwcDO94wqO02R++p05MzAjxHbPHnF89VSfygGTMAJ8igr60BiJEnL
        2sdOvus0/UyEdw==
X-Received: by 10.99.129.66 with SMTP id t63mr20317734pgd.28.1497072808942;
        Fri, 09 Jun 2017 22:33:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id m25sm5936914pfk.15.2017.06.09.22.33.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 22:33:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: describe git svn init --ignore-refs
References: <20170607183214.21259-1-asheiduk@gmail.com>
        <20170607233226.GA7061@starla>
Date:   Sat, 10 Jun 2017 14:33:26 +0900
In-Reply-To: <20170607233226.GA7061@starla> (Eric Wong's message of "Wed, 7
        Jun 2017 23:32:26 +0000")
Message-ID: <xmqqr2ys2yqh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will pull.
