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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7C81F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeKTGEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:04:31 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33879 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeKTGEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:04:31 -0500
Received: by mail-ed1-f54.google.com with SMTP id b3so3700908ede.1
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vtXklv3wPeAjNIzWJz0+BrfMw8ZbjK/3ej2S3jo/vT8=;
        b=cxUblehgST8toqHfWUGOiMhGauDxauNvDHVdeDyXcqfxOcnptfRAi1xWJ2wMmq4tRS
         vGoJ9Itf7CWI+FBQKCdVySJNyiJqnRnHKe6xOSdvFgc3mTn8wv603ALZUjExgEPC4jJ9
         ymh/9eu5FUEEAjHpzKTTf/tiiVli3o3Kk7C0NmeAtcR4MKrMV1uHccNXemU3+FsrIEYw
         HQgtPMrt6u8I+4qsZ4Xkv2PgXOigz4a1Gknj9COhjQki4/u17UCtueA1X7fxtJH/tgoy
         JJN0E0yp2xSQDnf2fMQl7E1hc5BjvUbznJK0Eo933mgC8Zd3y32LAJgUP2FicJkJtFn4
         fkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vtXklv3wPeAjNIzWJz0+BrfMw8ZbjK/3ej2S3jo/vT8=;
        b=fdrUl0JXCemPoQn2Zk2EzIQaACgjH9d0rxMnkJNHEzZ+Q9TeZaae9vhK5BIwmqUaxj
         8xPHwTMTAcnuhi4utuiNYNRhaXBWE/ntVoFhqUiMqZmq48nt4mtF7fZv7CBA0LKSXm/6
         uMCC2W+chqhWhBRqMQjC+k7QJXiVEtDGCMWoHBET5ZzO96yg7cCigI7bTrObiyi0r9+V
         K2XvoQ7uE8AumovuLf+yU+VrmXIlSmR3KViVWNb1qK2XXiB6SJU0qAD/8vGmT4MfNodE
         qKXoJmRnKlPKv3nSZIEc6kUfMvtRNTX39SpCrzhuRkdkCvajG7XhhEGslfA0ZEYvvD86
         47lA==
X-Gm-Message-State: AGRZ1gIhj9V2+0ctdv+I9UiYVIFHeKjuk5OfGoElNXc6YH1GyYyFh6o8
        y4NVAzFYBjDjICAVq3SPm54=
X-Google-Smtp-Source: AJdET5c97J4Wz3Iifqcl1iWJfiMaAWuuxQAEZ5a+08h5Txq0okxsM6Ln+DnR72CKapzh3Lghwx7JxA==
X-Received: by 2002:a50:94f4:: with SMTP id t49mr21401166eda.24.1542656363967;
        Mon, 19 Nov 2018 11:39:23 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s3sm902787eda.69.2018.11.19.11.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 11:39:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com> <871s7g29zy.fsf@evledraar.gmail.com> <37b2c29d-43bb-9987-e91c-cb3e6b65d354@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <37b2c29d-43bb-9987-e91c-cb3e6b65d354@gmail.com>
Date:   Mon, 19 Nov 2018 20:39:22 +0100
Message-ID: <87zhu4zwk5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Derrick Stolee wrote:

> On 11/19/2018 1:33 PM, Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Nov 19 2018, Derrick Stolee wrote:
>>
>>> Here is a test coverage report for the uncovered lines introduced in
>>> v2.20.0-rc0 compared to v2.19.1.
>> Thanks a lot for this.
>>
>>> [...]
>>> builtin/rebase.c
>>> 62c23938fa 55) return env;
>>> [...]
>>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>>> where rebase.useBuiltin is off
>> This one would be covered with
>> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
>> the rest of the coverage would look different when passed through the various GIT_TEST_* options.
>
> The coverage report has been using the following:
>
> export GIT_TEST_MULTI_PACK_INDEX=1
> export GIT_TEST_COMMIT_GRAPH=1
> export GIT_TEST_INDEX_VERION=4
> export GIT_TEST_SPLIT_INDEX=yes
> export GIT_TEST_OE_SIZE=10
> export GIT_TEST_OE_DELTA_SIZE=5
>
> I need to add GIT_TEST_INDEX_THREADS=2 and GIT_TEST_REBASE_USE_BUILTIN=false

...although note you'll need to also test without
GIT_TEST_REBASE_USE_BUILTIN=false, otherwise a lot of the new C code
won't have coverage.
