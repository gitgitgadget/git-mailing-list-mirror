Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B676C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F9A2137B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMFO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:14:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40856 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbgKMFO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:14:28 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AD5E9aY001197
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 00:14:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0ACD1420107; Fri, 13 Nov 2020 00:14:09 -0500 (EST)
Date:   Fri, 13 Nov 2020 00:14:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201113051408.GA3985404@mit.edu>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe I'm missing something, but I'm very confused about what is going
to be changed that you are concerned about.  What is it precisely that
going to be happening (or which you think is going to be happening)
which is causing you concern?


Is it changing the default branch name when creating a new repository?
(Which affects only people creating new repositories)

Is it renaming the master branch for the git repo?  (which affects
people who are developing or tracking git via the repository, as
opposed to using a pre-packaged git provided by their Linux
Distributions / OS).

Is it improving the tools so that other projects can more easily
rename their primary development branch from master to main?  (Which
many projects have been doing *already*, without not a lot of Sturm
und Drang as near as I can tell, at least in many/most cases.)

Is it removing places in the git program where "master" is treated
specially (e.g., in how the default text for merge descrtipion is
worded)?

What, specifically, is the "backwards incompatible change" that you
are most worried about?  Because many projects have already been
renaming their primary development branch from master to main
*already*.

						- Ted
