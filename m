Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6B61F403
	for <e@80x24.org>; Wed, 20 Jun 2018 04:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbeFTEj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 00:39:58 -0400
Received: from ikke.info ([178.21.113.177]:50148 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFTEj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 00:39:58 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id B8E0A4400AE; Wed, 20 Jun 2018 06:39:56 +0200 (CEST)
Date:   Wed, 20 Jun 2018 06:39:56 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
Cc:     hvoigt@hvoigt.net, Git Mailing List <git@vger.kernel.org>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180620043956.GC6958@alpha>
References: <20180618111919.GA10085@book.hvoigt.net>
 <20180618155544.GB6958@alpha>
 <20180619102717.GB10085@book.hvoigt.net>
 <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 11:29:02PM +0100, Rafael Ascensão wrote:
> On Tue, Jun 19, 2018 at 11:28 AM Heiko Voigt <hvoigt@hvoigt.net> wrote:
> >
> > Interesting and nobody complained to the mailinglist?
> >
> 
> For reference this was sometimes called "Fake Submodules" online.

Do you refer to cloning a repository in another repository, and running
`git add path` (no trailing /) so that a gitlink is created without a
.gitmodules file? Because that's not what Heiko is referring to.

What this is about that when doing `git add path/` (with trailing /),
git will add the files of the cloned repository to the parent repo, and
basically ignore that it's another repository.

And I guess no one complained because it looked like a feature rather
than a bug.

Kevin
