Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A871F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbcIITXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:23:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753232AbcIITXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8620339A05;
        Fri,  9 Sep 2016 15:23:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bNjzwcGRsn3SiVvV2qQjK4cvjDs=; b=UyjieO
        gYKEqHQ10sFKeIhrurbY9MV1CSZi9NYqMgBNTdm150XuCgjyRB9ELz/794QrvkAe
        O/1I/Vy/TcTp6HbDAkQ+PihgNpcNvxMW4GCn4WY90m2xTbB/AorvJlvOAIIAijQK
        dt0qquCPVn1aSYxYkjWz+UO9oH/rlPv6+6ddc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bR2E4OF3LUdZ/LBFTXp+qvtwml6U8mev
        udeP1qfH4Frs1CcDbu0XUwZDfDKHxzEklOzTb3f/1B1yU1vHdmPX7GeAIBhLuY3v
        ddjW7DxdRM+ISk9I6moko57FB15L8i/JV8rksBSmMw5Y4JGTLdRmTxI8todcrg4E
        bGcBESGWPpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D5E939A04;
        Fri,  9 Sep 2016 15:23:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02A6539A03;
        Fri,  9 Sep 2016 15:23:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 07/13] i18n: merge-recursive: mark error messages for translation
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
        <1473259758-11836-7-git-send-email-vascomalmeida@sapo.pt>
Date:   Fri, 09 Sep 2016 12:23:12 -0700
In-Reply-To: <1473259758-11836-7-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 7 Sep 2016 14:49:11 +0000")
Message-ID: <xmqqbmzwc1y7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA572DDE-76C2-11E6-9A69-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Lowercase first word of such error messages following the usual style.

"Change X to lowercase" is fine, but "Lowercase" is not a verb.

I'd reword it to "Downcase the first word...".

Other than that all 04-13/13 looked fine to me.

Thanks.
