Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1EA1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756448AbcIYXWB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:22:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55239 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751990AbcIYXWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:22:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8F754095A;
        Sun, 25 Sep 2016 19:21:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYaCVem5zV4SMBfour8vJ9+3xQA=; b=mxQHEg
        uHYwGXc3i6BZ4pwWre39zYcYFlCmZdtnMz3O0pHdwa/qwEFk8tNmg5H8lI9f7+Qr
        Qgvz9IuvlAp8WxLF8Mybh5twPWn4jY73ZK1bK7PkcV/KR7cf/TfF/vUPcnQSD2Yd
        nF3If+8pdBUwnUVHHcP7+5GHRqPKy1z01jtDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jn//W8M7uohn4rRZd1miGktLiDv7MBJM
        ozBXbrmX4yEfQBcT6GaS3EOoFqiSAqVRjGhlcO03tfxEKeNx1bVs0mcCu8N6N2Pp
        NYRmoz3aAg8C5kdYi3cAmtZR+0Q/v8gsjjnlZ60dZFcSt7NMrX7VAH0bXPYkGVNH
        0pSqkxUodjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF6FB40959;
        Sun, 25 Sep 2016 19:21:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51A6840958;
        Sun, 25 Sep 2016 19:21:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 11/11] i18n: difftool: mark warnings for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-12-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 16:21:57 -0700
In-Reply-To: <1472646690-9699-12-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:30 +0000")
Message-ID: <xmqqtwd3wooa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB8BAA0C-8376-11E6-AF4C-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> -			warn << 'EOF';
> +			warn __ <<'EOF';
>  Combined diff formats ('-c' and '--cc') are not supported in
>  directory diff mode ('-d' and '--dir-diff').
>  EOF

Wow, didn't imagine gettext would pick this up.  Nice.

