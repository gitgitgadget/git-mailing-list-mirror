Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B926A1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030306AbcHaQYW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 12:24:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59827 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935318AbcHaQWy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 12:22:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4BB438733;
        Wed, 31 Aug 2016 12:22:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bsOgEZAQp1PaACyuZ60cORUJX84=; b=QV7n58
        MZteaAQ/OwlybhFa1v4QLj2PT/tqpKI7t5SNolda0O/FDeFUrH0KjD/Sr2smgiDD
        OloANnd48oKLHDLXe6sOypMUnbvMxcSzNfaz35a2yETwB3RrxQ8U3efuX7A6Fee8
        5v9JmF536DrjhTKIHoaeXo16Jd4GCUFxX3mFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cv2hfUfIOUPrYdnJWXTwnHgRuDD3Kroh
        ecx10tiWfIQjiEGdATyLyZGLK5S6zIhLlp1Z0dyaTTBGchGbtInCtdxbI7RrKzQh
        JG2kt3mpkBEtCfGgav2ZUVPb7+8Tkk2YdauZ7GNLE2pBk8Hjd8Hpbwn1g40qrfa1
        Ho9R3PYyXwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD3D38732;
        Wed, 31 Aug 2016 12:22:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 247BB38731;
        Wed, 31 Aug 2016 12:22:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH v6 00/12] Update git revisions
References: <20160811215035.4108-1-philipoakley@iee.org>
        <20160812234522.7792-1-philipoakley@iee.org>
Date:   Wed, 31 Aug 2016 09:22:50 -0700
In-Reply-To: <20160812234522.7792-1-philipoakley@iee.org> (Philip Oakley's
        message of "Sat, 13 Aug 2016 00:45:18 +0100")
Message-ID: <xmqqbn083o2t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE30D64-6F97-11E6-804D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> These are the quick fixes to Marc's comments to patches 5,6,11,
> and a consequential change to 12.
>
> Only the changed patches are included.

I gave a cursory re-read on the whole thing again, and spotted no
further issue.  This has been kept in the "Undecided" pile, but I'll
mark it as "Will merge to 'next'" and hope to have it in 'master'
early in the post 2.10 cycle.

Thanks.
