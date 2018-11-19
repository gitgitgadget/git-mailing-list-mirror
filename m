Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64DE1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeKTE5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 23:57:54 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46747 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeKTE5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 23:57:53 -0500
Received: by mail-ed1-f43.google.com with SMTP id o10so3626131edt.13
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gzESN3w7c+ypXQzJqFNkioggakD6TOMo4AMxkP2cBIg=;
        b=Z5LHcCX+0K8x70zXMDHj/WgEwQawT0939HVUh9IaFmqemB1aw2PESvHdSQH/NxglVW
         UUOoK0Lop7fPELf+wHwpeekqmnmNbjC9GY9fXKxE2nALIULuW6rU5LjxJTGIm6PwHTf0
         nb8uCEB6mu4DBY4ypQNwJuihJtAVDanmTisYJEMKxzjJ3B2O9/eLzMNa9x9nTHNAh7Me
         PuNhK14vYITOa8TB6jQNRq63KN27TKSX+0X/RjTnofAJvw5Scws+5f8WkyNYH//MjZqf
         g6a1LDhbpe0/S5fApDdgIgPJnLKfLojSR2s6MOUmV/UHziSeCqIjJjQMhLfcuxXtSHxS
         RL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gzESN3w7c+ypXQzJqFNkioggakD6TOMo4AMxkP2cBIg=;
        b=T4JAmlQ3f7mnV/Kuolqe4JwB4YLO1gJJNhPY4jwk5OdOnRMjahFwPIZln9uqeO6291
         D3kcVxH+eUvdtoLynhRBQQzF8kVC1iLPt7JSbEqekr8IDqmVVjZIJEwVM5BLrn8JY/La
         hMUQfL226je8E79kmdwCTP6OB5blXN1//35Jjmwrac2GEjpH8EKFODsHTrVsUUmoYeZH
         Htljb7HjSkcqX2gpsi+LmXTblxeBEJ3xyzOIygYYhRLzUsQQQx1fWnhkv+lxzt10O8FE
         YWgB2UpB5wIMOJ+Wb3p7UjIOIqphDO3A/MGQdTlHe9mLmE73Aa2sxrByMmhaI02+Bvhn
         t/Hw==
X-Gm-Message-State: AGRZ1gLDxtmdSaWeUfvN61+n4SqIMZyfqEzTx2PFlHSnGp+Eo5AKPNtG
        gJ0kdiw/V0YyAuNT0trN6+g4MGOReVQ=
X-Google-Smtp-Source: AJdET5cQYuKOOFLDjit6Wi6pwEhL5fR1LuK55zvWHE3AikNOo49GfRcahoeCFO2+eraOrOAWDg92Ew==
X-Received: by 2002:a50:af21:: with SMTP id g30-v6mr21025877edd.167.1542652386649;
        Mon, 19 Nov 2018 10:33:06 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm6779295ejb.4.2018.11.19.10.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:33:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
Date:   Mon, 19 Nov 2018 19:33:05 +0100
Message-ID: <871s7g29zy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Derrick Stolee wrote:

> Here is a test coverage report for the uncovered lines introduced in
> v2.20.0-rc0 compared to v2.19.1.

Thanks a lot for this.

> [...]
> builtin/rebase.c
> 62c23938fa 55) return env;
> [...]
> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
> where rebase.useBuiltin is off

This one would be covered with
GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
the rest of the coverage would look different when passed through the various GIT_TEST_* options.

That would make it take at least 12x as long if you did them one at a
time. Probably just 2-3x as long in practice since most can be combined
in some way, and somewhat computationally infeasible if you're going to
try all possible combinations.

> [...]
> fsck.c
> fb8952077d 214) die_errno("Could not read '%s'", path);
>
> René Scharfe fb8952077: fsck: use strbuf_getline() to read
> skiplist file

The fault of a patch I submitted. Couldn't find a sane & portable way to
emulate cases where ferror() would trigger.
