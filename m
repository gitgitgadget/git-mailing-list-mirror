Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13F31FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423073AbdD1IlO (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:41:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43381 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S969072AbdD1Ikx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:40:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA4D7AB46;
        Fri, 28 Apr 2017 08:40:46 +0000 (UTC)
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
 <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
 <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
 <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com>
 <653b67e6-9dba-d331-c396-932a59cdb4da@alum.mit.edu>
 <CAGZ79kY2Yu=B+75D6DpNjdriAZnJ5pZSmYAUiYtF2aUK47_HPw@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <86d57f89-b554-4268-6f4e-ea9812ad4b7a@suse.cz>
Date:   Fri, 28 Apr 2017 10:40:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY2Yu=B+75D6DpNjdriAZnJ5pZSmYAUiYtF2aUK47_HPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/27/2017 11:17 PM, Stefan Beller wrote:
> Maybe turning on this feature by default is the next step instead of
> adding them to bash competition or making them available in plumbing
> commands for the upcoming release.

Hello.

Works for me, please ignore the patch I've sent ;)

Anyhow, nice option (functionality), I really like it.
Martin
