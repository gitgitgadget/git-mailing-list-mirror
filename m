Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36425C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D363F2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="XEpdXLG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHXVLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXVLg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 17:11:36 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC5C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 14:11:36 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1598303489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=erpyrmfAOxUFC6/52n2SKlYpk5ZgnYcck4C1EyZzspc=;
        b=XEpdXLG+lVHGt94Tk5/4M0pDmLZQKak4bz6fu/EYA9gX9YlnY3KF+2ABENUSpkOOssFuR/
        AGqBXbQA30s1OWQEH84/IQDGdq4C3YUGaj+RMhtwxEvBUDOe1KvfuBO28wNkW76z0Uqqu3
        Vzae0pbD0Jm8r7qpBM3lvWFuPoNIt6s=
Content-Type: text/plain; charset=UTF-8
Cc:     "Thomas Sullivan" <tom@msbit.com.au>, <git@vger.kernel.org>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     <phillip.wood@dunelm.org.uk>, <phillip.wood@dunelm.org.uk>,
        "Junio C Hamano" <gitster@pobox.com>
Date:   Mon, 24 Aug 2020 17:03:48 -0400
Message-Id: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
In-Reply-To: <fe21c773-341c-d029-077c-00daeb6014f7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Aug 24, 2020 at 1:28 PM EDT, Phillip Wood wrote:
> The patch I was referring to is 2c8bd8471a ("checkout -p: handle new
> files correctly", 2020-05-27)
>
> I tested seen at 3981657b13 ("Merge branch 'rp/apply-cached-doc' into
> seen", 2020-08-21). I was using the C version of 'add -p' which is
> opt-in at the moment by setting add.interactive.usebuiltin=3Dtrue in your
> config (or with git -c). I hope that helps, I'm going off line now for
> 10-14 days

Indeed, this works and restores my workflow (although it errors out if I
don't manually edit the range information, which isn't necessary with
diffs to existing files). It's a bit unsatisfying as it stands, but
perhaps there are patches I can write.

No need to reply, enjoy your vacation!
