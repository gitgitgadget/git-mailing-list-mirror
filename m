Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC57C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EE82076E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKMQIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:08:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMQIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:08:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94615ABD9;
        Fri, 13 Nov 2020 16:08:47 +0000 (UTC)
Date:   Fri, 13 Nov 2020 17:08:46 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201113160846.GI29778@kitsune.suse.cz>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113145802.GB3985404@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 09:58:02AM -0500, Theodore Y. Ts'o wrote:
> On Fri, Nov 13, 2020 at 12:28:52AM -0600, Felipe Contreras wrote:
> > On Thu, Nov 12, 2020 at 11:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > 
> > > Is it changing the default branch name when creating a new repository?
> > > (Which affects only people creating new repositories)
> > 
> > You may choose to downplay the experience of certain part of the
> > user-base, because in your experience creating new repositories
> > doesn't happen often, but that doesn't mean these users don't exist.
> 
> OK, fine.  That wasn't clear in your earlier messages.  So this is
> *not* like 2008, where we are breaking workflows or finger macros of
> *existing* git users.
> 
> Instead, we might be causing a certain amount of confusion with
> respect to *new* users, especially if some portion of them are using
> an older version of git, where the default initial branch name is
> "master", or a newer version of git, where the default initial branch
> name is "main".
> 
> It's important we be specific about the concern, as opposed to using
> abstract notions of "backwards compatibility".  Because I'll note that
> even if we were to release a git 3.0, it's not going to fix the
> potential confusion where some students / new users trying to follow a
> tutorial are using git 2.x, and some are using git 3.x.
> 
> We could delay making the change for years, but that isn't going to
> guarantee that all of the various tutorials on the 'net will be
> changed, and experience from long deprecation periods (exhibit 1:
> Pythonx 2.x vs Python 3) is that people will drag there feet and put
> off doing the work to migrate for years and years and years.

But we could, for example, provide a way to specify the default branch
when creating the repository, and rewrite the tutorials to advise users
to specify a branch name, at least the ones provided by git project
itself. Then what the default is does not matter.

Thanks

Michal
