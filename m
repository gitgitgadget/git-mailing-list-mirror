Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9780CC433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658492065C
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t/HGF3vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgG1V2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:28:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58051 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1V2C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:28:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D150D9532;
        Tue, 28 Jul 2020 17:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D9m4KzjwYaTmQsSOoNUEG2ddTlc=; b=t/HGF3
        vsnL8B0+7ExK5M159psCLGDwV/jSGiWl7fuZgj8VU5ETv2EhsqC3HROmzQ8Uoif8
        F5NcuVawaW45Tk5HpalOuC22COlyC+OlfaX2kG8xaCHdouhdblT7AeLli0CQ9+8Q
        nEhBTlula4Pm/pZuzShWBTs6l7S/jcck66pt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dum+fp3v1HHghOAMGsVelIHbVaQmBdSb
        /6lXRVWq2LrSpQduOOuafxFcczoevi6/sorplBxskrmGyWmvl5MF5rC/St7B1Z59
        d2uFcpo49smX4EvVrryldoM5J3UfZ4TOvOJskNlCx2/KIL+8LfNWmmLbBTeIhJYd
        5c4D9qx3YnY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05286D9531;
        Tue, 28 Jul 2020 17:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41D96D952F;
        Tue, 28 Jul 2020 17:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] Typo fixes
References: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
        <20200728204804.GA94132@syl.lan>
Date:   Tue, 28 Jul 2020 14:27:57 -0700
In-Reply-To: <20200728204804.GA94132@syl.lan> (Taylor Blau's message of "Tue,
        28 Jul 2020 16:48:04 -0400")
Message-ID: <xmqqft9bcote.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35A8A122-D119-11EA-9E87-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jul 28, 2020 at 08:45:37PM +0000, Elijah Newren via GitGitGadget wrote:
>> Fix some simple typos: doubled words, and character swapping
>
> Far be it from me--since I seem to always be making these mistakes
> myself--to be an authoritative reviewer on this series, but it looks
> obviously good to me ;-).

Yeah, I am guilty of making many of these, but the fixes all looked
good.

Thanks.
