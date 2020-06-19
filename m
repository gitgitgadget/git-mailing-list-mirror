Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E388C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DDB20DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HKyKwANM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbgFSRNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:13:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53558 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbgFSRNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:13:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94F0BC8071;
        Fri, 19 Jun 2020 13:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7CendMryCFmv+/oFPQ5ek0w5zbs=; b=HKyKwANM4ztidGtE9cMu
        F1MBsMIlnvJ8xtMmzYRBPCha4MDnipS9KiBotE984IqPPvCCXsBbfw7Iy6Z8FJ4B
        edSg7Z75mCGOLDzVgz7cQC5VmVl34v/GaowIcsY386voXinUV4fZZsxNhOgD8QtZ
        duiFc2QA5Lnm37t4QilEMuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=HNTPC6JfpexXUChipi9xlbDtzstX10m0UdQdZlSTjoxBzB
        jTO9r8TVGsWP1f22ckjVaeUdxDl+V6AzRXb7bEoDXf2cpmMzAYGoDmpG0vU2VT0h
        AX2NOTcZ/hZZwmK95V+i+/900J/edXJPLwra9PopT8xEo2/0RFliRUtcY+VEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BF57C8070;
        Fri, 19 Jun 2020 13:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B42D8C8069;
        Fri, 19 Jun 2020 13:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bogus error from git log --full-diff
References: <87h7v7xf1n.fsf@igel.home> <585541592583234@mail.yandex.ru>
Date:   Fri, 19 Jun 2020 10:13:12 -0700
Message-ID: <xmqqmu4zhtcn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28A985FA-B250-11EA-B891-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

> I've reported this issue in February on this very list and didn't
> get any reaction from developers.  Seems like it's not considered
> to be a bug.

Please do not read too much into lack of response.  It may be caused
by many things, including (certainly non-exhaustive):

 (1) the message may have been un-understandable and/or did not look
     interesting enough to ask for clarifications and more info to
     produce a useful response,

 (2) the message may have been delivered in a hostile tone that
     people chose to ignore even though it raised a valid issue, or

 (3) the message was simply missed because everybody was busy doing
     other things.

By default, everybody should assume the last one.  Re-raising the
issue after some cooling-off period would be a good strategy.

Thanks.

