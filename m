Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083991FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbcLEWy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:54:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36642 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbcLEWyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:54:25 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 921171FBB0;
        Mon,  5 Dec 2016 22:54:24 +0000 (UTC)
Date:   Mon, 5 Dec 2016 22:54:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Juergen Kosel <juergen.kosel@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: Set git svn options in .git/config file
Message-ID: <20161205225424.GA29771@starla>
References: <1936940c-c4c8-540c-eb99-b434e8d32d6c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1936940c-c4c8-540c-eb99-b434e8d32d6c@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Juergen Kosel <juergen.kosel@gmx.de> wrote:
> Therefore I believe, that it would be the best solution to store the
> settings of --add-author-from, --use-log-author and maybe
> --authors-prog in the .git/config file.

Actually, "svn.authorsProg" is already documented as a config
option for --authors-prog.

It's been a while since I looked at this, but in git-svn,
all the "--xxx-yyy" command-line options should be available
under the appropriate "svn.xxxYyy" config key.

So, can you confirm that svn.addAuthorFrom and svn.useLogAuthor
config keys work and can be documented?

Even better would be for you to provide a patch to the
documentation :)
Otherwise, I can write one up sometime this week.

Thanks.
