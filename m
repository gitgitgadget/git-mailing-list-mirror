Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB611F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbcIGS6L (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:58:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54052 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752040AbcIGS6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:58:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD3E3C779;
        Wed,  7 Sep 2016 14:58:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l2+k+D/nBGZrooXjqyZ3bZGQQQ0=; b=HnjFA5
        39EJnmseX47Q1zlqEIp1L1Ts2QM77cp/sSuoQ22ZdgtTlOY9PNB2Yudwkv9Nf/C5
        3P40zjB92k9K6TI2Rbu3NtfSl1M+wsZ4LIK2ZpPGLUc6WofJTh3aMw/+ION9rgtu
        WXe3Qtiwz0KG5oUgGcDs+dOb/Mj2hJGnd2ZPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QSHAvSMVwBZkXTLWh7v36h8K6FR/CJid
        0ve62vB2M4pXOFRcZBH70NZYAcoWYFE4EeIDyjmabhI05M/kEnvqryC/FHGhNJA4
        MdQ/fylytTdQJG6egOYfcoOXjG99EUIoo7mgYa0TZPX4eBNIjANUcX82kSVS90B7
        grBT3p3Vj+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34D73C778;
        Wed,  7 Sep 2016 14:58:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C52C3C777;
        Wed,  7 Sep 2016 14:58:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] rebase -i: improve advice on bad instruction lines
References: <20160906180838.865-1-ralf.thielow@gmail.com>
        <20160906185918.21286-1-ralf.thielow@gmail.com>
        <1473240491.20551.1.camel@kaarsemaker.net>
Date:   Wed, 07 Sep 2016 11:58:07 -0700
In-Reply-To: <1473240491.20551.1.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Wed, 07 Sep 2016 11:28:11 +0200")
Message-ID: <xmqqr38vleps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04B8946A-752D-11E6-83DC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> There are quite a few patch series in flight these days around
> interactive rebase. Have you checked for conflicts with those?

IIRC, Ralf's fix would need to be ported to C version, and when it
happens, it won't just be a mere conflict but will disappear from
the scripted version ;-)

But the C version is not anywhere near 'pu' yet and being rerolled,
so I do not mind queuing it on 'pu' now merely as a reminder.
