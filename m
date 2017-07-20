Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A902D20387
	for <e@80x24.org>; Thu, 20 Jul 2017 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbdGTIBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 04:01:18 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:52821 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdGTIBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 04:01:18 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id B3A70D40110;
        Thu, 20 Jul 2017 11:01:16 +0300 (MSK)
Date:   Thu, 20 Jul 2017 11:01:16 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Volodymyr Sendetskyi <volodymyrse@devcom.com>
Cc:     git@vger.kernel.org
Subject: Re: Binary files
Message-ID: <20170720080116.7os2bxytm25qdt25@tigra>
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
 <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 10:41:48AM +0300, Volodymyr Sendetskyi wrote:

> It is known, that git handles badly storing binary files in its
> repositories at all.
[...]
> So the question is: why not implementing some feature, that would
> somehow handle this problem?
[...]

Have you examined git-lfs and git-annex?
(Actually, there are/were more solutions [1] but these two appear to be
the most used novadays.)

Such solutions allow one to use Git for what it does best and defer
handling of big files (or files for which lock-modify-unlock works better
than the usual modify-merge) to a specialized solution.

1. http://blog.deveo.com/storing-large-binary-files-in-git-repositories/

