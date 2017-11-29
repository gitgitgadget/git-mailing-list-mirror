Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0911220C11
	for <e@80x24.org>; Wed, 29 Nov 2017 08:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbdK2IsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 03:48:00 -0500
Received: from sym2.noone.org ([178.63.92.236]:45953 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbdK2Ir7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 03:47:59 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 3ymvLj5Ffpzvjcb; Wed, 29 Nov 2017 09:47:57 +0100 (CET)
Date:   Wed, 29 Nov 2017 09:47:56 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] strbuf: Remove unused stripspace function alias
Message-ID: <20171129084755.GM1370@distanz.ch>
References: <20171129014559.32755-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129014559.32755-1-newren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-29 at 02:45:59 +0100, Elijah Newren <newren@gmail.com> wrote:
> In commit 63af4a8446 ("strbuf: make stripspace() part of strbuf",
> 2015-10-16), stripspace() was moved to strbuf and renamed to
> strbuf_stripspace().  A "temporary" alias was added for the old name until
> all topic branches had time to switch over.  They have had time, so remove
> the old alias.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Thanks!
