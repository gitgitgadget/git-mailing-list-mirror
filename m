Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05921F404
	for <e@80x24.org>; Sat,  1 Sep 2018 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeIBBPP (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 21:15:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41274 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIBBPP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 21:15:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so7009760pfk.8
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=MZWN2/7fVp4JED77xWN8AlS5fzj5nTvKcVG3nDpRgX4=;
        b=n1R5T/+B3lfXjxs0BdmlGY26SjjzQSB4a36oyV0RF3px3y91jeOqGf26mexLIcY149
         /T20Lb0dMfv1OkjyK+a2egYbgx5qs4ZufPIGq+InUE7dN9zPhtoJusZDEvjKF7apgz6r
         AVyJ7ZTG8p6HznKpHDEryjdIqdzsqSyOKT0GuinQj+uT/8UB1QKJpGEPTfYTcxozXcs0
         KPsE/6gfVO5/O8Y5v8FD71stPGnuHn9MvTz5J8dWiZXAXlbayRf80rmGtFS4ToUHCpGr
         Mu0SDAWFvKLQNfxIcfCjIccxTMI/ypK6OLMgP5pvM0XQIyh5Gg1bfk8kPpwo9vclrWY7
         uPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=MZWN2/7fVp4JED77xWN8AlS5fzj5nTvKcVG3nDpRgX4=;
        b=h5evS0l3uxExZTkjGUGVZeUmJhYZb48LrLgsV2IBqIM/16QAU9oOLFSm1zFxY2vxta
         Fv2Zb+YK5hbtEm4cveFgHk4r0aqbtEnRXSg8/tSj3rqK/HoBOJcU8TOH2aI253iUP5Ma
         hHKE22pdTW+s8WuavzQLrUk7R4HBnXr8ATYKqy31wjsBKlVdJElFKs6C36GGOPDYc93g
         NxjccOlgCuRuI8trnMr2owtFB3M55+zJrEhEG+zFqSeaSItZa+JDlQ4rdtCbV1k6MfnS
         4nDjip/WLwWNkWIdqMAnYAHv8eoqmWs8MHPQnoMmnq9Fa81QnBl6xRsmrvhq0Ob1TpyH
         D1gg==
X-Gm-Message-State: APzg51C2b2cbhwJ1u52iUaYQBylsOekfIH6zYgy9HEB9eHSp74yCFtix
        7x9LRV/4quuKwBgSLBe/ArI=
X-Google-Smtp-Source: ANB0VdY4AYyvat0kqBzP89Jr6FgiPMMU2wtnxBJG+KsoUZ15oBV5BaQgHTDG2RrrqmnoBhGnxO1oig==
X-Received: by 2002:a63:1413:: with SMTP id u19-v6mr20148796pgl.247.1535835722139;
        Sat, 01 Sep 2018 14:02:02 -0700 (PDT)
Received: from unique-pc ([27.62.77.220])
        by smtp.googlemail.com with ESMTPSA id p26-v6sm25450889pfi.183.2018.09.01.14.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 14:02:01 -0700 (PDT)
Message-ID: <9f7b6b5b0525b0d360423e3416d7baacd4c5a5cc.camel@gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?ISO-8859-1?Q?=27=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Cc:     'Duy Nguyen' <pclouds@gmail.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Stefan Beller' <sbeller@google.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        'Han-Wen Nienhuys' <hanwen@google.com>
In-Reply-To: <001001d42da7$4a9e6570$dfdb3050$@nexbridge.com>
References: <20180804020009.224582-1-sbeller@google.com>
                <20180804020255.225573-1-sbeller@google.com>
                <20180804060928.GB55869@aiede.svl.corp.google.com>
                <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
                <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
         <87zhxzsb2p.fsf@evledraar.gmail.com>
         <001001d42da7$4a9e6570$dfdb3050$@nexbridge.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 02 Sep 2018 02:31:55 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2018-08-06 at 13:02 -0400, Randall S. Becker wrote:
> 
> Any idea when this is going to be in an official release, and exactly
> what the settings will be for "Not Developer". I assume DEVELOPER=0
> and DEVOPTS=error, which is the current behaviour, correct? I am the
> platform maintainer for HPE NonStop and need to make sure I'm not
> packaging DEV builds to anyone, since I'm the only one doing this for
> the platform. It's another hoop, but hopefully not a bad one. The
> question is the best place to set this, assuming we are using Jenkins
> for our builds, and I'd rather keep the existing config.mak.uname the
> same, since at least it seems stable.

Just a FYI and in case you aren't aware, you could create a
"config.mak" to store your custom configurations. You can be sure it's
used due to the following Makefile part:

...

include config.mak.uname
-include config.mak.autogen
-include config.mak
...

It's just not a hard dependency.

Hope that helps,
Sivaraam

