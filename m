Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9184207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbcJLNvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:51:24 -0400
Received: from wp069.webpack.hosteurope.de ([80.237.132.76]:34793 "EHLO
        wp069.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753533AbcJLNvW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Oct 2016 09:51:22 -0400
Received: from app08.ox.hosteurope.de ([92.51.170.15]); authenticated
        by wp069.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
        id 1buJw4-0007t6-Lp; Wed, 12 Oct 2016 15:51:08 +0200
Date:   Wed, 12 Oct 2016 15:51:08 +0200 (CEST)
From:   webmaster@peter-speer.de
Reply-To: webmaster@peter-speer.de
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <1259748848.41944.1476280268674.JavaMail.open-xchange@app08.ox.hosteurope.de>
In-Reply-To: <CANoM8SUtrV8CD8M=4CUB8xr9gQj_hKzGOdjQZHuz4+36y_UfJw@mail.gmail.com>
References: <1066408917.43087.1476269456819.JavaMail.open-xchange@app06.ox.hosteurope.de> <CANoM8SUtrV8CD8M=4CUB8xr9gQj_hKzGOdjQZHuz4+36y_UfJw@mail.gmail.com>
Subject: Re: git diff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev60
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;webmaster@peter-speer.de;1476280282;851dfe64;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Mike. Now I understood.

-fuz

> Mike Rappazzo <rappazzo@gmail.com> hat am 12. Oktober 2016 um 13:06
> geschrieben:
> 
> On Wed, Oct 12, 2016 at 6:50 AM, <webmaster@peter-speer.de> wrote:
> > Hi.
> >
> > I created a new branch named hotfix from master.
> > I switched to the branch, changed 1 file.
> >
> > Now I want to see the diff from the both using
> >
> > git diff hotfix master
> >
> > I do not see any output (difference).
> > When I do a git status I see my file with status mofified, not staged for
> > commit.
> 
> Since you just created the branch, and did not add any content, there
> is no difference to see. A branch is just a pointer to a commit. You
> now have two pointers pointing at the same commit.
> 
> If you want to see the difference between your changes and the master
> branch, you can omit the first reference:
> 
>  git diff master
> 
> When you start adding commits to your hotfix branch, you will be able
> to see the diff between that and master with the command that you
> gave. However, your arguments may be in the reverse order than what
> you expect. You want to specify master first because that is the
> mainline branch (I presume).
> 
> When you have several commits on your hotfix branch, you can refer to
> older commits to diff against. There are several ways to refer back,
> but the simplest is to use a tilde '~' followed by a number to count
> back. For example 'hotfix~1' refers to the parent commit on the
> hotfix branch. There is a lot in the documentation[1], so take a look
> there for more info.
> 
> Good luck.
> _Mike
> 
> [1] https://git-scm.com/doc
> 
> > Also, I can see that I am working with the correct branch, hotfix
> >
> > What am I doing wrong?
> >
> > -fuz
> 
> On Wed, Oct 12, 2016 at 6:50 AM, <webmaster@peter-speer.de> wrote:
> > Hi.
> >
> > I created a new branch named hotfix from master.
> > I switched to the branch, changed 1 file.
> >
> > Now I want to see the diff from the both using
> >
> > git diff hotfix master
> >
> > I do not see any output (difference).
> > When I do a git status I see my file with status mofified, not staged for
> > commit.
> > Also, I can see that I am working with the correct branch, hotfix
> >
> > What am I doing wrong?
> >
> > -fuz

>
