Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6903CC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C26206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFOKHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:07:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOKHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:07:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F4154ACBD;
        Mon, 15 Jun 2020 10:07:40 +0000 (UTC)
Date:   Mon, 15 Jun 2020 12:07:35 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200615100735.GV21462@kitsune.suse.cz>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz>
 <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
 <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
 <xmqqlfktbpnf.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006140458200.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2006140458200.56@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 04:59:32AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 11 Jun 2020, Junio C Hamano wrote:
> 
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> > > On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
> > >> On Thu, Jun 11, 2020 at 1:52 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > >>> Indeed, the flexibility to choose the name of the default branch can be
> > >>> helpful for projects with specific naming, especially non-english
> > >>> speaking projects.
> > >>>
> > >>> To that end I would suggest adding -b argument to git init to be able to
> > >>> choose the default branch name per project. This should select the
> > >>> initial branch name and also write the it as the default branch name in
> > >>> the repo configuration (if git continues to treat the default branch
> > >>> specially).
> > >>>
> > >>> This can be used in documentation to use the new name immediately
> > >>> without breaking existing workflows that rely on the 'master' branch.
> > >>
> > >> I _really_ like this idea (and your reasoning). Seconded.
> > >
> > > Yes, adding a -b|--branch option would be an excellent addition to
> > > the config option.
> >
> > In the ideal world, users should be able to just set
> > init.defaultBranchName in ~/.gitconfig once and forget about it.
> > But it is expected that some projects and their tools may heavily
> > depend on the assumption that the primary branch is called 'master'.
> > Giving a command line override like "init -b" (and do not forget to
> > do the same for "clone" as necessary) is a good escape hatch for
> > members of such projects.
> 
> I agree, and I incorporated this already in the latest version I pushed to
> https://github.com/gitgitgadget/git/pull/656.

Why should everyone use the same branch names?

It makes more sense for people to name their branches in a way that
makes sense in the context of their project/workflow/language.

Showing the use of -b with init in tutorials and examples would
facilitate that.

Thanks

Michal
