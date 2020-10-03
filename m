Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814BC4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2157E206DB
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="rD+v6hPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJCJUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 05:20:20 -0400
Received: from ozlabs.org ([203.11.71.1]:41509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgJCJUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 05:20:19 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4C3LtS71SKz9sTt; Sat,  3 Oct 2020 19:20:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1601716816; bh=JgQ8WmZ0jV8oktJt2iZFJzqmlFi+mzJDXAA8FnRULQA=;
        h=Date:From:To:Cc:Subject:From;
        b=rD+v6hPoKhkC4PwY78mGAXDgxrqRxL8g1Fgo3/EqZlVnL+uS5dfytXv25ZpvJ9aSy
         lvQBRa3iBtNXI4mJIz9HtFXo5hqm8Hdl/0A/VdfUU57VjTG4ExjcVDYsvzJaBCLmQ9
         zKP5UpRk/jO90rT1PYicn4wfjwhRiauvk566Z8veriD8DovX3hCqKtthPdvcvyT1F6
         9zloKhUVrUHMiZ6lxlrXT4fP4dEulhsj5sxC4iXQTTaBRRiuzL+In1qUsLwhKDGXG2
         lvTzZob4aXyc5bVghnCWSrLGhpQh/sDNVOVYzQIS7xnHf68uK07rc/3dAieZJr63kg
         G7UGSRXuzfLJQ==
Date:   Sat, 3 Oct 2020 19:20:10 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] gitk update
Message-ID: <20201003092010.GC3089868@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Whenever it's convenient for you, please do a pull from my gitk
repository at git://ozlabs.org/~paulus/gitk.git to get 6 commits
updating gitk.

Thanks,
Paul.
