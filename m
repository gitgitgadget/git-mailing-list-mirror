Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494C21FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 09:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdJWJQm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 05:16:42 -0400
Received: from smtpoutz10.laposte.net ([194.117.213.175]:36402 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750811AbdJWJQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 05:16:41 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 597AF60B624
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 11:16:39 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 29C7C6076BF
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 11:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1508750199; bh=UDLLDVDtNUfgDNhMb4ex+Jwm0Gnqyh66yE805nUmPEE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=HAnnjAbc/NfMeYd9CtkbNZ3sN8vKCGfWHksSV2u4FxQCBuQeW62KNtX5eKcb6LctR
         fGNPyRRRmgozHU+5fExxFa8qtJewBE0NMpHhzDWrcLyLUQikPQLNdQ2+2ubMJWibqU
         /sgWF0EdoyroORzNMUT0ZUGDpfR6gHr5ywb2c3wZk99T1kcf8MzjTGPfCxc9YHD9tu
         efDI/eYKtOkjHoYSIagKG6TBlQgLe8yZ3ivzle0ZcgNmtE/bC36Ispyhe/7vZgfyaI
         RR7W+sWUhqXmvGgr0IBTLizZDM4zys5lqC5MHp2AOsIeco+Bx7M4V6l15JEWflDIcV
         TJK0h08nEn+ag==
Received: from lpn-prd-mstr088.laposte (lpn-prd-mstr088 [10.128.59.114])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 6AE2A60B603;
        Mon, 23 Oct 2017 11:16:34 +0200 (CEST)
Date:   Mon, 23 Oct 2017 11:16:34 +0200 (CEST)
From:   nicolas.mailhot@laposte.net
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Message-ID: <1987706130.38146.1508750194178.JavaMail.zimbra@laposte.net>
In-Reply-To: <000001d34ab6$9f549460$ddfdbd20$@nexbridge.com>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net> <000001d34ab6$9f549460$ddfdbd20$@nexbridge.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to
 GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.202.208.95]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF57 (Linux)/La Poste)
Thread-Topic: Add minimal universal release management capabilities to GIT
Thread-Index: AQEQkiBsJlXtbBQjasldtmQygGgOTaR0QFbwG24bfrg=
X-VR-SrcIP: [86.202.208.95]
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedttddrvdeigddutdcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhs
X-VR-Cause-3: ucdlqddutddtmdenucfjughrpeffhffvkfgjfhfugggtgfhiofhtsehtjegttdertdejnecuhfhrohhm
X-VR-Cause-4: pehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtnecukfhppedutddruddvkedr
X-VR-Cause-5: heelrdduudegpdekiedrvddtvddrvddtkedrleehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhht
X-VR-Cause-6: pdhhvghloheplhhpnhdqphhrugdqmhhsthhrtdekkedrlhgrphhoshhtvgdpihhnvghtpedutddruddv
X-VR-Cause-7: kedrheelrdduudegpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshht
X-VR-Cause-8: vgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Mail original -----
De: "Randall S. Becker" 

>> Git is a wonderful tool, which has transformed how software is created, and made code sharing and reuse, a lot easier (both
>> between human and software tools).

<snip>
>> Please please please add release handling and versioning capabilities to Git itself. Without it some enthusiastic
>> Git adopters are on a fast trajectory to unmanageable hash soup states, even if they are not realising it yet, because
>> the deleterious side effects of giving up on releases only get clear with time.
>> Here is what such capabilities could look like (people on this list can probably invent something better, I don't care as
>>clong as something exists).
<snip>

> Nicolas makes some interesting points, and I do suggest looking at the original post, but there are more factors to consider > when dealing with production-grade releases in regulatory environments. And my sincere apologies for what, even in my eyes
> looks like a bit of a soap-box rant. No slight intended, Nicolas.

Hi Randall. I plead guilty for the rant part, I've spent way too many nightly hours recently untangling Git projects that couldn't be bothered with stating requirements any other way than with a list of commit hashes, when they bothered (in one case a dev didn't even realise had broken some of his other projects when changing code, that's how bad the "a commit hash is a sufficient coordination point" situation is now getting).

> Possibly most importantly, there are serious distinctions between what is built via CI, what is released, and what is
> installed.

Perhaps I should clarify, my post was about "source" release id since git is a "source" code manager. You do need a different id to identify release builds (packaged or not). However, any sane system will derive the build id from the source id, since most software properties (options, functionnalities, security problems) are directly caused by what's in the source itself, and changing them requires going back to the source.

> In a specific way, source and release commits are required to be time reversible in production, whereby if an installation
> fails, there exist in many environments requirements to be able to fully undo the install action. This is often different
> from the environment artifacts which can be time-forward constrained and reversible only in extreme situations.

Yes the reversibility is often very theorical, basically requiring losing any change and reverting to a pre-change data dump. Automation is getting to the point where it' simpler to push a new fixed build than reverting to previous state. But that requires solid handover between source-oriented (git), build-oriented, deployment-oriented and audit-oriented tools.

>> So nothing terribly complex, just a lot a small helpers to make releasing easier, less tedious, and cheaper for developers,
>> that formalize, automate, and make easier existing practices of mature software projects, making them accessible to
>> smaller projects. They would make releasing more predictable and reliable for people deploying the code, and easier
>> to consume by higher-level cross-project management tools. That would transform the deployment stage of software
>> just like Git already transformed early code writing and autotest stages.

> Possibly, but primarily for source releases.

Sure, you need to start somewhere, and git's job is managing sources, so source releases are part of its theoritical scope.

Best regards,

-- 
Nicolas Mailhot
