Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B4C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 08:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756352072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 08:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgFJI7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:59:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59447 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgFJI7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 04:59:11 -0400
X-Originating-IP: 157.36.186.167
Received: from localhost (unknown [157.36.186.167])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D72B320009;
        Wed, 10 Jun 2020 08:59:05 +0000 (UTC)
Date:   Wed, 10 Jun 2020 14:29:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luigi Cantoni <luigic@fgcint.com>,
        David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Subject: Re: Auto Rescan - as plain text
Message-ID: <20200610085902.uv7cxl6s5qnlniwm@yadavpratyush.com>
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
 <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
 <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
 <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
 <xmqq3673hj11.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3673hj11.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/06/20 05:16PM, Junio C Hamano wrote:
> Luigi Cantoni <luigic@fgcint.com> writes:
> 
> > Hi All,
> > I have been using git for several years now and using git-cola.
> > I just started up git gui and that is quite self explanatory and all
> > the functions I use with git-cola appear to be there.
> 
> We used to see the maintainer of that project around here quite
> frequently but haven't seen him for a while [jch: David Cc'ed].
> 
> By reading https://git-cola.github.io/about.html it seems that they
> prefer to see problem reports and feature requests at
> https://github.com/git-cola/git-cola/issues and not on this list.

The feature request is for git-gui, asking for auto rescan in git-gui 
like git-cola has. So I think this is the right place for it. Though I 
think its easy to miss that on a quick read of the email. I had to do a 
double take too :-)
 
> > One thing I liked in git-cola was that it very quickly reflected my
> > changes in its display window.
> > I have looked in the options and I cannot see either a flag to set it
> > to auto rescan or set a time for the auto rescan.
> >
> > Have I missed it and there is a way turn this on or give it a shorter
> > time (if in fact it is does do it).
> > If it is not offered could it become an option.
> > I can see that some people may not feel the overhead for distributed
> > system is worth having this on so they would want if off.
> > It is not critical (just nice) as I know I can
> > 1) rescan
> > or 2) go off the file and back on again.
> > It then displays the correct diff/updated contents.
> >
> > Thanks for any advise or help.

-- 
Regards,
Pratyush Yadav
