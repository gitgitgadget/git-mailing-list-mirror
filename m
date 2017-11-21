Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1862036D
	for <e@80x24.org>; Tue, 21 Nov 2017 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdKUOvE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 09:51:04 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:41510 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdKUOvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 09:51:04 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:52406 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eH9t9-0006Qj-BE
        for git@vger.kernel.org; Tue, 21 Nov 2017 09:51:03 -0500
Date:   Tue, 21 Nov 2017 09:49:41 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: pedantry: is there a standard for what should be in the SYNOPSIS?
Message-ID: <alpine.LFD.2.21.1711210925530.6795@DESKTOP-1GPMCEJ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  following up on an earlier question of mine, is there a standard for
what options should be listed in either the SYNOPSIS or the
DESCRIPTION sections of a man page? i ask since i'm seeing some
definite inconsistency.

  in addition to the patch i submitted earlier, here are some other
examples.

  "man git-clone", the SYNOPSIS says nothing about options "--verbose"
or "-v", even though "git clone" supports those options and they're
mentioned further down that man page.

  on that same man page, there are a number of options that have two
supported forms (eg., "-l" and "--local"), but the SYNOPSIS shows only
the short form, while many other man pages show both (for another
example of this, see "man git-clean", which shows only the short
forms).

  also, regarding what seems to be a standard for some options, it
seems that many commands support both options "--verbose" and "-v" to
mean verbose operation (as long as "-v" isn't reserved for some other
option for that command, which occasionally happens). in cases where
"-v" is not being used, is there a reason to not just add it as an
equivalent to "--verbose"?

  the same thing could be said with respect to "-n" (as long as it's
available) always being the short form of "--dry-run". and so on, and
so on.

  oh, and i'm still wondering why some commands feel the need to
explain the function of "--", when that's the sort of thing that more
properly belongs in "man gitcli".

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
