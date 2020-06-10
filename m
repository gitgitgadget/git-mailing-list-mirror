Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6ADC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 08:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874E32072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 08:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFJIvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:51:47 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60017 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJIvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 04:51:47 -0400
X-Originating-IP: 157.36.186.167
Received: from localhost (unknown [157.36.186.167])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4835A2000A;
        Wed, 10 Jun 2020 08:51:43 +0000 (UTC)
Date:   Wed, 10 Jun 2020 14:21:39 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Luigi Cantoni <luigic@fgcint.com>
Cc:     git@vger.kernel.org
Subject: Re: Auto Rescan - as plain text
Message-ID: <20200610085139.l5sh3w4kwfwkxmfy@yadavpratyush.com>
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
 <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
 <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
 <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luigi,

On 10/06/20 08:09AM, Luigi Cantoni wrote:
> Hi All,
> I have been using git for several years now and using git-cola.
> I just started up git gui and that is quite self explanatory and all
> the functions I use with git-cola appear to be there.
> 
> One thing I liked in git-cola was that it very quickly reflected my
> changes in its display window.
> I have looked in the options and I cannot see either a flag to set it
> to auto rescan or set a time for the auto rescan.

I proposed a patch for it some time back [0] and there was quite a 
lengthy discussion on the topic. I proposed rescanning every time the 
git-gui window came back into focus. But people had performance 
concerns. One person reported that a rescan took 8 seconds on their 
corporate Windows laptop (in my very limited experience using Git on 
Windows, I observed it is generally quite a bit slower than on Linux).

You can read through the linked thread to see the full discussion. In 
the end I dropped it because I couldn't find a reasonable compromise.
 
> Have I missed it and there is a way turn this on or give it a shorter
> time (if in fact it is does do it).
> If it is not offered could it become an option.

It might be worth looking into putting the automatic rescan behind a 
config option that is disabled by default so only people who really want 
it and know it won't hurt their workflow can use it, and it stays off 
for the rest of them. I dunno.

> I can see that some people may not feel the overhead for distributed
> system is worth having this on so they would want if off.
> It is not critical (just nice) as I know I can
> 1) rescan
> or 2) go off the file and back on again.
> It then displays the correct diff/updated contents.
> 
> Thanks for any advise or help.

[0] https://lore.kernel.org/git/20190728151726.9188-1-me@yadavpratyush.com/T/#u

-- 
Regards,
Pratyush Yadav
