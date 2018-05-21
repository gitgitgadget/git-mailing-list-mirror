Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B25E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 23:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeEUX7j (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 19:59:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44055 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeEUX7j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 19:59:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id y15-v6so17594212wrg.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BAVu9nXosGcNA2g79PxmFrLhwvYS47Vy5WESdcAF/vQ=;
        b=JxLBGvyCAfLNi0A02q4EaXrIV44oOH+TYpuH8ssbLnikwtsYGG+Xq+YdCM244Rmocp
         4Gi6fF3uUVzcQbDUZa706E0VyhwG3NM8u/pUVEzRsILQeDHEg0bwbXEIshhE+ckdVUsx
         w+Q5XSEWjGvCXdyl5Z/ALWC0rAHIi6/aJZ5cln1oPWGMloV5SFBOEu3GwJ72Y2SBLh1I
         RYzVHJAf/qLVpPe9I6OVGaQsanRX6xp1NKlKBVhyF+JhcMmltsq6pg/vKkW3cHS6SnAL
         7F+xB6L4k0KHH7nldblkrE+cWYMlRaotONb7tUgCf7jwPZfqOkFkwK9uG/lPqxjTJrZ9
         Go/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BAVu9nXosGcNA2g79PxmFrLhwvYS47Vy5WESdcAF/vQ=;
        b=CWJYj32p+Le5i0HynV4ARJD02jCkFJXzM7IvNQ9TAXTlgKhTEMXBfhteJEqn0FrxGI
         7ZDd/HJqqiPg//eLWHj7Qm1hht67oX5/FbuhYmSEKZTnTqSlo1cES2mlzlmaVsYmaK6S
         wSftctZoNOAQ64rZTsXXSk5cnaNCvcWxusO4iUCCMnkZ9X0yty/ST8C3zACGl5hgnVUw
         NfcMO6fp3Utbw4otcaE2nJdYbl/63DVZq83Uiqz5+wHEkZWEOU/FUteMy9BTV09xAaCH
         dkA+rBd2p1CZiqpUxIqSW+VNLKYqRET7PfaHmTkre20Nw3wFLtRiPTqxD+lLlxmFMwj1
         8K7g==
X-Gm-Message-State: ALKqPwc2H1WnrhAfz3snc4xyjfOCTf8SkF7MOiUf+CJoch2Qw6kthXb+
        2YRZcPBQQdM0pCmNiGBsjio=
X-Google-Smtp-Source: AB8JxZrbdOnb9AfVq1erNP4dT755IhH5l3VmpkpFiu45msWc0x5uh3+tym9Q+WuwWjq8sYHJ6AJ2WQ==
X-Received: by 2002:adf:94e4:: with SMTP id 91-v6mr2491228wrr.281.1526947177749;
        Mon, 21 May 2018 16:59:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 67-v6sm21283054wmw.32.2018.05.21.16.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 16:59:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     martin.agren@gmail.com, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: symbol string_list_appendf() unused
References: <d203f6ef-f684-cf6b-07b0-553b6b79e189@ramsayjones.plus.com>
Date:   Tue, 22 May 2018 08:59:36 +0900
In-Reply-To: <d203f6ef-f684-cf6b-07b0-553b6b79e189@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 22 May 2018 00:56:21 +0100")
Message-ID: <xmqqvabgzhjr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I strongly suspect that I haven't followed the discussion on
> the list closely enough, but your 'ma/unpack-trees-free-msgs'
> branch in 'pu', seems to define string_list_appendf() but then
> never call it. This is despite commit 40ebd6c7b0 ("string-list:
> provide `string_list_appendf()`", 2018-05-20) claiming that:
> 'The next commit will add a user'. ;-)
>
> Have I missed something?

Yes, I pushed out a tentative "how about doing it this way" update
that goes alongside his version, making some solutions (including
the function you found) he had obsoleted, yet without removing
them.  That is what you saw on 'pu'.

There is a reroll by Martin that ties all the loose ends.

Thanks for paying great attention to the details. Always
appreciated.

