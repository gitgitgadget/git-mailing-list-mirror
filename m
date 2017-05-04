Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2DE207F8
	for <e@80x24.org>; Thu,  4 May 2017 01:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbdEDBin (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 21:38:43 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32849 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbdEDBil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 21:38:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id q20so125204pfg.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CDctdeGTXQ4vt0S9hLjTRbOgOE4yy3+vUYE35RrDAGQ=;
        b=TfL6hQEq4hKcW+7qZG3t6oo/2HR++C6zzo8HudKdYHfV4euzYWsuaKYXPKsl7taTLe
         7cleLy8KawIDH48xW08ToW6HdRPfky00y37doQUW6emx2B0Ob8/E91QOfHjYfmgNn2Vu
         SRL1OMieN0aZYJw3+p7Ph4Z44uwDwjKQ3GVI3pMpojzU+JmFBB/EMa0UrGvxBADfNlLl
         eOvPs6A5N0fFpjfKM2ZZff8w882CjXizxOxVH7K/77xywBsMYrGRNvhhOMu24DIPaVtW
         0ncQW+J4qE+H/7cqVMyUCARv9FKG7VfYX9OcV0xNHrQCoNgzaUBQ8iAWGFWpdfS6hSDK
         0q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=CDctdeGTXQ4vt0S9hLjTRbOgOE4yy3+vUYE35RrDAGQ=;
        b=iQBu4TXWDvDcq87Qax8v+1E+MaDgFc8TETnjqEY3mRMfo1A0LX2uAlble8AMNB7ymq
         Nfl6HXvmiEjF1BrMOwYiyTcmN1iVO2jyj3LUNNpFpcw7Bmq5dAN25tox6ODrnYk1KQen
         9r3XSz70Q5c9YsQ/Jtuui4gq/8LmcCvn48bjY71Ctr7/J5/qJ/mNqjvJZujDMQ/NYy2W
         oPzkRv2atoSPxIPmJ9xQpf7ANC6x6SIHcIrqalcDDkoc1T8LkSKM5HIDS2KpdHY6Idmh
         B+a4x71OLpITRejM77JPFM/SxCMQgLuh2/VqDYtat9GajcxeJITHveiR9uVpRRdShVUh
         tYiw==
X-Gm-Message-State: AN3rC/4wXCUkmDgsOu+FBLjEJemy1nBRLrq0h51ogCaHp9c+WCnIz830
        VPuj7wxWaKisdQ==
X-Received: by 10.98.80.156 with SMTP id g28mr7908557pfj.163.1493861920770;
        Wed, 03 May 2017 18:38:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id 202sm585926pfy.83.2017.05.03.18.38.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 18:38:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] i18n: remove i18n from tag reflog message
In-Reply-To: <2070499.EYhsb04HyH@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Wed, 03 May 2017 18:38:45 +0200")
References: <20170429100253.4710-1-jn.avila@free.fr>
        <xmqqwpa1ic4e.fsf@gitster.mtv.corp.google.com>
        <2070499.EYhsb04HyH@cayenne>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Wed, 03 May 2017 18:38:39 -0700
Message-ID: <xmqqefw5csf4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Le dimanche 30 avril 2017, 18:45:05 CEST Junio C Hamano a écrit :
>> Jean-Noel Avila <jn.avila@free.fr> writes:
>> > The building of the reflog message is using strbuf, which is not
>> > friendly with internationalization frameworks. No other reflog
>> > messages are translated right now and switching all the messages to
>> > i18n would require a major rework of the way the messages are built.
>> 
>> Thanks for spotting.  Before we declare that reflog messages are for
>> i18n, we'd need to either drop (or redesign the implementation of)
>> the "checkout -" feature, which relies on the exact phrasing of how
>> reflog entries from "git checkout" looks like.
>> 
>> Will queue and merge down to 'master' quickly.
>> 
>
> I didn't know this "side effect". Maybe adding a test against it would be 
> requiered. Unfortunately, I don't know enough of it.

Sorry, but I am not sure what "side effect" you are referring to.  I
am saying that in the current codebase not translating tag reflog
message (i.e. your fix) is the right thing to do.

builtin/checkout.c does

		strbuf_addf(&msg, "checkout: moving from %s to %s",
			old_desc ? old_desc : "(invalid)", new->name);

when "git checkout" is used to switch from old to new branch.  The
above phrasing is used by sha1_name.c::grab_nth_branch_switch() to
know what branch you were on, and not having _() around the message
is the right thing to do, at least in the current codebase.

If somebody wants to i18n the reflog message, that needs to be done
at the reading/dispaying end, I would think.  Instead of being purely
textual records, a new reflog format would have to be a machine
parsable message-id with parameters, and the code that wants to
understand the reflog record like grab_nth_branch_switch(), as
opposed to show the record to the humans, would just use the machine
parsable raw data, while "git reflog" and friends that format the
reflog record would give the message-id to gettext and feed the
parameters recorded using the result of gettext() as the format
string to fprintf(), or something like that.

That would solve the issue in multi-user repository Ævar raised,
too.  You'd see Chinese reflog entry not because the person who did
the operation that created the reflog entry were writing Chinese,
but because your locale is set to show Chinese when you tried to
read the reflog.  German users would see the reflog entry that
records what the Chinese developer did in German if we follow that
route.


