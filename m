Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC380C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FCA207D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESTOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 15:14:02 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:52912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgESTOC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 15:14:02 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2020 15:14:01 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id DB61F18019B01
        for <git@vger.kernel.org>; Tue, 19 May 2020 19:06:48 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4C1A9182CED28;
        Tue, 19 May 2020 19:06:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cave79_0e050da26d0f
X-Filterd-Recvd-Size: 1827
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:06:46 +0000 (UTC)
Message-ID: <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
Subject: Re: git-send-email: Ability to populate CC using more tags
From:   Joe Perches <joe@perches.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gitster@pobox.com
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Tue, 19 May 2020 12:06:45 -0700
In-Reply-To: <20200519184041.GB4397@Mani-XPS-13-9360>
References: <20200519184041.GB4397@Mani-XPS-13-9360>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-05-20 at 00:10 +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> Currently 'git-send-email' lacks the ability to CC people described using
> tags such as Acked-by and Reported-by etc...
> 
> While doing a bit of googling, I found a patch from Joe [1] but that doesn't
> look like made its way. And in that discussion I didn't see any real objections
> for the patch intention apart from the usage of the term 'trailers'.
> 
> So I'm just curious if Joe or anyone has plan to resubmit it! If not I may
> do that.
> 
> PS: 'bylines' as mentioned by Joe seems reasonable to me.
> 
> Thanks,
> Mani
> 
> [1] https://lkml.org/lkml/2016/8/30/650

You need to use the "--misc-by" option.

Perhaps you need to update your git version
as that was added with:

commit ef0cc1df90f6b6c2987ab2db8e0ccf2cfc421edf
Author: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Tue Oct 16 09:39:23 2018 +0200

send-email: also pick up cc addresses from -by trailers


