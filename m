Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A8020282
	for <e@80x24.org>; Tue, 13 Jun 2017 06:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdFMGmL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 02:42:11 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54616 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdFMGmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 02:42:09 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id BF821D400B2;
        Tue, 13 Jun 2017 09:42:02 +0300 (MSK)
Date:   Tue, 13 Jun 2017 09:42:02 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Samuel Lijin <sxlijin@gmail.com>,
        Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Show status of the stash in git status command
Message-ID: <20170613064142.aww23a75pu3ytym6@tigra>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
 <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
 <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
 <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
 <2217b9a1-dc8c-635a-649e-eae2dec5aaa5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2217b9a1-dc8c-635a-649e-eae2dec5aaa5@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 11:42:44PM -0400, liam Beguin wrote:

[...]
>> Conceptually, the contents of the stash are *not* commits, even
>> though the implementation happens to use a commit to represent each
>> stash entry.  Perhaps "has %d entry/entries" is an improvement, but
>> a quick scanning of an early part of "git stash --help" tells me
>> that
> 
> what's different between a stash and a commit? 

The same that exists between an interface and a concrete implementation
in a programming language.

"A stash entry" is a concept which is defined to keep explicitly
recorded untracked files and which can be applied, shown and deleted
from the stash bag (well, you can create a branch off it as well).

The fact a stash entry is a merge commit of two synthetic commits is an
implementation detail.  It can be very useful at times for power users,
but regular Git users need not be concerned with this.

Another fact worth reiterating that what the UI displays to the user is
better to match what the user reads in the docs. ;-)

