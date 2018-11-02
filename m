Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_BLACK,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6753E1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 08:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKBSEC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 14:04:02 -0400
Received: from smtpoutz23.laposte.net ([194.117.213.98]:43439 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbeKBSEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 14:04:02 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout011 (Postfix) with ESMTP id 6CFB352BFB3
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 09:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541149052; bh=HqAmwTDtkGdbUUlxVZWX56dfavRa+UxjNp6+WFe9QhE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=B1Xos2/AitdAFg4yMtF1gii7Hnbxu7cqu54CCREjC/q2isD1E5JnzmstwFL9LBVAf
         51r+gUL2zvWjBYr0bdYj4fdN1egC+cGOJR6RGwecftKkPmqO5G2Iolv6jgvShWW1R5
         LmwSUKtyzbZpOYPX4gjdcSROO5Lqrno6NQEfa/rI6/N1GsgmqgEocBLzVZLC01OTtd
         rvkrIw4voJTioCdqshVZzGCErS7thXFb53RO+hdGMQANBnOcdWf+WcDN6E3QF/Nt2K
         ucxMcYQUQpS+Ct45nay2vBAdeEYg8XtPzR3XP5h0j9wZNb0bkhhdYOe3saf7tBMJP+
         85NqdnZPVGEGg==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout011 (Postfix) with ESMTP id 534EC5302EB
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 09:57:32 +0100 (CET)
Received: from lpn-prd-vrin001 (lpn-prd-vrin001.prosodie [10.128.63.2])
        by lpn-prd-vrout011 (Postfix) with ESMTP id 4E02C52BFB3
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 09:57:32 +0100 (CET)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
        by lpn-prd-vrin001 (Postfix) with ESMTP id 3D63F373100
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 09:57:32 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin001 (Postfix) with ESMTPA id 26CAC373089
        for <git@vger.kernel.org>; Fri,  2 Nov 2018 09:57:32 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 34AC122001A;
        Fri,  2 Nov 2018 09:57:31 +0100 (CET)
Message-ID: <1e3901b9a75a043d9c31d66d98410f3288a7c5be.camel@laposte.net>
Subject: Re: [RFE] Please add name and email to git credentials
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     Christian Couder <nicolas.mailhot@laposte.net>,
        nicolas.mailhot@laposte.net
Cc:     git <git@vger.kernel.org>
Date:   Fri, 02 Nov 2018 09:57:30 +0100
In-Reply-To: <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
         <87zhutjb3t.fsf@evledraar.gmail.com>
         <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
         <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
         <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
         <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieeigddufeefucetufdoteggodetrfdotffvucfrrhho
X-VR-Cause-2: fhhilhgvmecunfetrffquffvgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkuffhvfff
X-VR-Cause-3: jghftggfggfgsehtkeertddtreejnecuhfhrohhmpefpihgtohhlrghsucforghilhhhohhtuceonhhi
X-VR-Cause-4: tgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvtheqnecuffhomhgrihhnpehurhhlrdho
X-VR-Cause-5: nhgvnecukfhppeekvddrieegrdegledruddtheenucfrrghrrghmpehmohguvgepshhmthhpohhuthdp
X-VR-Cause-6: ihhnvghtpeekvddrieegrdegledruddthedphhgvlhhopegrrhgvkhhhrdguughnshdrnhgvthdpmhgr
X-VR-Cause-7: ihhlfhhrohhmpehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtpdhrtghpthht
X-VR-Cause-8: ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le vendredi 02 novembre 2018 à 09:27 +0100, Christian Couder a écrit :
> On Thu, Nov 1, 2018 at 3:42 PM Nicolas Mailhot
> <nicolas.mailhot@gmail.com> wrote:
> > Le jeudi 01 novembre 2018 à 15:13 +0100, Christian Couder a écrit :
> > > How can Git know when you commit where you will want to push the
> > > commit afterwards?
> > 
> > You have an url in the repo config. of course you can change it
> > between
> > the commit and the push, but that's not the general case.
> 
> If I did a `git init`, then I have no url in the repo config. Also if
> I cloned from a repo that has a different URL than the sites I have
> credentials for, then how should git use the URL in the repo config?

Then you have no need or use for git credentials. Where’s the problem? 

Will the fact that git credential users, that already have per-repo-url
settings in their .gitconfig, will also be able to use this existing
per-url section to control the mail and name associated with their
repos, wake you at night, or something?

> You could have no user.name and user.email configured in your global
> config, and a script that configures those in the local config
> depending on remote.origin.url. 

One could use the same arguments to say git credentials is not
necessary, it's a maintenance burden, everyone should just script their
auth needs manually, etc.

Are you arguing for git credentails removal here?

Or are you arguing that having two separate mecanisms in git, to match
config directives to repo urls, is some kind of improvement?

I didn't create or write or specify the way git credential matches repo
urls. It already exists within git. If you have a problem with the
matching logic git credential uses, why are you arguing with me instead
of taking it up with the maintainers of this logic?

Regards,

-- 
Nicolas Mailhot

