Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0329A1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeKAV3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:29:17 -0400
Received: from smtpoutz27.laposte.net ([194.117.213.102]:56222 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728452AbeKAV3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:29:17 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id D4EA3277D63
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:26:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541075188; bh=Wgb29wMDz643yJoQzxyijw1GjrVtSGa1eOmeRncXsaM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=apLDjaVFHZPvg+MAksMMw2QSOJQaMQQNFDfRH8Z28JYL7lBctJdj4CorYlRPx53Hb
         S9SHB+BKh6H9kVE6sI50/SUVWKvWP+/1AqMMLOWfw7uyIIPAH6LJcmlVEC7SLhUIy9
         CY1hEEmMF+NGDE2hqna0z03LSUrPdjNHWLwhEc0wVBCQtg2SyJYI0ixotJg17O9Pqb
         aqvmYI+CTRMzmKmVQjle4x5qqBvF3ZZMjJpaLl2FAm8ABJL0ruERGgpmxAy/ufnmbg
         FanXtNXZxkA/Djas3nvWpI1D+8sNhkPBCEP5is6p3l05zsg0XiaUMqZAXBlamihkPb
         esxlCdF++7YzQ==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id C33A7277E99
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:26:28 +0100 (CET)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
        by lpn-prd-vrout015 (Postfix) with ESMTP id BD9D4277DB5
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:26:28 +0100 (CET)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
        by lpn-prd-vrin003 (Postfix) with ESMTP id AED134A6943
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:26:28 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin003 (Postfix) with ESMTPA id 99A1B4A6910
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 13:26:28 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 5B9B822008E;
        Thu,  1 Nov 2018 13:26:28 +0100 (CET)
Message-ID: <c414f7ae84c763cacd55d14ba68fbf2572b65132.camel@laposte.net>
Subject: Re: [RFE] Please add a standard ref object to releases
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
        <nicolas.mailhot@laposte.net>
Cc:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 13:26:28 +0100
In-Reply-To: <871s85kq16.fsf@evledraar.gmail.com>
References: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net>
         <871s85kq16.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 15
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdegudcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecuogetfedtuddqtdduucdludeh
X-VR-Cause-3: mdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefpihgtohhlrghs
X-VR-Cause-4: ucforghilhhhohhtuceonhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvtheqnecu
X-VR-Cause-5: kfhppeekvddrieegrdegledruddtheenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpihhnvght
X-VR-Cause-6: peekvddrieegrdegledruddthedphhgvlhhopegrrhgvkhhhrdguughnshdrnhgvthdpmhgrihhlfhhr
X-VR-Cause-7: ohhmpehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepghhi
X-VR-Cause-8: thesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 01 novembre 2018 à 12:15 +0100, Ævar Arnfjörð Bjarmason a
écrit :
> 
> For both this and your other report, it would be helpful if you
> describe
> in concrete terms (with examples of git commands, or UI etc.) what git
> commands do now, what's wrong with it, and some sketch of what you
> expect an alternate interface to look like.
> 
> As for this report: I know this area of git quite well, but I still
> have no idea quite what you're asking for.

It says a lot that you claim to know this area of git quite well, but
have no understanding how it is (mis)used on github/gitlab/bitbucket/etc
by people who actually try to use git.

I’m just asking that when a project releases “x.y.z”

1. there was a standard git command available to it to create "the
release “x.y.z”" ref

2. there was a git syntax to say "the release “x.y.z”" ref in all git
commands that manipulate refs

3. that this "release “x.y.z”" ref could be used in all the "download
release “x.y.z”" on GitLab/GitHub, etc

4. that there was no fuziness or human interpretation involved into
converting "x.y.z" into the syntax used to select "release “x.y.z”" in
git commands

5. there was no ambiguïty in this syntax that led to the selection of
things that are not "release" refs and just look like them

And **not** the current situation where there are no official "release
ref" objects and "just map release names to tags, mapping recipe is left
to the reader". Because everyone invents its own recipe and the result
does not work.

And no, vfoo is not a form of release ref, because v1 can be a branch,
not a tag, version3 tag is not the release ersion3, etc (real-world
examples I can provide links if you don't believe me). You can’t let
things undefined as they are now because git users as a whole are making
a mess of things without tooling help.

> If we assume this is a good idea, how do you imagine this would work
> once you don't just have two levels (random labels v.s. "real"
> releases)
> but three or more (random labels v.s. "real" releases v.s. "LTS"
> releases, ....)?

IMHO you’re over-engineering things there. There is a need for separate
release refs, as evidenced by the fact every major git web frontend had
to separate them from normal tags in its UI. I'm not aware of the same
thing for LTS or whatever.

Of course implementing generic namespacing, would be a way to get a
separate release namespace. As long as this release namespace is
unambiguously defined at the git level without replaying the 'just
invent your own tag recipe' mess at another level.

Regards,

-- 
Nicolas Mailhot

