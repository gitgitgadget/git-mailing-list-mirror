Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F5E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 19:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJUDhW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 23:37:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41053 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJUDhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 23:37:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so34332244edd.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6/KOLYZ57ezUmb8cR/HJmD+dtyrG9yw8F1EehTHQy94=;
        b=O3jll4GBnJeEelZlE1GGTxEZ1wEZ1P2w1PDcs9Z/rGUqDg+CzfqAM7jZyBPdVswntm
         2Y3s1gFHiVKoVvV4PchuxCHs748drv4+KiF7FsRRPeQ6RT5fyL5mqQQlQp27fWVXz3SB
         SJsMpv+bnbOj/+IAfzTjP4mjFNOCYnM+rNI7wDntalQc0s64qOjkMRnU6X6JLIj+drH8
         kf6YJC5LQEDFSLjQeDnZ2sFDGybctT+5WM7WCRKS9j+LUpKRkwIFBcrW4X62d6ZpRcyV
         3iFdJIBlykCahuGnLhJoWLSymM4/Gu41IP26op6a8vTaIn7FBx9zHEBwUNct5/+BFhwn
         QZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6/KOLYZ57ezUmb8cR/HJmD+dtyrG9yw8F1EehTHQy94=;
        b=V/rC+0GbHES6EV7FTT0QpUVsmP76jBAPxcHbry08lPfqBRh1+mOcVT0WiedXntwapP
         PMbdkqnpoVTql7cn5BYWo7nZvZ+v80NSmrqgyiKEni2ZHIhDSrtXEIZ1NgQWNHnvsXpz
         ACMNkojbFMz0wnwAQ2WRx7XmqvqPabghM0QiWSX4bKVe5eXFu9/+zm9JzfDS+mu4yH/J
         WwK3P+ZGK52+McI4PkGM+NO8Rw5H7fFN4N1PQLozB/0N4YddDhYxjEptQ41lbOteBVCQ
         +x8h+nBqlB7A4QqqJHSjGuFnM826aN8REd2QzTA8PgNTKXLJs+4U4GOxl+NKkfVnmjPS
         1oUA==
X-Gm-Message-State: ABuFfojbHXTc+7M4U9SbuGkkOLHddWhxmKj/pmY+zXXYjylqXAjgBfLb
        EzWHRUG6pHpv+lQaaAw70Z0=
X-Google-Smtp-Source: ACcGV62TVWeh1cUZ0zeeLHziqE7cYIIVmJMoMkt+y1RyA89+K05sxnRLbQd+3Q4VBZqFGl5/0MWxzQ==
X-Received: by 2002:a17:906:6686:: with SMTP id z6-v6mr33258974ejo.144.1540063553016;
        Sat, 20 Oct 2018 12:25:53 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id g11-v6sm10567183eda.28.2018.10.20.12.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 12:25:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/59] Split config.txt
References: <20181020123848.2785-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181020123848.2785-1-pclouds@gmail.com>
Date:   Sat, 20 Oct 2018 21:25:51 +0200
Message-ID: <87d0s4ctds.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 20 2018, Nguyễn Thái Ngọc Duy wrote:

> I started this a couple months back, moving a couple big config
> sections out of config.txt to make it more manageable. This series
> almost completes that. It moves all configs (except http.* which have
> changes on 'pu') out of config.txt. config.txt is now about the
> syntax, and a list of config sections. http section can be moved out
> later.
>
> I did a doc-diff on this series and the only change is ssh.variant is
> moved down a bit to keep it in order, which is intended.
>
> I thought of grouping all these config files in a separate directory
> Documentation/config to avoid cluttering Documentation/ too much but
> let's wait and see if people really find Documentation growing too
> large first.

I had a slight bias against this when you started this, since I'm one of
these odd people who don't mind ~20k line files if the line count isn't
contributing to inherent complexity, e.g. in the case of config.txt you
could just use the search function all in one file.

But FWIW I've changed my mind to as strong opinion in favor this series,
because an actual annoyance of mine has been how inconsistently we
document config variables affecting individual commands.

I.e. in some cases we have somecmd.switch=xyz that's also a --switch
described in git-somecmd(1), and the --switch docs are more exhaustive,
or the other way around.

And sometimes like in the case of git-gc(1) we have gc.* config
documented in two places with different prose that needs to be updated
in two places in a CONFIGURATION section. This series allows us to just
unify the two and do an "include" in two places, and more generally have
the convention that a given command that uses configuration could have
that config both documented in git-config(1), and the same docs in its
own manpage.

Is doing some post-cleanup like that your eventual goal after this
series?
