Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE3120450
	for <e@80x24.org>; Wed,  1 Nov 2017 05:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdKAFOo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 01:14:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59032 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbdKAFOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 01:14:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BA8ABB777;
        Wed,  1 Nov 2017 01:14:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MMkgsjVL4MdRY3Eqe+P4NSeUKts=; b=RLtwN8
        kM+EVDNBGhw+//Q74tuX8IZhjXHyaYMPw8PoRCEkeUOD9ntwYOAA5FhiRXQpnkTB
        3qxPGHV2gbtTgkSpFpslQ7BppEvA/27V9y5oMwu7StfjqcqzaX4HGfG6uCBVKfbj
        PDUnIkqtvwR9pjlZ3VafRnBaDoWqILCYJJ8lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bL59T25Mww8dIq1S9+Y5mFiNbNBE8tNn
        Ic6nUuh4B0/6fNPm4Dmg3Uve2K2L/cR5PxbngekI69iTUO9Lz/L9hzq64ftqv4b3
        JxswNSdUQ2nUOwzr/oxBGtkSxyc4SvE195HwS4mywG9flWn1I062rBJTdp6NoJQB
        oy6cppBdITw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6175DBB776;
        Wed,  1 Nov 2017 01:14:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEF73BB775;
        Wed,  1 Nov 2017 01:14:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 0/7] git describe blob
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
Date:   Wed, 01 Nov 2017 14:14:41 +0900
In-Reply-To: <20171031211852.13001-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 31 Oct 2017 14:18:45 -0700")
Message-ID: <xmqqzi86twam.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 919757BE-BEC3-11E7-9ECF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Occasionally a user is given an object hash from a blob as an error message
> or other output (e.g. [1]).
>
> It would be useful to get a further description of such a blob, such as
> the (commit, path) tuple where this blob was introduced.
>
> This implements the answer in builtin/describe,
> however the heuristics are weak. See patch 6 for details.

Overall this was a relatively pleasant read.  Will queue.

Thanks.
