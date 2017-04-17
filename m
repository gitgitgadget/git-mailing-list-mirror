Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1471FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754902AbdDQVkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 17:40:09 -0400
Received: from oker.escape.de ([194.120.234.254]:43730 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754751AbdDQVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 17:40:08 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v3HLe4AJ020833;
        Mon, 17 Apr 2017 23:40:04 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v3HLe4fX020832;
        Mon, 17 Apr 2017 23:40:04 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v3HLa5Vv014047;
        Mon, 17 Apr 2017 23:36:05 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v3HLa43b014044;
        Mon, 17 Apr 2017 23:36:04 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Subject: Re: How to keep log history when renaming and changing simultaneously
References: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
        <f456df1f-cda2-4681-8f01-b693655e79a7@gmail.com>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   17 Apr 2017 23:36:04 +0200
In-Reply-To: <f456df1f-cda2-4681-8f01-b693655e79a7@gmail.com>; from Igor Djordjevic on Mon, 17 Apr 2017 22:34:32 +0200
Message-ID: <ygfefwqzph7.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> For both cases (renaming and splitting), would using `--find-copies` 
> work for you? Perhaps with some low threshold value to start with, if 
> the default one yields no results.
> 
> If interested, adding `--name-status` to the mix will show similarity 
> percentage between old and new file(s).

I didn't know --find-copies and --name-status and I've now looked them
up in the doc.  Looks interesting but instead of looking for
similarity it would be better IMHO if there was a command "git cp" and
that "git mv" and "git cp" were recorded in the history somehow.

I'm still using CVS (and SVN in some few cases) but considering
changing to git.  There are some things, however, that I can do more
easily in CVS (like editing CVS ,v files instead of git commit
--amend) and I need to learn more git before I want to change (and
migrate existing repos).

urs
