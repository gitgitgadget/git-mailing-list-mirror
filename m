Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA101F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeKCCkh (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:40:37 -0400
Received: from smtpoutz24.laposte.net ([194.117.213.99]:40887 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbeKCCkg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:40:36 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id 09D1216501C
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 18:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541179958; bh=+EzVsSrfO4v8hqljy0L4qTen/jRuIjb7jseOeseUIl0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=i/wM+2tu0bpVXqiBf0+9+4XK4+XawTTBvhRHVHN/5b5MHNKUJ70PFMvNpVH4Eof38
         mrbJu4Zza1DG0lNBMgACZoZtq98VHIl9HvaWEF2rzTKus+ihYPbi6xCN0AGsbsncat
         qKxmJ9T9C0EJWAfBgNWnpLPkdgQAxL5FSi8lSFpLhziZ17AgNXU4xv1+WzJmpbVfl0
         cXSXHfwVq71FvUGcC13ynrZHHRNhNTghZumPtPuekkMlvfEivrcTBoEXnpMRP3Ytej
         P5mvaNmOmQX+HCQ4Dq3vgOM/KRoSotlh+hzDDPeJ0gVnBDdDaF5sk1rgpQQIoCj6Pi
         woeiVg4HQKPfQ==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout012 (Postfix) with ESMTP id EE2C016500B
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 18:32:37 +0100 (CET)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.prosodie [10.128.63.5])
        by lpn-prd-vrout012 (Postfix) with ESMTP id EB00A16500E
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 18:32:37 +0100 (CET)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
        by lpn-prd-vrin004 (Postfix) with ESMTP id D9EF37289B6
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 18:32:37 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin004 (Postfix) with ESMTPA id C0A63726DA1;
        Fri,  2 Nov 2018 18:32:37 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 6446C2201EC;
        Fri,  2 Nov 2018 18:32:37 +0100 (CET)
Message-ID: <841569ad61dd5f4f5424e8c2860a4c01f146c8a1.camel@laposte.net>
Subject: Re: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Date:   Fri, 02 Nov 2018 18:32:36 +0100
In-Reply-To: <20181102165110.GA11212@sigill.intra.peff.net>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
         <87zhutjb3t.fsf@evledraar.gmail.com>
         <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
         <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
         <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
         <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
         <1e3901b9a75a043d9c31d66d98410f3288a7c5be.camel@laposte.net>
         <20181102165110.GA11212@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieelgdekjecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkffuhffvffgj
X-VR-Cause-3: fhgtfggggfesthekredttderjeenucfhrhhomheppfhitgholhgrshcuofgrihhlhhhothcuoehnihgt
X-VR-Cause-4: ohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtqeenucfkphepkedvrdeigedrgeelrddu
X-VR-Cause-5: tdehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepkedvrdeigedrgeelrddutdeh
X-VR-Cause-6: pdhhvghloheprghrvghkhhdruggunhhsrdhnvghtpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgr
X-VR-Cause-7: ihhlhhhotheslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
X-VR-Cause-8: tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le vendredi 02 novembre 2018 à 12:51 -0400, Jeff King a écrit :

Hi,

Thank you for reading the RFE.

> I did create the way git credential matches repo urls. And I do not
> think your proposal is a good idea. The credential system is about
> interacting with a remote URL, and creating a commit object is a local
> operation. That mismatch leaks through when you work with multiple
> remotes, since it is not clear which URL we would match against when
> the operation does not involve a remote at all.

I don't think it's quite that simple. The id part of creating a commit
object is not a local operation at all. You choose the id written in a
commit for a specific remote target, it has no use locally, most of us
do not need it to reach themselves.

So yes there is a leak but it’s built in the git commit logic itself.
Ideally, git would defer resolving <me> in commits to when I push to a
remote target. I'm sure you’re aware of all the workarounds git users do
at push time, when they realize the commit <me> is not the good one.

And since the leak is built in the commit logic itself, there are no
perfect solutions that do not involve revisiting how commit works.

So, unless someone wants to revisit git commit, we’re left with
imperfect solutions, and git credentials is no worse than another. It
certainly fixes my use case fine. You did good work in git credentials.

Regards,

-- 
Nicolas Mailhot

