Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C971F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeH3SsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:48:05 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46494 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbeH3SsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:48:05 -0400
Received: by mail-ed1-f44.google.com with SMTP id k14-v6so6703894edr.13
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9xwB7UncSHpiWulQOTlqe+YlJY9nPwFUnSabEsk4PR4=;
        b=EpBIoVje3xVun4J4bq2F/CMNa+aLLKhBJDF7tjH4Ds9A51K37l2LoC8Q1drL3fF2xJ
         oSJXtbmuGIM2JpfwqPP5PIfqz/17DCiX/nYQr7zdjkJ1SP1ai3zbfcSiL7oqGaXySG/F
         R3tPt/hlUqgb3DVamsQh6L6/ZdimEg4Bgl9XyyaZCX8V/6gqRQ9jT4RZYKeq5DcBH8XB
         kGoHIz4IkdPUKUUAOyou7s50EM0EYDLfFv/UH04aq1TG3SWOmYCvUhDiAeV3Dtae7DTu
         qSyY33ZHQAw+xajfFEqqV20aiTsJeEw4ltnY2WdYkNu6swoQoicGeV7cVH5k48ujiehg
         f1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9xwB7UncSHpiWulQOTlqe+YlJY9nPwFUnSabEsk4PR4=;
        b=d6uEoyW3ZV8hEhOgCXK93ftv6nTWph7NoC5J4qN0D8RIvG5aENBg3zWPQUAqbiet+n
         by2LjrHye/9NXFJTD/VfIhzYHjZeOf04oB+9iOwnnNEya26IBCweZwUsciN8qFGD+E6z
         JMNakG4j1iG59Qz7FEpjZq3Uy/iQ4kEAPXJFchrvZcMiNzCzxUo24hgkj7Xy+G8Jv6g+
         Uj1LT/qLANt/ki5H3QjyTbQDMt1pgQSGbjVkcyNubSxhbbGl8/n0HEfugGO1MSejnh3Y
         duNYoGGLQbsh9hbmW9xhrZBcivQKkmo25k61SGAlI7w+d3Ejd13GhK9FX7E2RNdc3oTj
         E+Tg==
X-Gm-Message-State: APzg51AgyGW5PG0LM3TTdflhWYQi7UpE/z/64SevFBpoz3fdOQEcbZV5
        TaO4GyD56SBADFnSnyKpVv4=
X-Google-Smtp-Source: ANB0VdZOqRZOUYnd/7gujKOm9I8WlgsqDuKu0guBY3Y28ou13j1r/OGzCWkFpz2o2geiA6H4AJHnJw==
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr13136937edd.243.1535640334245;
        Thu, 30 Aug 2018 07:45:34 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id u3-v6sm2587722edo.44.2018.08.30.07.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:45:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Wesley Schwengle <wesley@mintlab.nl>
Cc:     Git mailinglist <git@vger.kernel.org>
Subject: Re: Feature request: hooks directory
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
Date:   Thu, 30 Aug 2018 16:45:32 +0200
Message-ID: <87pnxzdib7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Wesley Schwengle wrote:

> Hello all,
>
> I would like to ask if it is worth my time looking into the following
> solution to a problem we have at work.
>
> Problem:
> We want to have some git-hooks and we want to provide them to the
> user. In a most recent example we have a post-checkout hook that deals
> with some Docker things. However, if we update that post-checkout hook
> my local overrides in that post-checkout hook are going to be
> overwritten.
>
> Solution:
> We discussed this at work and we thought about making a .d directory
> for the hooks, eg.  $GIT_DIR/hooks/post-commit.d, where a user can put
> the post-commit hooks in. This allows us to provide post commit hooks
> and allows the user to add additional hooks him/herself. We could
> implement this in our own code base. But we were wondering if this
> approach could be shared with the git community and if this behavior
> is wanted in git itself.

There is interest in this. This E-Mail of mine gives a good summary of
prior discussions about this:
https://public-inbox.org/git/877eqqnq22.fsf@evledraar.gmail.com/

I.e. it's something I've personally been interested in doing in the
past, there's various bolt-on solutions to do it (basically local hook
runners) used by various projects.
