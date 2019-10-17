Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E651F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 15:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407885AbfJQPLI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 11:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfJQPLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 11:11:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313DB20820;
        Thu, 17 Oct 2019 15:11:07 +0000 (UTC)
Date:   Thu, 17 Oct 2019 11:11:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Pratyush Yadav <me@yadavpratyush.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017111101.1456faaf@gandalf.local.home>
In-Reply-To: <507d7293-964a-048b-2de6-98e7e7982cfb@oracle.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
        <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
        <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
        <20191017131140.GG25548@mit.edu>
        <507d7293-964a-048b-2de6-98e7e7982cfb@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 Oct 2019 16:01:33 +0200
Vegard Nossum <vegard.nossum@oracle.com> wrote:

> In your example, couldn't Darrick simply base his xfs work on the latest
> xfs branch that was pulled by Linus? That should be up to date with all
> things xfs without having any of the things that made Linus's tree not
> work for him.

Sure, but why?

I thought this whole exercise is to make the process easier. This seems
to be making it more complex. Now we are going to be demanding
submitters to be basing their work on a specific (older) commit.

I always tell people that submit to me, to base off of one of Linus's
latest tags. That's what I do.

-- Steve
