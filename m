Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9FB1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3000173AbdD2W4q (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 18:56:46 -0400
Received: from ikke.info ([178.21.113.177]:56368 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427054AbdD2W4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 18:56:45 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A3056440082; Sun, 30 Apr 2017 00:56:42 +0200 (CEST)
Date:   Sun, 30 Apr 2017 00:56:42 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Nikita Orlov <fatemail@mail.ru>
Cc:     git@vger.kernel.org
Subject: Re: git loses a commit after reordering.
Message-ID: <20170429225642.GA25902@alpha.vpn.ikke.info>
References: <1493278996.239768474@f402.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493278996.239768474@f402.i.mail.ru>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 10:43:16AM +0300, Nikita Orlov wrote:
> Hello, my name is Nikita (male).
> 
> Could you explain this (subject) is a bug or a feature?
> 
> [snip]
> 
> "Some independent changes 1" is missed and its changes are missed as well.
> 
> I tried to move another commit to a farther distance below but there was still only one missed commit.
> 
> Could you explain it?
> 
> Thank you in advance and sorry for my English.
> 
> Best, Nikita

[man git-rebase][0] mentions this under the bug section:

> The todo list presented by --preserve-merges --interactive does not
> represent the topology of the revision graph. Editing commits and
> rewording their commit messages should work fine, but attempts to
> reorder commits tend to produce counterintuitive results.

Not sure if this is the case here, but it at least confirms that rebase
--preserve-merges was not meant to reorder commits.

See [this][1] thread for more background on this limitation.

[0]:https://git-scm.com/docs/git-rebase#_bugs
[1]:https://public-inbox.org/git/1mtveu4.19lvgi1c0hmhaM%25lists@haller-berlin.de/
