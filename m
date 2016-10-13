Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A1B20989
	for <e@80x24.org>; Thu, 13 Oct 2016 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756251AbcJMP5r (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 11:57:47 -0400
Received: from ikke.info ([178.21.113.177]:45730 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755538AbcJMP5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 11:57:46 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id B01C94401D7; Thu, 13 Oct 2016 17:49:59 +0200 (CEST)
Date:   Thu, 13 Oct 2016 17:49:59 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     webmaster@peter-speer.de, git <git@vger.kernel.org>
Subject: Re: git branches & merge
Message-ID: <20161013154959.GB1698@ikke.info>
References: <1240187899.41938.1476280216470.JavaMail.open-xchange@app08.ox.hosteurope.de>
 <CACNzp2nG1KfFuiSH1UUGVSz1T39PjzfDgCp6vqOVe7-Lph2yNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACNzp2nG1KfFuiSH1UUGVSz1T39PjzfDgCp6vqOVe7-Lph2yNw@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 04:43:07PM +0200, Anatoly Borodin wrote:
> Hi,
> 
> 
> the IP will not be overwritten, you'll still have the new IP in
> master. Nothing to worry about :)
> 
> 

To expand on that, git does a so called 3-way merge. This means git will
look for a common base commit, and compare changes from both sides to
see which side actually made a change.

In your case, the base and the release branch both should show the old
ip, and the master side would show the new IP. This tells git that
master has changed, and not the release branch, and takes the master
side of the change, resulting the new IP to show up.

Hope this helps, Kevin.
