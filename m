Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE241F404
	for <e@80x24.org>; Sun,  8 Apr 2018 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDHCrx (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 22:47:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39206 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752466AbeDHCru (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 22:47:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D09D41F404;
        Sun,  8 Apr 2018 02:47:49 +0000 (UTC)
Date:   Sun, 8 Apr 2018 02:47:49 +0000
From:   Eric Wong <e@80x24.org>
To:     David Davis <davidjamesdavis.djd@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git send-email not sending email patches as subsequent replies
Message-ID: <20180408024749.GA19319@whir>
References: <CANqAOmsZxpbkT3YFcZTOeRx2gnxnzc+_C-amVQjKSE=0m7_n7w@mail.gmail.com>
 <20180407230848.GA5048@80x24.org>
 <CANqAOmvjiiBQs4GHrFbBBXygwVEsCkH7ceSsFKFpmvscKCWrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANqAOmvjiiBQs4GHrFbBBXygwVEsCkH7ceSsFKFpmvscKCWrGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Davis <davidjamesdavis.djd@gmail.com> wrote:
> I'm seeing 6 individual emails, how do I just see one email followed by 5
> email replies to the one? I don't want six individual emails.

The five email replies you want are still individual emails.
Emails are ALWAYS "individual", and reply emails simply have a
References: and/or In-Reply-To: header in them.

Whether your mail client shows them as individual mails is
another story.  I also suspect whatever mail client you're using
isn't rendering thread hierarchies correctly.

Most good mail clients use the same algorithm to display message
threads since the days of Netscape:

	https://www.jwz.org/doc/threading.html

I've also modified that algorithm to be recursion-free for public-inbox:

	https://rt.cpan.org/Public/Bug/Display.html?id=116727


Btw, please disable HTML mail in your mail client or it won't
show up on the list (and other people won't be able to help).
I may not be around much for a bit.
