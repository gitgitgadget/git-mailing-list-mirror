Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B961F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeBZL2J (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:28:09 -0500
Received: from continuum.iocl.org ([217.140.74.2]:50003 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeBZL2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:28:09 -0500
X-Greylist: delayed 1872 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Feb 2018 06:28:08 EST
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w1QAugk06686;
        Mon, 26 Feb 2018 11:56:42 +0100
Date:   Mon, 26 Feb 2018 11:56:42 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     "'Peter Backes'" <rtc@helen.PLASMA.Xg8.DE>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason'" <avarab@gmail.com>,
        "'Derek Fawcus'" <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org, "'Theodore Ts'o'" <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180226105642.GA6549@inner.h.apk.li>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <20180221210339.GA43094@accordion.employees.org> <87bmgif2pa.fsf@evledraar.gmail.com> <20180221221420.GA7743@helen.PLASMA.Xg8.DE> <87a7w2ezeq.fsf@evledraar.gmail.com> <20180221231234.GA8509@helen.PLASMA.Xg8.DE> <007d01d3ab6f$e5439f10$afcadd30$@nexbridge.com> <20180222020535.GA11063@helen.PLASMA.Xg8.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222020535.GA11063@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Feb 2018 03:05:35 +0000, 'Peter Backes' wrote:
...
> The bigger issue is usually to copy with those pesky leap seconds. It 
> makes a difference whether one uses solar seconds ("posix" style; those 
> are more commonly seen) or atomic seconds ("right" style) for the UNIX 
> timestamp.

Is there any system, unix or otherwise, that uses 'right'-style seconds,
i.e. TAI, as its base?

(I.e. one where (time(0)%60) does not indicate the current position
of the second hand of an accurate clock?)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
