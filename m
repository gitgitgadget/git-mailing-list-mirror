Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6898620899
	for <e@80x24.org>; Wed,  2 Aug 2017 21:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdHBVfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 17:35:06 -0400
Received: from oker.escape.de ([194.120.234.254]:35627 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdHBVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 17:35:05 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v72LZ3ou021671
        for <git@vger.kernel.org>; Wed, 2 Aug 2017 23:35:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v72LZ3r5021659
        for git@vger.kernel.org; Wed, 2 Aug 2017 23:35:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v72LY7NN002107
        for <git@vger.kernel.org>; Wed, 2 Aug 2017 23:34:07 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v72LY7QD002104;
        Wed, 2 Aug 2017 23:34:07 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Subject: Re: git svn fetch --localtime produces wrong commit times
References: <ygf8tj26npy.fsf@tehran.isnogud.escape.de>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   02 Aug 2017 23:34:07 +0200
In-Reply-To: <ygf8tj26npy.fsf@tehran.isnogud.escape.de>; from Urs Thuermann on 02 Aug 2017 16:36:25 +0200
Message-ID: <ygfpocd7iy8.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Urs Thuermann <urs@isnogud.escape.de> writes:

> I could find the bug grepping through /usr/lib/git-core/git-svn, maybe
> it's in GIT::SVN::Fetcher or some other GIT::SVN module.

Oops, that should be "could *not* find", of course.

urs
