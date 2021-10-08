Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFBAC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F8D60F43
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhJHR75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:59:57 -0400
Received: from colin.muc.de ([193.149.48.1]:43925 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S231217AbhJHR7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:59:54 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 13:59:54 EDT
Received: (qmail 96681 invoked by uid 3782); 8 Oct 2021 17:51:17 -0000
Received: from acm.muc.de (p2e5d5cb1.dip0.t-ipconnect.de [46.93.92.177])
 (using STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Fri, 08 Oct 2021 19:51:17 +0200
Received: (qmail 8558 invoked by uid 1000); 8 Oct 2021 17:51:17 -0000
Date:   Fri, 8 Oct 2021 17:51:17 +0000
To:     git@vger.kernel.org
Subject: How do I get the file contents from an arbitrary revision to stdout?
Message-ID: <YWCFFcNeNVTYcELN@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git.

I want to get a file's content from a particular revision onto stdout for
backup purposes.  I can't see how to do this.  Help me, please!

Let's say the file is foo.c, and I want to get the version from the head
revision of bar-branch.

I would like there to be a command something like:

    $ git cat bar-branch -- foo.c

..  Is there such a command, and if so, what's it called and how do I use
it?  I assumed it might be git cat-file, but I couldn't get it to work,
and couldn't understand it's man page.

Where might I have found this information for myself?

Thanks in advance for the help!

-- 
Alan Mackenzie (Nuremberg, Germany).
