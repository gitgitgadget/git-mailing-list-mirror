Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DADEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 22:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjF1WvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjF1Wuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 18:50:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CE359B
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 15:47:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9BB0272FE;
        Wed, 28 Jun 2023 18:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCWMRAhbRIqkJ4z7JltvkePz/DxKUTtsFFfgLP
        OGlGo=; b=SS4Vf/49noWvN/vTl+W2ndKmmdjKjCV5mHrxf4H9D02luZ85v4cCgr
        OXEzDwC+ZcJZUM6R1kA4kHnjQU4pF86phC2XTA/f0gcHaXPJdur+EMMtKSPm1UzR
        jyCkNv9PPoeDXlSUH49HtEJD+h/OFvs2Nxw+atx3Qo5b6IABOqsjU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E260B272FD;
        Wed, 28 Jun 2023 18:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1484F272FC;
        Wed, 28 Jun 2023 18:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: cw/header-compat-util-shuffle (was Re: What's cooking in
 git.git (Jun 2023, #07; Tue, 27))
References: <xmqqcz1gftdn.fsf@gitster.g>
        <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqbkgzcnao.fsf@gitster.g>
        <kl6ledlvqo94.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqilb7b4mp.fsf@gitster.g>
Date:   Wed, 28 Jun 2023 15:47:32 -0700
In-Reply-To: <xmqqilb7b4mp.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        28 Jun 2023 15:31:42 -0700")
Message-ID: <xmqqedlvb3wb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5023EA8-1605-11EE-90EF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If the topic is too disruptive, however, they may have to synthesize
> a good base (i.e. "merge on top of 'master' topics A, B and C, and
> then queue these patches") but it may not be possible (e.g. among
> the topics it interacts with, some topic may not yet be stable to
> build on), in which case they must catch up quickly every time these
> other topics it depends on are updated to avoid being left behind.
>
> If the contributor cannot afford the time for quicker turnaround
> that way, it would very much help everybody to announce that they
> tentatively withdraw the topic until the other topics get more
> stable, after which time they will send an updated version.  It
> will help everybody, including those who want to build on top of
> what the series adds.

Oh, another thing.  Such a contributor who is blocked by topics by
others can help their own series by helping these other topics get
polished, i.e. with additional reviews, additional test reports,
etc.

