Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8521F516
	for <e@80x24.org>; Wed, 27 Jun 2018 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeF0XQO (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 19:16:14 -0400
Received: from pug.qqx.org ([50.116.43.67]:42760 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbeF0XQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 19:16:13 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 19:16:13 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 464E71FC52; Wed, 27 Jun 2018 19:09:57 -0400 (EDT)
Date:   Wed, 27 Jun 2018 19:09:57 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        bturner@atlassian.com, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v3] Documentation: declare "core.ignorecase" as internal
 variable
Message-ID: <20180627230957.GB15174@pug.qqx.org>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, bturner@atlassian.com,
        Marc Strapetz <marc.strapetz@syntevo.com>
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
 <c899089d-c195-26b5-66ce-de0273a7152b@syntevo.com>
 <xmqqzhzgdoyb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzhzgdoyb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10+54 (a2b9571d3) (2018-06-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 12:11 -0700 27 Jun 2018, Junio C Hamano <gitster@pobox.com> wrote:
>Hmph.  Do other people have difficulty applying this patch to their
>trees?  It is just several lines long so I could retype it myself,
>but I guess "Content-Type: text/plain; charset=utf-8; format=flowed"
>has destroyed formatting of the patch rather badly.

Yes, format=flowed requires lines that start with a space (along with 
'>' or 'From ') to be space-stuffed, adding a leading space. This will 
affect context lines in patches.

I was able to apply it cleanly (I think) by sending the message to: 

  sed '/@@/,$s/^  / /' | git am

That's replacing two leading spaces with one.
