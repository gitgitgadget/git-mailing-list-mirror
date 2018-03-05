Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3893E1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeCEWNt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 17:13:49 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52748 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCEWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 17:13:47 -0500
Received: by mail-wm0-f44.google.com with SMTP id t3so18960502wmc.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=aKkNyPELDwaONXb+d4EZCdqI0GcuHXmu4q4ylVFFAYI=;
        b=LKMJfV8a8vGkqHGIYkDEiGNCFxq1OYqeZWzGREdC8XkSvRbGeGxiWVV/Qkbx9nM4/R
         EjSE4SZy/79uxfl3YPK7AdbXRUTa/D8IobMX27SSud6UdJXPP5cREJPKzS3z/rFAcvCo
         BB4o/ce1Eo4C1wWLRSfPqBJyucxy1zVROmUk5tBX9MKTNhNAyvcr2OLZWpHy/+/W4WgE
         TP/P/wvwIxfYL1+LBalAZVOPj5Nd1ahRmINgrsFUXe2wVplQWuUzbz5giFtLCB2r7u82
         C9QgB1MYFbrEPGelkD723E0U0CdTU4hRIVOP5WUY+WAyVCo/TWOPngzJFcil9qX4iHxW
         0swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=aKkNyPELDwaONXb+d4EZCdqI0GcuHXmu4q4ylVFFAYI=;
        b=duf3HQTM6KPs2uV17qXdSDYRfR1GsxVzEAZK58jtCQbCHme65oKryCUB4u9cD+4REE
         igS9Op03Xe6MJT3jLNgZBk8hOfFoO5G13MkjR/tNYBkFXMHptHCnp8kdyxfwoK9YyJxh
         CalX1ain106MymaYGRIFMj/uIWuITCIBrX6+tfd7g07q6M0SMDPqlkOVSGxe11RZqkI7
         aqD8Iwa2PPDU2gRCVJNc9ZAIuoHNd+576KiCZ3vaPb1p/4q0K8G3Xt025Mpf7GL2AQmR
         Ci1z4Xj+23SY9Y0nFsLsYSHN6OZmbmTuUOArW27vBsgZD+V58fbwr5d5CK/o1rnuew6k
         eQNg==
X-Gm-Message-State: APf1xPCCVo2qA2kAuyAdpMNldc2Ta42LdEXiRDwsn9e9X9QU/xvRX+qw
        FMp/YdCFXS77YOMVbTAr/jfRRVvJ
X-Google-Smtp-Source: AG47ELu0agh+MWVy/VN4il6/KgBH8YWU6E4OBbw43OIbiSCKCwmiDL7+2t9htpMI88trONwWhfDEKA==
X-Received: by 10.80.151.105 with SMTP id d38mr20459786edb.79.1520288026202;
        Mon, 05 Mar 2018 14:13:46 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p26sm11568690edm.41.2018.03.05.14.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 14:13:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Contributor Summit planning
References: <20180303103010.GA21068@sigill.intra.peff.net> <20180303103957.GA24498@sigill.intra.peff.net> <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com> <20180305185329.GE28067@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180305185329.GE28067@aiede.svl.corp.google.com>
Date:   Mon, 05 Mar 2018 23:13:44 +0100
Message-ID: <87606anpbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 05 2018, Jonathan Nieder jotted:

> Lars Schneider wrote:
>> - error reporting: Git is distributed and therefore lots of errors are only
>>   reported locally. That makes it hard for administrators in larger
>>   companies to see trouble. Would it make sense to add a config option that
>>   would push recent errors along with "git push" to the server?
>
> I'm interested in instrumentation but worried about the privacy
> ramifications of this particular proposal.  I'd be happy to see some
> built-in instrumentation hooks (or even a standard instrumentation
> approach, if the mailing list comes up with a good one that respects
> privacy).

I have this use-case as well, and figured a good approach would be:q

 1. Add corresponding config variables for GIT_TRACE_* so you could
    config them in /etc/gitconfig (or elsewhere). Similar to
    e.g. user.name & GIT_AUTHOR_NAME

 2. Add some new trace like e.g. GIT_TRACE_COMMANDS, make it take a
    format string in GIT_TRACE_COMMANDS_FORMAT (or usually via
    config). Thus setting GIT_TRACE_COMMANDS to a file would e.g. spew
    your current repo path, subcommand, or even the absolute command
    line to the file.

 3. Have some cronjob or other monitoring thingy pick up the file &
    submit to central logging.

Of course you could overdo the format specifiers in #2 and e.g. send the
full commands along, but it seems to me that it would be sufficient for
privacy concerns to document that caveat with some examples.

After all, for this use-case we're talking about us somehow guarding
against a sysadmin who can just install a /etc/profile.d/git_wrapper
anyway that'll log everything you do with git, or even provide a custom
git binary, so it's always going to be left to their best judgement.
