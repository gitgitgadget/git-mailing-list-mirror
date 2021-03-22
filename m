Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C6C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9087461992
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVLyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:54:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41175 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229472AbhCVLyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:54:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12MBsHQv021265
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 07:54:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C08D15C39CC; Mon, 22 Mar 2021 07:54:17 -0400 (EDT)
Date:   Mon, 22 Mar 2021 07:54:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Chavez <x10an14@gmail.com>, git@vger.kernel.org
Subject: Re: Are there any publicly known funders (companies or otherwise) of
 git development?
Message-ID: <YFiFaV/n0To/+VNF@mit.edu>
References: <CAF6oXFsnvvacvUY89s65us7-UprpvV-NaOQ3owGTF25xcJqnkg@mail.gmail.com>
 <YFURduetSoPW/Scd@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFURduetSoPW/Scd@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 09:02:46PM +0000, brian m. carlson wrote:
> > 
> > Or is there any (publically known - not just an employee "randomly"
> > being told to upstream a bugfix) funded effort?
> > Such as with the Linux kernel project - where companies/organizations
> > put up money for X amount of time/efforts/projects?

There are cases where companies just "put up money", but that's
actually not all that common in the Linux kernel project.

The categorizations which Brian wrote below applies just as much to
the Linux kernel project and other major OSS projects.  Some people
are employed by some company to work 100% on a project; others work on
"20% time"; others are hobbists.

Of those work on OSS projects on corporate time, many are assigned to
a particular product (for example Android, SuSe Linux, etc.) and so
they work on features that benefit their company's product --- and
then they submit their patches to the OSS project so they don't have
to keep forward-porting features needed by their product to newer
versions of the kernel or other OSS project.  At least in the Linux
kernel world, I'd say this describes the majority of people who work
on corporate time.  And given that there are quite a few companies in
the git ecosystem (e.g., GitHub, GitLab, etc.) I suspect that's true
in the git world as well.

Cheers,

						- Ted

> There are people in the Git development community who usually work on
> Git most or full time as part of their role.  That doesn't mean those
> patches immediately make it to the list (oftentimes they are tested and
> deployed internally first), but they do generally work on Git most of
> the time and their patches do eventually show up on the list.
> 
> There are also people who work on Git with their employer's 20% time.  I
> believe we have several such contributors here in this case.
> 
> There are also people like me who usually contribute independently.  I
> have sent patches upstream that directly benefit my employer by fixing a
> direct need (in some cases written during work hours, in some cases not,
> depending on my employer at the time), but the vast majority of my work
> is independent and done on my own time.  There are others who just
> contribute independently altogether because they enjoy it.
> 
> I would say that of the top 20 contributors historically, I know that 4
> fit into the first category, 2 fit into the second category, and 3 more
> have some other corporate affiliation known to me (but not into what
> category they fall).  There are others who have more recent
> contributions who are also known to send patches on behalf of their
> employer.  I just don't know about the rest, mostly because it hasn't
> come up in context and it's never been important to me.
> 
> There are some employers that are well known to employ people in the
> first and second categories, as well as some that are known to have
> staff that send patches on behalf of their employer.
> 
> Hopefully that answers your question reasonably well, even if it's a
> little vague because I lack all the details.
> -- 
> brian m. carlson (he/him or they/them)
> Houston, Texas, US


