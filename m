Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08873C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46CB20656
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpv0+1oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgHDAPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:15:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61841 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHDAPs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:15:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3251A7A95E;
        Mon,  3 Aug 2020 20:15:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DerqJS73XQ3v3XC+7R70+hNvU0E=; b=hpv0+1
        ojtAiiZTSEy1D8oq9UEVL+9jYh7epeHws7lAczcMetFYVS+F2PFjOUuteBgqG92u
        Ifmlagn64E6tfQl/dIr8PVX4qaVUoecF6aaJ56af9tdwDn5vfayN+zs/8N9GWCI5
        phQpTVBm/AgkFz12GQ8WEdg6a51RHbSQZ4rFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hJTOGjo2uTz1jbdSttsEPbzMNxjIj3VM
        qdetLgR0FAiBH5OBMwyQ8YWgKjl94JFE+KjzUsDHKID8+mKmF4ArkjubaHNrj/yx
        KPenUVWXShXSaAihR/DjtzeREz4/bkQXQPt2FPEAdc8CJdKIRRD0A+cJzGG1JTr+
        vJ73myxxpgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B1EF7A95D;
        Mon,  3 Aug 2020 20:15:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B23FE7A95C;
        Mon,  3 Aug 2020 20:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git-worktree documentation cleanups
References: <20200803053612.50095-1-sunshine@sunshineco.com>
        <20200803175717.7465-1-martin.agren@gmail.com>
        <CAPig+cQtcxqQDAQ5bO6ica+Z7dd2+r8B+kXm0RK7qhpsAiX_xg@mail.gmail.com>
Date:   Mon, 03 Aug 2020 17:15:45 -0700
In-Reply-To: <CAPig+cQtcxqQDAQ5bO6ica+Z7dd2+r8B+kXm0RK7qhpsAiX_xg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 3 Aug 2020 19:54:24 -0400")
Message-ID: <xmqqlfivtgem.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A436CF60-D5E7-11EA-9F4F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> In addition to the grammo you spotted, the quotes around
> worktreeConfig should be backticks.
>
> I'll think go ahead and re-roll, adding a couple new patches,
> respectively, for the linkgit:'s you pointed out and typesetting
> `HEAD` specially.

Sounds all sensible.

Thanks, all.
