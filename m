Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E086220989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbcJJUtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:49:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55536 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbcJJUtV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Oct 2016 16:49:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 53BF420A22;
        Mon, 10 Oct 2016 16:49:20 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Mon, 10 Oct 2016 16:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=e5gCv/zrfdXZwoHDT3xcnLoqOww=; b=CiDRtP
        JhY/Srmy1yVCwUvnuiTsQFrD970fXsPL3mXvbvyetWtVbUnv9AQO43xXyUrxGgJJ
        4CndJ2KGnU2qAPsyPEQcBNYmhAZZcB0OiQ+OMe2u+2BlaS/cx037cOITg1btQ2mT
        2y2B+NjSK0ta/CsLSzcV/zQFl12ITn6kBfez8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=e5gCv/zrfdXZwoH
        DT3xcnLoqOww=; b=FFJavddfzY8cuh1OlRWKJw/boUWRV9tgRc8wm6gs6Wy3d8y
        ypUc8ZF8vGcRiBOO9AmY0CwdC61wWt8TtTPIjRUT6/ZK+3kZ3ikg+EFvhd200SIu
        zPZZWri9hy238XsCJkvsOMT9+WCC9rkQyujDBo7dK6+Gqk8iyTSimErsN0Uc=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 283EA2EC7E; Mon, 10 Oct 2016 16:49:20 -0400 (EDT)
Message-Id: <1476132560.1716398.751654049.5C8CC9EA@webmail.messagingengine.com>
X-Sasl-Enc: 5jufFrNd7JVoRBt/v+vQPefciIVdBbmkLCPiz8bqZ+Tw 1476132560
From:   Ian Kelling <ian@iankelling.org>
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Xiaolong Ye <xiaolong.ye@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailer: MessagingEngine.com Webmail Interface - ajax-cdbff290
In-Reply-To: <CAGZ79kb2HWmaW3XpfHRj8vcOStPoQmR_NZe7RCRhw=FnnHbZ8A@mail.gmail.com>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
 <4B3747D8D2724E98B6AC000FE4072A09@black7>
 <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com>
 <AB0A757A7BE241B39C8193A633C61FED@black7>
 <CAGZ79kb2HWmaW3XpfHRj8vcOStPoQmR_NZe7RCRhw=FnnHbZ8A@mail.gmail.com>
Subject: Re: How to watch a mailing list & repo for patches which affect a
 certain area of code?
Date:   Mon, 10 Oct 2016 13:49:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016, at 12:08 PM, Stefan Beller wrote:
> Well it is found in 2.9 and later. Currently the base footer is
> opt-in, e.g. you'd
> need to convince people to run `git config format.useAutoBase true` or to
> manually add the base to the patch via `format-patch --base=<commit>`.

Nice. Another useful config option this lead me to find is git config
--global branch.autoSetupMerge always which sets up the remote for local
branches, allowing useAutoBase to work for them without extra typing
(according to the man page, I haven't tried it yet).

