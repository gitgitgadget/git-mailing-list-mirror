Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46DE2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdBOV07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:26:59 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34097 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdBOV06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:26:58 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so12088973pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dX6huoZEPXLhekhlsRq4T/Jh8eqY/R+LsHaiWpO/WKM=;
        b=BL71H2M4ZH7/DCPHsRoauzPiDyFcMcj9zk0NeJ7f3nvOWiUxV5IEIotm0Uxg1VmuMJ
         kKNLQNaPcqF/+YMeQnkN00ctbG1QP5xkssiJoAXoRDc+wJl/ZBAoze1OYoEpeADLJluZ
         g6XVQT6KusSH6TXAeQ5SQsdEuZt4xcdmdyjCUrbYntqWvPmv2RCejq6gMEvisiR+DR0E
         XuqtPIMFwcD4IZ6DUpt3J8gRfmsj/30aJBowaaa0Yvh7h7uV1KBkIlsabEI7abvDtgtB
         cnwfE3UgCWqeiYKHTqJ7l2Q9P9iFDV7ygVv0+wbqFEFZaVE6Tqz9gWDIPhTa4gLAt17F
         QqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dX6huoZEPXLhekhlsRq4T/Jh8eqY/R+LsHaiWpO/WKM=;
        b=ZKuGEOHZevXVzvXL+jiQ5yLTHAAe0fisWpWO4kkOiwMpr5hLMmu7G0hyjwCUKhoCVu
         0D/0NM2+IVGSFKAZaQD4cKrfAipp9zJN3Xq81jAkP5G+agpiU9fpI0JY+4eJCDLqQFVe
         Ao+WSfU+pxD8aEcZ9ljutQqts0omq+gcgK2TYk3bNlQztLPqOa2ODO89tMRdxf7EF2uN
         lGUUJ73e1eR507K0cfzvt5BnTG8JbGs4LhP3lSK9YZTnq/YlqloESBYncvX39YIfs00X
         VbC57w2MTmxBXgZFMh/qBfz5nBdaF5zDBXNKUmkCqFJJNKt7zFrTgj4tbPtlpGBLxEsS
         rNXg==
X-Gm-Message-State: AMke39mv4JJJXIfPkcotak9CY6TN8rUUaDPFUnaNk9FCeZLTLgTOaWBtqmhVmaK0VmAgFQ==
X-Received: by 10.98.91.131 with SMTP id p125mr39942033pfb.165.1487194017241;
        Wed, 15 Feb 2017 13:26:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id f188sm9241803pfa.35.2017.02.15.13.26.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 13:26:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
        <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
        <xmqqshng5osz.fsf@gitster.mtv.corp.google.com>
        <7EA15219331242ABB08B9A9AA9F08CBE@PhilipOakley>
Date:   Wed, 15 Feb 2017 13:26:55 -0800
In-Reply-To: <7EA15219331242ABB08B9A9AA9F08CBE@PhilipOakley> (Philip Oakley's
        message of "Wed, 15 Feb 2017 17:31:07 -0000")
Message-ID: <xmqqvasb2li8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> In the next..pu case the abstraction is in the other direction, we
> have potentially multiple points of infection (from feature branches),
> and a broad test (the whole test suite). In this case I believe we
> would like to investigate initially the --first-parent line with a
> classic bisect for the first point of failure (obviously including
> feature branch merges). This would identify which feature merge, or
> regular commit, created the first breakage.

If you are going first-parent, you would limit the bisection to a
single-strand-of-pearls, and I agree that it is a good strategy to
find which topic branch merge broke the tip of 'pu'.

If we assume that there is no funny interaction among topics that
cancel a breakage brought in by one topic with another breakage by
another topic, then no matter how many broken topics there are, I
agree that we would get to the first broken topic.

A good thing that comes once we assume that topics are more-or-less
independent is that we could rebuild 'pu' minus the broken topic
identified by the above procedure and repeat it to find other broken
topics, still using the --first-parent bisection, because master..pu
is a linear sequence of merges of individual topics.


