Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4695020323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdCPS5i (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:57:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751979AbdCPS5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:57:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6118885764;
        Thu, 16 Mar 2017 14:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V8ySMY0QErj5TvUx+bdlwxi+NwY=; b=b/5Mlg
        QhHavt1gsCphE/0AuynAXxVM9erVk+QC5S4X2WAWUYo9Kz7h8ta+Edr0W9HH4ROL
        AgdLFEI8xmUMw1Gj71oAdfISUc0HTv4TV2MGwsgm/G6oT6fPIP1XLoYHxWcjkr3r
        EBmOfZC+levNcsaWnBO6dIi8c+OpWxrCiMY/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GXWGOpl+eViOL5/7QqFdNHVmhl6yUU5F
        F/ORcp6N/XrdFT2xgnAji+uyu0Dx8XVuK9a04/CGR6lkPK2bpik4AFqplT63+An7
        P1v0xSvOVCgxXVAgsxaLKbWtizYQg3NOa8iswT5sotHigvmVRZVZjls+jrQnsggD
        cWY/PLUjXLs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58D4A85763;
        Thu, 16 Mar 2017 14:57:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4CA785760;
        Thu, 16 Mar 2017 14:57:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 4/5] replace snprintf with odb_pack_name()
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
        <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
        <xmqqvar9ax6n.fsf@gitster.mtv.corp.google.com>
        <20170316183444.t4mjdd7saobn2ut2@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 11:57:08 -0700
In-Reply-To: <20170316183444.t4mjdd7saobn2ut2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 14:34:45 -0400")
Message-ID: <xmqqk27paw3f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B9F39EA-0A7A-11E7-B391-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> so that we can always use name.buf without having to do "?:" thing.
>
> See the next patch. :)

Nice ;-)  Thanks, queued the whole thing.
