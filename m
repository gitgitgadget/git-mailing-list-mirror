Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB1A1FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 08:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbcLIIZj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 03:25:39 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:34500 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbcLIIZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 03:25:38 -0500
Received: from tigra.domain007.com ([192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id uB98PU5S021784;
        Fri, 9 Dec 2016 11:25:32 +0300
Date:   Fri, 9 Dec 2016 11:25:30 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     git@vger.kernel.org
Cc:     "Karamjeet Singh" <karamjeet.singh@netsutra.com>
Subject: Re: git bash error
Message-Id: <20161209112530.6ed9a309c4169182a1d163ea@domain007.com>
In-Reply-To: <58D2713C848141E88F0156A1BF3A8B19@Karamjeet>
References: <58D2713C848141E88F0156A1BF3A8B19@Karamjeet>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Dec 2016 11:38:55 +0530
"Karamjeet Singh" <karamjeet.singh@netsutra.com> wrote:

> Dear git support,
> My app is crashing whenever i launch the git bash tool. I am
> attaching the error log file from the event viewer. Can you please
> let me know what the issue is with it.
> https://www.dropbox.com/sh/mhkmjn8bmh3x1oh/AABUKmhnn-HW2Kv5UVxdckN6a?dl=0

Hi!

Your report misses lots of information required to even approach it:

- What Git version are you using (the fact is: in each next version of
  a software package some bugs get fixed and others might creep in;
  so knowing an exact version is paramount).

- What OS? Version, flavor, architecture (32/64 bit).

- What software package (i.e. where did you get your Git install from)?

From the term "git bash", I gather you're talking about Git for Windows.
If so, that project has its own bug tracker on Github [1] -- because
it's still a project sort-of separate from the "vanilla" Git due to
the fact it maintains a set of changes not yet in the Git proper, and
they do packaging work, too.

Please use that issue tracker in two steps:

1) Search it for your issue.  Say, remove the "is:open" modifier from
   the search box in the tracker's web interface, put there the words
   "git", "bash" and "crash" and search.  I'm sure you'll get a hefty
   amount of reports.  Please see whether your issue is already
   reported.

2) If yes, and if (and only if) you have additional details about it,
   please summarise them in a comment.  Please try to write that in
   plain English (plain bad non-native English is okay :-)); try not to
   post links to pictures or videos.  They aren't indexed by search
   engines and require the maintainers to switch their context when
   reading your report/comment.  On some platforms (say, w/o proper
   full-blown web browser) they can even be plain hard to even see.

3) If no, write your report there -- by filling the offerred template.

Thanks.

1. https://github.com/git-for-windows/git/issues/
