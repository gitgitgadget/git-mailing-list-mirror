Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3344B20954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdKVPzy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Nov 2017 10:55:54 -0500
Received: from cisrsmtp4.univ-lyon1.fr ([134.214.188.147]:34853 "EHLO
        cisrsmtp4.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdKVPzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:55:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp4.univ-lyon1.fr (Postfix) with ESMTP id 6C93FA02AD;
        Wed, 22 Nov 2017 16:55:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp4.univ-lyon1.fr
Received: from cisrsmtp4.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp4.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nkGliflcsM2h; Wed, 22 Nov 2017 16:55:47 +0100 (CET)
Received: from BEMBX2013-02.univ-lyon1.fr (bembx2013-02.univ-lyon1.fr [134.214.201.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp4.univ-lyon1.fr (Postfix) with ESMTPS id 7DA94A02A1;
        Wed, 22 Nov 2017 16:55:47 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (2002:86d6:c9f7::86d6:c9f7) by
 BEMBX2013-02.univ-lyon1.fr (2002:86d6:c9f8::86d6:c9f8) with Microsoft SMTP
 Server (TLS) id 15.0.1263.5; Wed, 22 Nov 2017 16:55:47 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Wed, 22 Nov 2017 16:55:47 +0100
From:   ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "danielbensoussanbohm@gmail.com" <danielbensoussanbohm@gmail.com>,
        "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
Subject: RE: [PATCH 1/2] Documentation about triangular workflow
Thread-Topic: [PATCH 1/2] Documentation about triangular workflow
Thread-Index: AQHTY6gEUEPCFGdo8UiSQcrgLwmTnA==
Date:   Wed, 22 Nov 2017 15:55:46 +0000
Message-ID: <1511369748441.43953@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>,<xmqqlgj4qskj.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqlgj4qskj.fsf@gitster.mtv.corp.google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Daniel Bensoussan <danielbensoussanbohm@gmail.com> writes:

>> +TRIANGULAR WORKFLOW
>> +-------------------
>> +
>> +Introduction
>> +~~~~~~~~~~~~
>> +
>> +In some projects, contributors cannot push directly to the project but
>> +have to suggest their commits to the maintainer (e.g. pull requests).
>> +For these projects, it's common to use what's called a *triangular
>> +workflow*:
>> + ...
>> +Motivations
>> +~~~~~~~~~~~
>> +
>> +* Allows contributors to work with Git even if they don't have
>> +write access to **UPSTREAM**.
>> +
>> +Indeed, in a centralized workflow, a contributor without write access
>> +could write some code but could not send it by itself.  The contributor
>> +was forced to create a mail which shows the difference between the
>> +new and the old code, and then send it to a maintainer to commit
>> +and push it.  This isn't convenient at all, neither for the
>> +contributor, neither for the maintainer. With the triangular
>> +workflow, the contributors have the write access on **PUBLISH**
>> +so they don't have to pass upon maintainer(s).  And only the
>> +maintainer(s) can push from **PUBLISH** to **UPSTREAM**.
>> +This is called a distributed workflow (See "DISTRIBUTED WORKFLOWS"
>> +above).

>I probably should not be judging if these additions to
>gitworkflows.txt is a good idea in the first place without seeing
>any explanation as to why this patch is here, but I think it misses
>the place where "triangular" sits in a larger picture.

There already have been a discussion about this documentation:
https://public-inbox.org/git/E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org/
We forgot to add it to the commit message, it will be in the next
commit message.

>The workflow to contrast against to illustrate the motivation is a
>centralized workflow, where everybody pushes their updates to a
>single place.  It does have problems inherent to its structure
>(e.g. "review before integration" is much harder, if possible), and
>also has its merits (e.g. it is simpler to explain and reason
>about).

>If you want to wean a project off of the centralized model, you'd
>need to use the "distributed workflow".  The workflow to review and
>apply mailed patches in public, and the workflow to have the project
>pull from many publish repositories individual contributor has, are
>two that allows the project to go distributed.  These two are
>complementary choices with pros and cons, and it is not like one is
>an improvement of the other.  Projects like the kernel even uses
>hybrid of the two---the patches are reviewed in public at central
>places (i.e. subsystem mailing lists) in an e-mail form and go
>through iterations getting polished, and the polished results are
>collected by (sub)maintainers and sent upwards, either as a request
>to pull from publish repositories maintained by (sub)maintainers, or
>relayed again in e-mail form (the last mile being e-mail primarily
>serves as a transport vehicle for changes proven to be good, not as
>material to be further reviewed).

>The reason why projects make these choices is because there are pros
>and cons.  A large collection of changes is far easier to integrate
>with one command (i.e. "git pull") and with a need to resolve merge
>conflicts just once, than applying many small changes as e-mailed
>patches, having to resolve many conflicts along the way.  In order
>to ensure quality of the individual changes, however, the changes
>need to be reviewed and polished, and the reality of the life is
>that there are far fewer people who are qualified to adequately
>review and help polishing the changes than those who make changes.
>Asking reviewers to go to different repositories (whose number
>scales with the number of contributors) and leave comments in the
>webforms is much less efficient and more costly for the project
>overall, than asking them to subscribe to relevant mailing lists
>(whose number scales only with the number of areas of interest) and
>conduct reviews there.  Other factors like "offline access" also
>count when considering the two models as "choices".

>As long as the document uses phrases like "forced to", "isn't
>convenient at all", etc., it is clear that it starts from a wrong
>premise, "one is an improvement over the other".

We will take this into account.
We didn't know there were hybrid workflows.

Thank you for your time

Timothée Albertin
