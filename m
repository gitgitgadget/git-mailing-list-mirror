Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715A220248
	for <e@80x24.org>; Sat, 23 Feb 2019 11:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBWLqF (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 06:46:05 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46744 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfBWLqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 06:46:05 -0500
Received: by mail-ed1-f53.google.com with SMTP id f2so3904602edy.13
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=E7gupfs3OPuCjTmsDJzI2gPxb6SCJ+j1rfy0YfZgmRw=;
        b=UGaDcYearrmL56+AIDdaRQOVzi9UgCfp3gJcKJWDA6pba9BBqU3lWOCAftYZrdS0eT
         qyPau9aN2/6ZbreNwdvC2C4+CUZfXFy2rwocaa669BKa3njBkCv4ak3PzmlCbA7ozWKv
         tgLP51vgL4mXbg+rx7p/uTP1v1qOWHWcB2ARgiUatGpEUzX4UFcnKio66gCirDszek4r
         ccJ3BWFhaFlR9An2uIiFOBzf7TjGTdgRDAAFBmNvcNT9vbN9F1XSNBg4Hpt+jvZE6Nuq
         KUdIP0I8QG0K9a/FLHC8vmB2eTVEit8KZFQmhM+TbxZO9dhBDUQ+JEYzQwU8FRQEsVHs
         ngnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=E7gupfs3OPuCjTmsDJzI2gPxb6SCJ+j1rfy0YfZgmRw=;
        b=BKJT7CWq3vuS+BBvBDZSIU9JA03KcOjg4M8ptTyBe2C3S6E/RWWeRnr21XZQRBy6Ne
         YjjG4XpcZf+PBCSwAftk67x8gIHT7dDZq1D1byQMqGx/aBQoMV0RMckz0gCMRuvq/8nR
         ATDw7lTYqhOW5H+6TSNGkhGo/2harDDKkXmUJj9+T2Tcm9y3Wl5rdf99IwNc3pkFcC4Y
         1YpaJPBEI6/nluv/F3b0GRnBEOuvkydARrnydN+WwHCXqLrQ5odEXomcNlXjKsAhqg7i
         f9O+dgvaKqK4TBbR4OrBECQ/mXsa97nKFfCnGJXdzZPq55pW9WGftybukSj/8ld8gdyB
         XLYw==
X-Gm-Message-State: AHQUAuYlxZMy97Db86BmH42eoM5TIByZMBj715pFFml/mDajUEZSM5LA
        WY7ZDg+CZJ9ajMVFC4k8oak=
X-Google-Smtp-Source: AHgI3IZOxDPF0f6/sFvxGxivjcxcrbYZDihMNN3oN99KQuYHQEUn8kogMXx1J5SmIl2rKIhlBNTqZQ==
X-Received: by 2002:a17:906:892:: with SMTP id n18mr6368583eje.136.1550922363837;
        Sat, 23 Feb 2019 03:46:03 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r14sm1100123eda.12.2019.02.23.03.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 03:46:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Looking for my fisrt task
References: <1550915602.2346.4.camel@libero.it>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <1550915602.2346.4.camel@libero.it>
Date:   Sat, 23 Feb 2019 12:46:02 +0100
Message-ID: <87y3664tj9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 23 2019, Fabio Aiuto wrote:

> Hello,
>
> I'm looking for my first task as a participant, something simple to get
> used to submitting patches and all other facilities needed for
> community development.
> Thank you in advance.

This recent thread has a bunch of good pointers:
https://public-inbox.org/git/86fttvcehs.fsf@matthieu-moy.fr/
