Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933661FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756351AbeAHUme (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:42:34 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53887 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755198AbeAHUmd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 15:42:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 43C7820D41;
        Mon,  8 Jan 2018 15:42:33 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute3.internal (MEProxy); Mon, 08 Jan 2018 15:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hgeTmj
        s3ub+Jn5YyNfkoDwcpOv7qVmQz97EVjDqQhUs=; b=JvtFUEHiyeSLsxHFV4GJOq
        nHv1DSTh6I3RT6iKdNz69DfLIaNoxHTYFnHWKeYm6Lg31dN7Hl+iQEe65OFerXoP
        L9nXHtrZqS+CgkcMUM4of9KSko21HObsR14wbi2NHL6DEw3EhgRhBTjmZ7Fm5Cgy
        bCCHFwY3ctOPZRR2lW+7R4neh8+FXWtLVnP3n3sytezfwKpuyJSZbNFdIh/+JVbs
        bkYn2iLwlA6c0wZ9QuA/YCcv1ms4Pp/Xc+ffP+MpI/T9XT4jfm2Qhi2xQ0GlpcJ5
        pDzEXyC1OzF7MWUmI87mAma04ze7zsMNdavG71JszkuFIyMoHrQqYAR/jPXQlwCA
        ==
X-ME-Sender: <xms:uddTWqZd_iPPvJ58snqxbA3goam4wdatX6IFqceGOMdr5yas6EKR6Q>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 219F0BA1AC; Mon,  8 Jan 2018 15:42:33 -0500 (EST)
Message-Id: <1515444153.3249266.1228432904.51A92479@webmail.messagingengine.com>
From:   Colin Walters <walters@verbum.org>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-6368b27c
In-Reply-To: <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
Date:   Mon, 08 Jan 2018 15:42:33 -0500
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, Jan 8, 2018, at 3:40 PM, Santiago Torres wrote:
> Hi,
> 
> I personally like the idea of git-evtags, but I feel that they could be
> made so that push certificates (and being hash-algorithm agnostic)
> should provide the same functionality with less code.

What's a "push certificate"?  (I really tried to find it in Google,
even going to page 4 where one can start to see tumbleweeds
going by... I'm fairly certain you're not talking about something related
to iOS notifications) 
