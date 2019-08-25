Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8260D1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 12:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfHYMH5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 08:07:57 -0400
Received: from ikke.info ([178.21.113.177]:55814 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHYMH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 08:07:57 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Aug 2019 08:07:57 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id B6EEB4400FA; Sun, 25 Aug 2019 13:59:29 +0200 (CEST)
Date:   Sun, 25 Aug 2019 13:59:29 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned
 repos
Message-ID: <20190825115929.GA21463@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Albert Vaca Cintora <albertvaka@gmail.com>, git@vger.kernel.org
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 10:43:45PM +0200, Albert Vaca Cintora wrote:
> Hi git folks,
> 
> Honestly I'm not aware of the reason behind .git being read-only, but
> I'm sure there is one.
> 
> However, I'm sure that a large percentage of developers out there will
> agree with me that having to use force (-f) to delete every cloned
> repo is annoying, and even worse, it creates the bad habit of always
> force-deleting everything.
> 
> Would you find reasonable to add an option to keep .git writable on
> cloned repos?
> 
> PS: I'm not subscribed to the list, so please CC me on replies.
> 
> Thanks!
> Albert

To clarify, you are probably referring to things like pack-files, which
are created read-only. Most files / directories in .git are writable.

It think this is already quite old behavior and I could not find any
reference as to why this is done.
