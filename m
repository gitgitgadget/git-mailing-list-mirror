Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2B220248
	for <e@80x24.org>; Wed,  6 Mar 2019 21:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfCFV7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 16:59:52 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58594 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFV7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 16:59:52 -0500
X-Greylist: delayed 1751 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2019 16:59:51 EST
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1h1e7V-0000hc-Uz; Thu, 07 Mar 2019 06:30:33 +0900
Date:   Thu, 7 Mar 2019 06:30:33 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org
Subject: Re: "Give me a break"... well, you gave me one
Message-ID: <20190306213033.6vadunuwrj372dzf@glandium.org>
References: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 03:14:11PM +0100, Johannes Schindelin wrote:
> Hi Stefan,
> 
> just wanted to express my gratitude for your idea to introduce the `break`
> command in `git rebase -i`'s todo list. I use it *all* the time now.

+1. Before that, I was using `x bash`, and ended up doing `git rebase
--continue` in that shell in many cases, which didn't end up so well
when I terminated said shell (just an error message, though, nothing
actually broke as a consequence). This feature is a blessing.

Mike
