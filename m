Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0F420954
	for <e@80x24.org>; Tue, 28 Nov 2017 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdK1Pc1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 10:32:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:50384 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753391AbdK1PcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 10:32:24 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lj4xG-1eq2120XCY-00dHfb; Tue, 28
 Nov 2017 16:32:22 +0100
Date:   Tue, 28 Nov 2017 16:32:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: bug deleting "unmerged" branch (2.12.3)
In-Reply-To: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
Message-ID: <alpine.DEB.2.21.1.1711281542400.6482@virtualbox>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h8TU9BeRtbNpWm+UkkrBZXIezag2DU4mJReSP6Ip08tzUe3IISy
 KETqFhv8f8VTMtKJWQTqqrkWn3axr80MsGhL3Dg6q3afY2NzcrdSxtlFHk+QfudJfX7gk7g
 WezAZKw381InLVnau6B/598DtgLVS6r1aOZTw0wtJ6Jqmk3ecTh+4kpbOzPGzUrnSVNFb0B
 LewsARJDnfsNafX1xA8lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yaHYK8D+xmk=:wJYPo+ityhi1KAmdJjLHxK
 imRb7fxlsJW27vsbH+ucWGd/9laumjsP6PPYJk+7ZkoYPLifg8GLlMce3LNbKWo9WKb09P2Jh
 d07S1obhFRvtVKszaCkphP5aa7UnjHHroWMU4TJCYIBf5xCsrfUiXeZjpDs3lGzeAEwKwD7r3
 eufpQq5iVhCGrMJz7D7BVW5Dwa340e4Tvxol9jUpAzTctnhzSlMSdvPd+xMODfDEu26XGgbvW
 0eKgjSF9LVxN9fRV1hMOnuQR7pTPnj58QInxXTJFAyCii3UwWMl07QfXMwyh2U1RdjpM5O3A8
 /FPGePWPnZGgyzVSYudX4oD3n0W+TubS201cvTinfNmnl+0jJST68DytHL9pnfXoxEnVR4yt3
 AaX5CjOOE8xMcIdgPKkEWAUey7GMhma7JDdbyZKHYRgDCBT4COIBBi6dPHVzWSO974+qbc8hI
 gEAbB3UyOPmPhs0bKlWRx+3dkhE9ATb2CXpOyTGw0ieiukOXq8yC9HBzCZGhPkY73OoCombuZ
 KYfdUGm4m6xo/CUJys06ov/ov+WIrAi7FYAQj6C8hOeX9Ggqz5NogwEu733/7IksY69Pqae3J
 RkmLJWwqe8P/0b2uJdvna2QE/7xCSahgSOG7G23AVCyB0dafttjw7LGoH2Qunom3GwS9De/xA
 DldH53NdcvBqm/J4yhBBhMIr5+O2AXYx5ukq9VUHhKe+KLnWZ0bv0KLXVZS07Zc/UFx4qQGNO
 9vsZdRYOvRnhEWvgQmTNEfgTv6U7lQjuqR6U/itZgjn2RD8pt8pNvFAajovSgHjIZgfIjVAEJ
 SwY89qRwrXHeX9rBwhrPQphZXmXC2/2+E0YcqjvG/4GxxYbl7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

On Tue, 28 Nov 2017, Ulrich Windl wrote:

> During a rebase that turned out to be heavier than expected 8-( I
> decided to keep the old branch by creating a temporary branch name to
> the commit of the branch to rebase (which was still the old commit ID at
> that time).
>
> When done rebasing, I attached a new name to the new (rebased) branch,
> deleted the old name (pointing at the same rebase commit), then
> recreated the old branch from the temporary branch name (created to
> remember the commit id).
>
> When I wanted to delete the temporary branch (which is of no use now), I
> got a message that the branch is unmerged.

This is actually as designed, at least for performance reasons (it is not
exactly cheap to figure out whether a given commit is contained in any
other branch).

> I think if more than one branches are pointing to the same commit, one
> should be allowed to delete all but the last one without warning. Do you
> agree?

No, respectfully disagree, because I have found myself with branches
pointing to the same commit, even if the branches served different
purposes. I really like the current behavior where you can delete a
branch with `git branch -d` as long as it is contained in its upstream
branch.

Ciao,
Johannes
