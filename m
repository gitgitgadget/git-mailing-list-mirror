Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FC31F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeGDOQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 10:16:39 -0400
Received: from sym2.noone.org ([178.63.92.236]:43523 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeGDOQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 10:16:38 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 41LNMm67Fnzvjc1; Wed,  4 Jul 2018 16:16:36 +0200 (CEST)
Date:   Wed, 4 Jul 2018 16:16:35 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, dana <dana@dana.is>,
        Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] git-rebase--{interactive,preserve-merges}: fix
 formatting of todo help message
Message-ID: <20180704141635.GH24016@distanz.ch>
References: <1530706658-20519-1-git-send-email-tklauser@distanz.ch>
 <nycvar.QRO.7.76.6.1807041505000.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807041505000.75@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

Thanks for your detailed answer.

On 2018-07-04 at 15:09:34 +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 4 Jul 2018, Tobias Klauser wrote:
> 
> > Part of the todo help message in git-rebase--interactive.sh and
> > git-rebase--preserve-merges.sh is unnecessarily indented, making the
> > message look weird:
> > 
> >   # These lines can be re-ordered; they are executed from top to bottom.
> >   #
> >   # If you remove a line here THAT COMMIT WILL BE LOST.
> >   #
> >   #       However, if you remove everything, the rebase will be aborted.
> >   #
> >   #
> >   # Note that empty commits are commented out
> > 
> > Remove the extra lines and trailing indent to make it look as follows:
> > 
> >   # These lines can be re-ordered; they are executed from top to bottom.
> >   #
> >   # If you remove a line here THAT COMMIT WILL BE LOST.
> >   #
> >   # However, if you remove everything, the rebase will be aborted.
> >   #
> >   # Note that empty commits are commented out
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Thank you for this contribution!
> 
> Funnily enough, the same fix had been provided here:
> https://public-inbox.org/git/614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is/
> although only for `git-rebase--interactive.sh`.
> 
> In that thread, we agreed that it overlaps too much with a GSoC project,
> and that that project already addresses the same problem by way of
> rewriting that part in C (and therefore we decided it would be better to
> go with those patches).

Unfortunately I don't follow git development that closely anymore, so I
wasn't aware of the previous patch and the discussion. Sorry about the
duplication/conflict.

And I'm glad to see that this part will be rewritten in C :-)

> However, your patch also covers this:
> 
> >  git-rebase--preserve-merges.sh | 4 ++--
> 
> I completely missed that in the earlier patch.
> 
> Junio, this gets an ACK from me, could you apply the
> `git-rebase--preserve-merges.sh` part selectively, please?

Let me know if I should provide an updated patch just for
git-rebase--preserve-merges.sh

Thanks
Tobias
