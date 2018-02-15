Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF921F404
	for <e@80x24.org>; Thu, 15 Feb 2018 00:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032301AbeBOAxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 19:53:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:46085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOAxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 19:53:18 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0Lwarz-1ejSNA1bYt-018GqZ; Thu, 15 Feb 2018 01:53:15 +0100
Date:   Thu, 15 Feb 2018 01:53:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Psidium Guajava <psiidium@gmail.com>
cc:     Stefan Beller <sbeller@google.com>, Paul Tan <pyokagan@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: git-rebase --undo-skip proposal
In-Reply-To: <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com> <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com> <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7Xju2vbs8Z+M0k5BqTImsgWVKxeqfeGOPQpn1AhD1r5cqnzxUF5
 iPYVshVQAQcCpRFu2hf3Vdpg5gyy0J/kEaBGZ8OLp+84Db5s/3U2UL0mUX+bD0WlFdnj6M7
 kMC9zol6ih9OPAEniBD357oe5r1psTyUyDyOitWzg1ZpwP6rdHgA8Q8b4oc+VK/xOTjxQ9E
 E5UftSavvujQU5Hu4lyIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ebqSDtJpY1M=:jnkc7pzIxyT37TUXc9V8MW
 lRbWkSIdRYYVNVedIvRX+hMMhAPk+G9Ei0Sjk7ZNaf5JdgX7QUd2BH/9eRQYN99u1iu/+Mezy
 fKPzZqhb4ZwD6OLYxyMDgnenRXvPy4I4lRUPkaQskCOz7uuU5j6edkOz3yabFHXjx1eHUvVQG
 ZNkTANC3YXJ8yxPA0BrVxgKJMSWIBLONTwKE5vsX8fZd9pHshWJy/W33FBe3vN60NQEhBLlKp
 8LnarmcsKT+cx0/dwX8KdSBP4mOlVvIiyXpwfTzRncxBB3bI9F3LZNiG847GAsVrPZnAXolGz
 lKqAGvT2OQfhxGaIYnwDZftQJDibtlpxqhWNNJbn8ttkBros2U43R7+up8pvRdNpRBrSDsZsW
 G9fmqeMrHalfJmkinJyGLop1fS8ouuBOyABJi3gUnxehoanr0atEFIjkmkf0WendytlNTf3wK
 IiBMPFylr5/HLiW5qG0o5t/N0bSBpXsZuazAm+ogZ3yooG1f7oIfcBPhHl8e0qjgEwBaQtLNp
 tRS+mY/iUMbuqSrky7kZeXi8/JO7G3OGzAGA87xS+olTLfBwEwJc9sHlc7MS5sTNKyA245lEQ
 HbvR0Pl4eft6V40gh6lcrpsB7qLHB74Je8z0e2IZsyfYqhyLQrvV3YDM69PbbkvRtmY7kK/JX
 dxMf5yeG/UrbFlfinfhXvYbEhVm+Z2TNRrQ0DxFNxR9+ld0zpRDo55uMwBC1n24XU/A5gHIB+
 5zt6AIkWSWqazWSqdUEHwbB+F4RV2mYesx0X53UivLVNLyVN4lK0RZwlN6CImGlK86Z5Z5vEr
 +RQtYhzjpOPex+4w8fo2MgB0Oylg9XByEcKlAN/PITw7X6I99g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 14 Feb 2018, Psidium Guajava wrote:

> On 2018-02-13 18:42 GMT-02:00 Stefan Beller <sbeller@google.com> wrote:
> > On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava <psiidium@gmail.com> wrote:
> > I think this could also be done with "git rebase --edit-todo", which brings
> > up the right file in your editor.
> 
> Yeah that'd would only work if one started a rebase as a interactive
> one, not am or merge.

I agree that the original proposal was clearly for the non-interactive
rebase (it talked about .git/rebase-apply/).

The biggest problem with the feature request is not how useful it would
be: I agree it would be useful. The biggest problem is that it is a little
bit of an ill-defined problem.

Imagine that you are rebasing 30 patches. Now, let's assume that patch #7
causes a merge conflict, and you mistakenly call `git rebase --skip`.

Now, when is the next possible time you can call `git rebase --undo-skip`?
It could be after a merge conflict in #8. Or in interactive rebase, after
a `pick` that was turned into an `edit`. Or, and this is also entirely
possible, after the rebase finished with #30 without problems and the
rebase is actually no longer in progress.

So I do not think that there is a way, in general, to implement this
feature. Even if you try to remember the state where a `--skip` was
called, you would remember it in the .git/rebase-apply/ (or
.git/rebase-merge/) directory, which is cleaned up after the rebase
concluded successfully. So even then the information required to implement
the feature would not necessarily be there, still, when it would be needed.

Ciao,
Johannes
