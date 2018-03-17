Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A42C1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 21:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCQVUq (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 17:20:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53375 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeCQVUp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 17:20:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id e194so8972533wmd.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=IYvykoCkGBE/NM21dnzukjfCmr3jGO/XZrhWV6NGPvo=;
        b=sxZoOeyienTjkIaO8CLflDOYFeSNj31n2yhNzAZyv2PVK/O+1rHQ4rxT8jM5I4SSTS
         eB5q88CCNvX9NfbuhYbmSLUaUAV/h2xFxiaRul8utXaj9BcXfL22Zo/Qa0Vo9ivtLysO
         PTQkqodI0FlzI9KuVCR5mPrdtETSq77OWqV9oZVIQPY8lnAQIOqty+zKs0/ZOYO0lamE
         1nK7E9c/kMH5n+scoPzJfX7OIhqNnqcQqQl1O92KB2LRrS9/Nc9cgbY7bJOt366HyxcI
         RBFTv8Xk0n802iNm3Pg3wv4sbbgO+mbhjN7nfxlql50qPDtzyNguBoMGDovxl08U6Fh+
         cSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=IYvykoCkGBE/NM21dnzukjfCmr3jGO/XZrhWV6NGPvo=;
        b=W+onRMOySy+fZR6YveDPRF044/MkMnqTTPP1xmP2NZXD7HGa7UwFVH1YHaw1JcOJ7n
         FL0Y74ziQqpCQNi4wBX7V9Szj4AATIQLpx5cIBkdBheVjrqWQxp7ZRFiNirD2LO7lLSr
         RNINbtxI1rdfRJ/DtroxWtxllnnGqVwJXyPRMf2EphMFIpkSgJA9UZ4PpXUZ8N8gFRqP
         muKZ3ZTWEpjgoElK+qjwvcW2f0UfiOnAT/A1rc1zTLtFe5GnA74nLLYqlPF5YI3mw6QC
         ++sl2rZurIIIT/ts+Eg60JWm0LWhCp4fmQwsLX3XytcLAeEv4rz6BwnuZYP1QBGEqtFg
         JNiA==
X-Gm-Message-State: AElRT7GSIJV9v115U2rTqJCINcaQqBZ79LuPvyPnIeKRIU8Yz2B+R3UH
        02/8ULxEPRDhPB6aGJ+B8YW6fMHH
X-Google-Smtp-Source: AG47ELv3f6WE8nx7+saSwriEOqXaY5OddYPUVt297qtr8M8Uzv7NPrV+/disml7d7jWu2Ey5eiS1Mg==
X-Received: by 10.28.199.11 with SMTP id x11mr4594162wmf.121.1521321643654;
        Sat, 17 Mar 2018 14:20:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x7sm10263946wrd.76.2018.03.17.14.20.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 14:20:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [GSoC] Some #leftoverbits for anyone looking for little projects
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
Date:   Sat, 17 Mar 2018 22:20:40 +0100
Message-ID: <87in9ucsbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In lieu of sending a PR to https://git.github.io/SoC-2018-Microprojects/
I thought I'd list a few more suggestions, and hopefully others will
chime in.

This is all TODO stuff I've been meaning to do myself, but wouldn't mind
at all if someone else tackled.

I'm not interested in mentoring GSoC, but these are all small enough to
need to special help from me (or anyone in particular), and if nobody
picks them up I can refer back to this mail for my own use.

 * Having grep support the -o option like GNU grep et al.

   We have most of the code for this already in the form of our color
   hi-lighting, it would mostly just be a matter of "just print out the
   stuff you'd have colored", with the small exception that if you have
   more than one match on a line they should be printed out on their own
   lines.

 * Give "rebase -i" some option so when you "reword" the patch is
   included in the message.

   I keep going to the shell because I have no idea what change I'm
   describing.

 * Add more config IncludeIf conditions.

   Recently there was a mention on git-users to excend the includeIf
   statement to read config:
   https://groups.google.com/forum/?fromgroups#!searchin/git-users/includeif%7Csort:date/git-users/SHd506snwSk/UdVCsCILBwAJ

   Now that seems like a nasty circular dependency but there's other
   low-hanging fruit there, like make it match a given env name to a
   value (or glob?).

 * Add another set of GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL} with lower
   priorities.

   There is a script at work which I have to manually blacklist which
   sets git author names & e-mails via LDAP for all logged in users via
   /etc/profile (and gets my name wrong)[1].

   It would be nice if git supported a way to do this that didn't either
   involve overriding everything (as the current env vars do) or munging
   the user's ~ config (ew!). I.e. the priority of these new env vars
   would come after reading from the config, not overriding the config
   as the current ones do. So it could be used to make a suggestion if
   no other value was found.

 * Write git-unpack-{refs,objects}

   I don't know if this is small enough (maybe the refs part?). This
   would give you purely loose objects & refs. This is a terrible idea
   for any "real" use, but very useful for testing.

   Now when I'm testing repack I need to keep an old copy of the repo
   around, because there's no easy way (that I know of) to pack things
   and then get back to loose object state. Ditto for packing refs.

 * I had a previous TODO list of "small" things at
   https://public-inbox.org/git/CACBZZX5wdnA-96e11edE7xRnAHo19RFTrZmqFQj-0ogLOJTncQ@mail.gmail.com/

1. At work like in so many companies LDAP is synced everywhere, but of
   course that means catering to the lowest common denominator. Last I
   heard attempts to give me a non-ASCII name (in the GEOS field) had
   failed because some phone or printer somewhere refused to accept it.
