Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B9720279
	for <e@80x24.org>; Sat,  4 Mar 2017 06:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdCDG6f (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 01:58:35 -0500
Received: from mout.web.de ([212.227.17.11]:49992 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdCDG6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 01:58:34 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEiK-1cUevN3xpA-00FTxP; Sat, 04
 Mar 2017 07:25:50 +0100
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
 <20170302142056.GB7821@mcrowe.com>
 <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
 <20170302200356.GA31318@mcrowe.com>
 <ae2b144a-5e39-8178-5161-1d8eb673b6f0@web.de>
 <xmqq37eu2qxl.fsf@junio-linux.mtv.corp.google.com>
Cc:     Mike Crowe <mac@mcrowe.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <9c9eeb35-e1c1-ec46-1d85-ef6a05886880@web.de>
Date:   Sat, 4 Mar 2017 07:25:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq37eu2qxl.fsf@junio-linux.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:OBMy8qvkbTOGFIkWHHZckr4KaGVZS0QrHrgMw2Xkaa22zbxR9Hg
 mcaz3q9EOqdCgXIbvK+ySbTOddZRaSi5bW+x6/r0Ebdbq5DCsOzqbFBgYv+6qrYhA6n0LPv
 Of53+j8wrRDP81yMxJBfrwWlf8o8sgG1yJmZuuyypiFvAcHtsZ8bICRlkNgrd5WeePRfS/R
 PiOUOofA/LRjhkNC+p/SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fUB37hlgxdc=:00AOm3w55hqFwSClZduxXx
 kL/HD/8QzifvtF489F4giD3kNuJRCqXyl/GkOGnEaZZV0fHXHDBVblL4muzBoc4yEMMYUajYb
 l/C2PFJmBVwwwDPE2sL3qNrN0QhWqeHk/H71iuOFTggSFSNR+g/ZxB/ZW5lswV4igZfGpiwBs
 0QtBGyQjHHaT75EZrlPA4Xi4XkCsQqI9UCtU8y4xjAnCtxHC3cav5oOCVbQS8dmrs9rKYu5hQ
 v70lchGBby4SzpK8mkVNoRA/0YMzLALrtTwMbPpSyDS/ZbSviEm28GfqCBMn8X5HcZoMWzSPe
 6i7zSEI/0T9RLQBhsbGd4N/DMmiWVMqxtScDXIoGZ8Zd4iVtr1sbOG1oSk6s3yVv4zP7TGtKx
 fvVeoosnGlMtRv3d7bQTzIVBsEsBEO9MbhV05HCIVtF9hDCVHKn9HsQz9sl8gyzvLFr2gm8t7
 f5D6kUhsp+5CMl0Jp5uiGPg5kxyJO0YSoIrI406ZPodmgOLxQVbb/BncwRJayk24vVvTsca+H
 JgCdGQpsOQRNlr3NktLSH6bIQ7xr9D+lIDvAXHe8MtwgOXpbD3hCHXYjxzftc4bIodiarWTjU
 kMvn0OyX90CaLTMixNhiheDsq9a2QXC4R13B9TpttU3CBi/1hmfK54/ee6sf/BRj1t7pMEgLM
 od+RiTAXrhfNhi67+YW3fhOT2Oty4o9koWLSDarRv8yV+aiL5bkob0DUOmyZ6rElFZOFqFDw4
 PhxnLJV2++TlIJc4gzVjOzdB4IwSbK3kW3XBtjlWYrAxWhnPE/mPmanNHdjMYMexxMJJgK56R
 fWvbh+b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-03 18:47, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>> Understood, thanks for the explanation.
>>
>> quiet is not quite any more..
>>
>> Does the following fix help ?
>>
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2826,6 +2826,8 @@ int diff_populate_filespec(struct diff_filespec *s,
>> unsigned int flags)
>>         enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
>>                                     ? SAFE_CRLF_WARN
>>                                     : safe_crlf);
>> +       if (size_only)
>> +               crlf_warn = SAFE_CRLF_FALSE;
> 
> If you were to go this route, it may be sufficient to change its
> initialization from WARN to FALSE _unconditionally_, because this
> function uses the convert_to_git() only to _show_ the differences by
> computing canonical form out of working tree contents, and the
> conversion is not done to _write_ into object database to create a
> new object.
Hm, since when (is it not used) ?

I thought that it is needed to support the safecrlf handling introduced in
21e5ad50fc5e7277c74cfbb3cf6502468e840f86
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Wed Feb 6 12:25:58 2008 +0100

    safecrlf: Add mechanism to warn about irreversible crlf conversions

-------------
The SAFE_CRLF_FAIL was converted into WARN here:
commit 5430bb283b478991a979437a79e10dcbb6f20e28
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Jun 24 14:35:04 2013 -0700

    diff: demote core.safecrlf=true to core.safecrlf=warn

    Otherwise the user will not be able to start to guess where in the
    contents in the working tree the offending unsafe CR lies.
------------

My understanding is that we don't want to break the safecrlf feature,
but after applying

diff --git a/diff.c b/diff.c
index a628ac3a95..a05d88dd9f 100644
--- a/diff.c
+++ b/diff.c
@@ -2820,12 +2820,10 @@ int diff_populate_filespec(struct diff_filespec *s,
unsigned int flags)
        int size_only = flags & CHECK_SIZE_ONLY;
        int err = 0;
        /*
-        * demote FAIL to WARN to allow inspecting the situation
-        * instead of refusing.
+        * Don't use FAIL or WARN as this code is not called when _writing_
+        * into object database to create a new object.
         */
-       enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
-                                   ? SAFE_CRLF_WARN
-                                   : safe_crlf);
+       enum safe_crlf crlf_warn = SAFE_CRLF_FALSE;


None of the test cases in t0020--t0027 fails or complain about missing warnings.
Does this all means that, looking back,  5430bb283b478991 could have been more
aggressive and could have used SAFE_CRLF_FALSE ?
And we can do this change now?

(If the answer is yes, we don't need to deal with the problem below)
> Having size_only here is not a sign of getting --quiet passed from
> the command line, by the way.
> 

