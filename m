Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976471F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 04:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfAPEqV (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:46:21 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51356 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfAPEqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:46:21 -0500
Received: by mail-wm1-f46.google.com with SMTP id b11so560471wmj.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 20:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1YH/PozkVcqZtxrWKE2C/oI6xOQwg9hTbfRq7Utn9/w=;
        b=d5NhxUKYWzJcjsRTekU+Hx4B/kKN3Uw0fwnDmxKJB1yhrHJ/3ROmzMTpFZGnvG//J9
         hI4VyOfZevT1vjWFMdLgdgeVG2EMiuirxFp7CGGw1ako9FN9UlyijiK/XvWRGrqaLbnk
         XUakjs2cnsW3oNEFxSPmBkuONL3nNviiYWDCOLHBpGH0JgIft2wHstOH3+lHiki6XC+u
         FjlW66ZbB++O0ioYGl7eFzNRvr1XU9ASe4Z11kCJp/5oejfH+DCodWv+fEushEbn5VhF
         sKh5RyT+syTcrBLl0ca47c1IeR3dPshzjPbbxwXuQOF2tq3/O7MJEwYD9KrNkbHLLlBd
         yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1YH/PozkVcqZtxrWKE2C/oI6xOQwg9hTbfRq7Utn9/w=;
        b=s/Rgc4HRm2c6hfoSpEhqsVz46UZXDNdRe1TS2BdfMvPLHirkwn6MZ2yhOaN/Qe3MU+
         G/mmW6PEs31FnbehiAObnDdPwr1Tuoa9xh1nIIpvtwjlCq0bE2Edgib5d4oBXZNc5p1S
         8ho338QWgEkzAp1LefqTbxeppG5y7m6fow8iTOmctw2KnQpv7/ZuVNKC5HCie2/rvJ3N
         lND39I97+7V1VL6opeDnK1sOl0BrVxRpJD1hJ5/KyRn1BlfNrAey8jBK/m8bZouq5rWS
         U+P4FQkr9H8c71NY/B1UPeCDkXCopfX6iR3KXcb4DYRQTRD+b5raky2Bcrveghh+td9v
         aMzQ==
X-Gm-Message-State: AJcUukfsNVL6YShRFNfflhb0UGq9p7/6aAWOXkCNmBq6JAmeuOBhJFPR
        1c/nxZjZ0BpvN/JmK6HBrTs780Qn
X-Google-Smtp-Source: ALg8bN5A+rY2VImQlWyTPDdCrhgwSnIYJ5w2XxIALxn1h5a7jWsET7Cz7gIUaR+MeoBaeDqB3GsUcw==
X-Received: by 2002:a1c:7a16:: with SMTP id v22mr5310281wmc.131.1547613978842;
        Tue, 15 Jan 2019 20:46:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 127sm56752819wmm.45.2019.01.15.20.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 20:46:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 15 Jan 2019 20:46:16 -0800
In-Reply-To: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Jan 2019 14:31:06 -0800")
Message-ID: <xmqqpnsxnraf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * js/commit-graph-read-overflow-fix (2019-01-15) 3 commits
>  - Makefile: correct example fuzz build
>  - commit-graph: fix buffer read-overflow
>  - commit-graph, fuzz: add fuzzer for commit-graph
>
>  The code to read the commit-graph file was not prepared to see a
>  corrupt size field in the file, and ended up reading beyond the end
>  of the buffer.
>
> ...
> * js/commit-graph-chunk-table-fix (2018-12-14) 3 commits
>  - Makefile: correct example fuzz build
>  - commit-graph: fix buffer read-overflow
>  - commit-graph, fuzz: add fuzzer for commit-graph
>
>  The codepath to read from the commit-graph file attempted to read
>  past the end of it when the file's table-of-contents was corrupt.

-EIWASSTUPID

These are the same thing, different iterations.  I'll keep the
original topic branch name and have the updated patches there.

Sorry about the confusion.
