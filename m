Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EB11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeHMVAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:00:51 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43828 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbeHMVAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:00:51 -0400
Received: by mail-wr1-f48.google.com with SMTP id b15-v6so15050784wrv.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lyKUT6U2fV5QvQVzm+yChGnFTStLTMjEYoVrT9ZF/bE=;
        b=shtVqng8tYVQBj4zcnE6mzPm57ApAn+QwQE+JzHewWDEco2cmEVTFVRYf+xKLSoF5H
         G9dJY4iKQRYf7IbiQgXuSGrAx5MwcwB87XxvY+EP9Gc6vyO4OZDyO1+NpgAFAF2BxRl9
         6Ew6lKaZNazpG1f92SWTllzdE7MvPe+XsHlCaOdT9Rxi8Pc8E2KblAnTtaO4COjTIuYZ
         orhCYc2tobhRlizH7Hwtcsbl8+RfAa9mI60hOxG3ysN1MqPLi6+MLo3HegHRDB4fCPPz
         ii6FtbMAr4W2727Kbu9qXO+F3lb7xMmqYbxxirNGJs3ZvKAlmo+4o8QJWtRMGciIDsqn
         ccGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lyKUT6U2fV5QvQVzm+yChGnFTStLTMjEYoVrT9ZF/bE=;
        b=WHhxgM9WVHNzW/Ty7OULXgWgCPpS3uyOPKTTMhjPJli9LRs8O6OlDs65NuMrcOYOis
         Iu/0fArj0mN7RGBtJXUZDQ+RGvKTjqLJevZax/gX6jUZGwTWGlpsZZv2MlBcl9MymT5s
         x03CubG2PCN34N2OX+jzvF7eFSDPvJblN1yLQjXfa6C1OVpPUmDRjUlSlajQDFXKdJQk
         dCCwCxf+zK3nudhPQbasX+b5/z+066VGGPdv+IydNRlsrL35sG50u7wxX8KPu4tMoFuM
         HG8uwzUJf3x5COuPWsOS/shUbyTG9iYwkxYLlsgZ+s/IGc85w3JKorINIBTgFAHvoS/W
         Oy+Q==
X-Gm-Message-State: AOUpUlGIDGwtYIdcIOPS/1YKr+nQ/Ydwg+sDrQcsuinu97BYMse9p518
        AiZfRlgQd/Fw3FH3Ch43itc=
X-Google-Smtp-Source: AA+uWPzmd0Pei9H89a6163AxegR70yDxAwKV095Nn6dYWFeGq/gbDRmWX8In3tPI8FbrGu0M6wD+Tw==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr11103874wro.264.1534184249478;
        Mon, 13 Aug 2018 11:17:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x82-v6sm33006681wmd.11.2018.08.13.11.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:17:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     frederik@ofb.net
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
References: <20180706213239.GA867@flurp.local>
        <20180706211828.GC6195@aiede.svl.corp.google.com>
        <20180706232147.GF6343@ofb.net>
        <20180706234715.GA81694@aiede.svl.corp.google.com>
        <20180708010926.GK6343@ofb.net> <20180724195217.GA9366@ofb.net>
        <20180724211146.GB136514@aiede.svl.corp.google.com>
        <20180811023036.GA19208@ofb.net>
Date:   Mon, 13 Aug 2018 11:17:28 -0700
In-Reply-To: <20180811023036.GA19208@ofb.net> (frederik's message of "Fri, 10
        Aug 2018 19:30:36 -0700")
Message-ID: <xmqqva8e5dxj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

frederik@ofb.net writes:

> Hi Jonathan and Git developers,
>
> I poked around today and figured out how to reorder the command
> listings in the manual page, they are taken from git/command-list.txt
> so I just reorder the lines in that file (after disabling sorting in
> git/Documentation/cmd-list.perl).
>
> I haven't reordered the whole list yet. I could only get one computer
> friend to send me his subcommand frequencies from his shell history. I
> reordered the commands partly based on that, and partly based on their
> order of occurrence in the various tutorial man pages.

There are two good things about a list that is alphabetical.  One is
that you can scan with your eyes and a finger to find what you are
looking for more quickly.  The other is that it is mechanical so we
won't waste time on bickering whose frequency table is more correct,
whether frequency table is a good approach to derive a better order
(than, say, the order in which the commands appear in an every-day
workflow) to begin with.

I would say if we were departing from alphabetical order, we should
first declare that we are *not* looking for the best way to order
the list, so that people do not waste too much time bikeshedding.
Instead what we should aim for is to come up with _an_ order that is
not too unreasonable and settle as quickly as we can.

And from that point of view, what I saw in new-git.1.out, I found it
not so outrageously unreasonable ;-).
