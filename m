Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6B320C31
	for <e@80x24.org>; Thu,  7 Dec 2017 09:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbdLGJ0T convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 7 Dec 2017 04:26:19 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:49315 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdLGJ0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 04:26:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 24F9BA0069;
        Thu,  7 Dec 2017 10:26:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9F31r_E_ZtRd; Thu,  7 Dec 2017 10:26:16 +0100 (CET)
Received: from JEMBX2013-01.univ-lyon1.fr (jembx2013-01.univ-lyon1.fr [134.214.201.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 7AFFDA0054;
        Thu,  7 Dec 2017 10:26:16 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 JEMBX2013-01.univ-lyon1.fr (134.214.201.249) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Thu, 7 Dec 2017 10:26:18 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Thu, 7 Dec 2017 10:26:18 +0100
From:   BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
CC:     ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>,
        "Michael Haggerty" <mhagger@alum.mit.edu>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] doc: clarify triangular workflow
Thread-Topic: [PATCH] doc: clarify triangular workflow
Thread-Index: AQHTab+jmRNjkVuvV0mflwB38y3fnKMxLq9SgAZrx6M=
Date:   Thu, 7 Dec 2017 09:26:18 +0000
Message-ID: <1512638775790.32361@etu.univ-lyon1.fr>
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>,<xmqqwp24iah2.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqwp24iah2.fsf@gitster.mtv.corp.google.com>
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

>The document starts with

  >This document attempts to write down and motivate some of the
  >workflow elements used for `git.git` itself.  Many ideas apply
  >in general, though the full workflow is rarely required for
  >smaller projects with fewer people involved.

>and makes me wonder (note: I am not involved in writing any of the
>existing text in this document) how much material foreign to the
>actual workflow used for `git.git` should go in here.  Having
>multiple maintainers at the same time is not a workflow element that
>we have ever used, for example, so I am not sure about the change in
>the above paragraph.

We were told to change 'he' into 'they' to be neutral.  However, it's true
that there's one maintainer at a time so we will remove the 's' from
"maintainers". 

>> +TRIANGULAR WORKFLOW
>> +-------------------

>I really hate to say this.  Before I made comment on the last round
>that tried to add this section, I didn't read the original closely
>enough.

>The thing is, it does already cover the triangular workflow in the
>"Merge workflow" section (you may need to already know what you are
>reading to realize that fact, though).  The text in the existing
>"Merge workflow" section where requestor pushes to somewhere for the
>maintainer to pull from may not be immediately obvious, and it may
>be worthwhile to improve it, but I find it highly misleading to add
>an entirely new section as if it is describing yet another separate
>workflow that is different from anything that is already described
>in the document.  It is not.

>A replacement of the entire section (but I'd recommend keeping the
>"Merge workflow" title, which contrasts well with the other "Patch
>workflow" that follows), or a separate document that is referred to
>with "see that other one for a lengthier description" by the
>existing "Merge workflow" section, or somewhere in between, might be
>a more acceptable organization, though.

We'll take this into account.  We will create a new file called
"triangularworkflow.txt" just for the triangular workflow to be more precise
because "gitworkflows.txt" is a long file.  More, we first wanted to change
the doc to help new contributors. If we put all the triangular workflow
section in merge workflows, this won't be clear for a new contributor.

Thank you for the review.

Daniel BENSOUSSAN-BOHM
