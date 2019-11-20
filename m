Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D50C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53AB2230E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfKTOWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:22:47 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60543 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKTOWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 09:22:46 -0500
X-Originating-IP: 157.45.8.100
Received: from localhost (unknown [157.45.8.100])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9E70A2000B;
        Wed, 20 Nov 2019 14:22:43 +0000 (UTC)
Date:   Wed, 20 Nov 2019 19:52:40 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: Making GitGitGadget's list -> PR comment mirroring
 bidirectional, was Re: [PATCH] Feature: custom guitool commands can now have
 custom keyboard shortcuts
Message-ID: <20191120142240.pc5kfpj4eflu7dub@yadavpratyush.com>
References: <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
 <20191006210647.wfjr7lhw5fxs4bin@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1911192305410.15956@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911192305410.15956@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/11/19 11:09PM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Mon, 7 Oct 2019, Pratyush Yadav wrote:
> 
> > On 06/10/19 10:27PM, Johannes Schindelin wrote:
> > > Hi Pratyush,
> > >
> > > On Mon, 7 Oct 2019, Pratyush Yadav wrote:
> > >
> > > > Anyway, GitGitGadget solves a large part of the problem. It
> > > > eliminates the need for using git-send-email, and it even shows you
> > > > the replies received on the list. I honestly think it is a great
> > > > tool, and it gives people a very good alternative to using
> > > > git-send-email.
> > >
> > > GitGitGadget is just a workaround. Not even complete. Can't be
> > > complete, really. Because problems. It has much of the same problems
> > > of `git send-email`: it's a one-way conversation. Code is not
> > > discussed in the right context (which would be a worktree with the
> > > correct commit checked out). The transfer is lossy (email is designed
> > > for human-readable messages, not for transferring machine-readable
> > > serialized objects). Matching original commits and/or branches to the
> > > ones on the other side is tedious. Any interaction requires switching
> > > between many tools. Etc
> > >
> > > > One feature that would make it complete would be the ability to
> > > > reply to review comments.
> > >
> > > And how would that work, exactly? How to determine *which* email to
> > > respond to? *Which* person to reply to? *What* to quote?
> >
> > GGG already shows replies to the patches as a comment. On GitHub you can
> > "Quote reply" a comment, which quotes the entire comment just like your
> > MUA would. The option can be found by clicking the 3 dots on the top
> > right of a comment.
> >
> > Then you can write your reply there, and the last line would be
> > '/reply', which would make GGG send that email as a reply. You would
> > need to strip the first line from the reply because GGG starts the reply
> > with something like:
> >
> >   > [On the Git mailing list](https://public-inbox.org/git/xmqq7e5l9zb1.fsf@gitster-ct.c.googlers.com), Junio C Hamano wrote ([reply to this](https://github.com/gitgitgadget/gitgitgadget/wiki/ReplyToThis)):
> >
> > GGG also adds 3 backticks before and after the reply content, so those
> > would need to be removed too.
> >
> > Does this sound like a sane solution?
> 
> Here are two real life examples where an unsuspecting GitGitGadget user
> expected GitGitGadget to mirror replies _to_ the Git mailing list:
> 
> https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068 and
> https://github.com/gitgitgadget/git/pull/451#issuecomment-555077933
> 
> Neither of them include the line with the link.

Correct.

The fundamental problem we have is that GitHub's threads are 
"shallow"/"linear". You don't reply to a reply, you reply to the main 
thread, and your comment gets appended to the end of that list. In 
contrast, email based threads are "deep"/"tree-like". Here you can reply 
to a reply.

So the comment model of GitHub is less information-rich than the email 
model. The piece of information missing is "which comment does this 
comment reply to". That information has to be obtained somehow, and the 
best bet are the users themselves (by not deleting the line with the 
link in their replies). We can give the instructions in the GGG welcome 
message, and hope the users read it.

Frequent users and anyone who properly reads the instructions will 
probably manage to use this just fine. Those who don't, well they 
weren't sending replies to the list to begin with. So this will help 
people who don't want to open their email clients to send replies to the 
list, but won't help the uninformed ones. Certainly not ideal, but I 
think this might be the best we can do given the constraints.

In the meantime, I notice that GGG does not advertise the fact that 
replies don't go on the list directly very well. Yes, its mentioned in 
the welcome message, but its not instantly obvious. So maybe making it 
clearer/more noticeable will help the issue.

Another alternative might be to rely on heuristics like seeing how 
similar the quoted text in a reply is to the replies in the list. But I 
think this will cause more problems than help because users can cut 
un-necessary quoting and even edit them sometimes.

If you can think of something clever that I can't, suggestions are 
welcome :)

Anyway, I probably won't have much time to work on this feature for at 
least a couple more weeks. Maybe we'll learn more after the feature goes 
live.

> Just to throw a bit of real life into the discussion...
> 
> Ciao,
> Dscho

-- 
Regards,
Pratyush Yadav
