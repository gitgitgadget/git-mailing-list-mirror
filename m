Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF53207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbcJFOkv (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 10:40:51 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35757 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbcJFOku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 10:40:50 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u96EefYj015359;
        Thu, 6 Oct 2016 17:40:42 +0300
Date:   Thu, 6 Oct 2016 17:40:41 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     "Vacha, Brian [USA]" <vacha_brian@bah.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fork Errors
Message-Id: <20161006174041.4225c2b52bd144e5b3db8a85@domain007.com>
In-Reply-To: <2E2ADD8A4AA3FA44A8D8FB00E2B24154B5E9E1C6@ASHBDAG1M3.resource.ds.bah.com>
References: <2E2ADD8A4AA3FA44A8D8FB00E2B24154B5E9E1C6@ASHBDAG1M3.resource.ds.bah.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Oct 2016 14:02:09 +0000
"Vacha, Brian [USA]" <vacha_brian@bah.com> wrote:

> When starting Git Bash, I receive the following errors:
> 0 [main] bash 18088 fork: child 14072 - died waiting for dll loading,
> errno 11 bash: fork: retry: No child processes
> 1190419 [main] bash 18088 fork: child 8744 - died waiting for dll
> loading, errno 11 bash: fork: retry: No child processes
> 3343518 [main] bash 18088 fork: child 12324 - died waiting for dll
> loading, errno 11 bash: fork: retry: No child processes
> 7480858 [main] bash 18088 fork: child 17008 - died waiting for dll
> loading, errno 11 bash: fork: retry: No child processes
> 15635036 [main] bash 18088 fork: child 8108 - died waiting for dll
> loading, errno 11 bash: fork: Resource temporarily unavailable
> bash-4.3$
> 
> My connection is great at 72 Mbps download and 93 Mbps upload.  I
> don't receive other errors so it appears to be a Git Bash issue to me.

Have you tried searching through Git for Windows bugtracker [1] for
your problem.  I'm pretty sure it was recently discussed there.
The issue #776 [2] looks like the one you're experiencing.

1. https://github.com/git-for-windows/git/issues
2. https://github.com/git-for-windows/git/issues/776
