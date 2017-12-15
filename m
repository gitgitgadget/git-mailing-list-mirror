Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270A21F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbdLOPqv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Dec 2017 10:46:51 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:54554 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbdLOPqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:46:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id C7DE9A01DA;
        Fri, 15 Dec 2017 16:46:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9z7m7USVOzJT; Fri, 15 Dec 2017 16:46:48 +0100 (CET)
Received: from BPMBX2013-01.univ-lyon1.fr (bpmbx2013-01.univ-lyon1.fr [134.214.201.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 54C9DA009A;
        Fri, 15 Dec 2017 16:46:48 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 BPMBX2013-01.univ-lyon1.fr (134.214.201.243) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Fri, 15 Dec 2017 16:46:47 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Fri, 15 Dec 2017 16:46:47 +0100
From:   ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
CC:     BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Subject: RE: [PATCH v2] doc: add triangular workflow
Thread-Topic: [PATCH v2] doc: add triangular workflow
Thread-Index: AQHTdRy4b7DwFrQEtUaHSO/jj67o3KNEhcmO
Date:   Fri, 15 Dec 2017 15:46:47 +0000
Message-ID: <1513356398354.33048@etu.univ-lyon1.fr>
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
        <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>,<xmqqbmj1t4tp.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqbmj1t4tp.fsf@gitster.mtv.corp.google.com>
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



>>> +This workflow is commonly used on different platforms like BitBucket,
>>> +GitHub or GitLab which provide a dedicated mechanism for requesting merges.
>>
>> As a user, I find it terribly frustrating when reading documentation
>> telling me that "there's a dedicated mechanism" for something without
>> telling me actually how to do it.

>Also I think the description is backwards from end-user's point of
>view.  It's not that it is common to use the workflow on these
>hosting sites.  It's more like people use the workflow and adopt use
>of these hosting sites as one building block of the workflow.

I'm wondering if this sentence is really useful. It's not essential
and it will take lot of time and space to talk about it properly.
So, if you agree, we'll erase it.

>>> +If **PUBLISH** doesn't exist, a contributor can publish his own repository.
>>> +**PUBLISH** contains modifications before integration.

>I am not sure what this really means.  Isn't it the norm to create a
>place to publish your work (and only your work) for your own use?
>IOW, the above two lines solicit questions like "So... what happens
>when publish does already exist??? and where does that publish
>repository come from???"

In the case of a triangular workflow, if the project already exists,
PUBLISH will already exist too. However, if the project doesn't exist
it is at the creator charge to create it. In fact, we just explain
how doing it if the project already exist. We'll add it for the 
second case.
BTW, the line : * `git push`   is useless.


Thank you for the review

Timothée Albertin
