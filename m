Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34151F461
	for <e@80x24.org>; Wed, 10 Jul 2019 07:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGJHtp (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 03:49:45 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:64854 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGJHtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 03:49:45 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9084E5080D;
        Wed, 10 Jul 2019 09:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1562744956; bh=/jalDullCw
        /0mr8O59pwIl3Vdms88/BuxX2beJR6/vc=; b=Vq/qgqae5e9fZ/ugZV/qdQUOzF
        dNmqqda6s57qGz1xgHJx6A572MmKqOGK0m78qzpZ401hzFrL2F/SPNUQbmnO57Vy
        odkggnA5Wco53H6uyNN1YffE//N4rdt4deyVaVser67hvX7C77hgTy929HlFPnzH
        3u26MXScvVOGJFqa1FU90UVFcdG1LIDX+clmHoTUZympJ7JRXC4fwJf8sXm4pYKu
        EOStrZbQrdSnXQdkMk9516j+Y9RxQgJ6+Z7EnTS0ISpO0M0oDfJoVTirnk4elKp5
        oWZWvV6o5w2o5ONjRTcD//1acZZD2vKvj25robNudG0IpcOAKBwLmM8k+dsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1562744978; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFM5VL3O5y7cjsqn1qMp0wO8UAM5G/wpvGvWUnG6jOQ=;
        b=Z78nOUlLBB5hkB7mSefp1s1jdVvpzkrKMwH2aBGZ1jZawhKUBiWT6230skrz7tiNY2vb4J
        2xKH844Fj96ouAP3vS4Nii0N0iU3savfPcf62mPMW1QwcBlxG1rv7P/m8vtOXVXhdbr+5f
        wvEmDJBRZMO6mNB4UM+XlvJyx0vsFY4xXSu7tPlSoab8hmCwWspnl8lY9LDUrW45cJK8P6
        OdaJgJe8iQiOTHlvnfqLXhNNWRAKAxsbLrwfCqcAnGPX8on5vQH/EwePNx2uOjdjKSSxSR
        /ANhMsCxRs+/vtX8vwpnMrIzMairoWvP1T/loAClJbjQOLlhG2Dosbi5YoLp/g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id D9T04m2sSxmr; Wed, 10 Jul 2019 09:49:16 +0200 (CEST)
Date:   Wed, 10 Jul 2019 09:49:16 +0200 (CEST)
From:   usbuser@mailbox.org
To:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <1837375396.9386.1562744956530@office.mailbox.org>
In-Reply-To: <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
 <1152121968.7459.1562688927235@office.mailbox.org>
 <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
 <275487563.12198.1562691633735@office.mailbox.org>
 <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
 <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 09 July 2019 at 22:51 Bryan Turner <bturner@atlassian.com> wrote:
> 
> On Tue, Jul 9, 2019 at 1:33 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, Jul 9, 2019 at 10:00 AM <usbuser@mailbox.org> wrote:
> > >
> > > Additionally I would also want to change the wording for --ff-only, as it currently reads as if it only performs a check (which would lead to the expected behaviour) but does more than that, as it prevents "real merges" altogether.
> >
> > You've lost me again, I think.  You expect --ff-only to only perform a
> > check, i.e. to not update anything and thus only report on whether a
> > fast-forward would be possible, but leave the branch exactly where it
> > started no matter what?
> >
> > Or is it just still not clear that a fast forward by definition is not
> > "a real merge", i.e. it means to update using a mechanism that doesn't
> > involve creating any new commits?
> 
> I think this is something I've seen come up on the list before[1]
> (Roland can correct me if I'm wrong). What I've seen asked for before
> is the ability to pass the combination "--ff-only --no-ff" and have
> that:
> * Ensure the branch to be merged is fast-forward from the current
> branch (i.e., to ensure no merge commit is actually necessary), but
> * Create a redundant merge commit anyway
> 
> This retains the ancestry (as in, it shows where the branches were
> merged), but the merge is always effectively a no-op (no risk of
> unintended interactions, the sort of subtle breakages where the merge
> succeeds but the code on each "side" isn't entirely compatible,
> resulting in broken compilation and/or tests and/or runtime).
> 
> Best regards,
> Bryan Turner
> 
> [1] https://public-inbox.org/git/CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com/

This is exactly what I was expecting/wanting, thanks for clarifying.
