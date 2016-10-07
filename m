Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364A820986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757396AbcJGQfv (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:35:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61930 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964789AbcJGQer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:34:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E916E43546;
        Fri,  7 Oct 2016 12:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/VoTwv6BAZvwncaR4LOyUYy34Mc=; b=q7DqJB
        HahEv++Fxa+gHUzwpOayDrAY3SaCElD6HF/DIDvhUeNKt5uTSL3bd7y7HonywMrb
        iqBgwwvnEJEikc/5J0zwLBW25D9iWoYL8Mqylz5Ju0sfFAWExk71X2Ar5UfsQ/m4
        j+71i6Izof/D1U0HgrsKpa6S5zi9VzUD1HrFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCy4LZQpdLXq23qiW5Q4JogeCCWJ+5RU
        EuEGMnAFx8mK3DMXZCv+tUK2sMs6zoIfk/u2gmc++xz8DbjOw1MGEXjLB5EV8vVy
        7fxQYCWeChqIkN/ULJqHwAaWIQoLfy5QPZsjafxk8WPI9y5Yr0zibxnV1STIzFG9
        Efi4N6qEBqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E03E643545;
        Fri,  7 Oct 2016 12:34:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6020743544;
        Fri,  7 Oct 2016 12:34:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Pull out require_clean_work_tree() functionality from builtin/pull.c
References: <cover.1475586229.git.johannes.schindelin@gmx.de>
        <cover.1475856491.git.johannes.schindelin@gmx.de>
Date:   Fri, 07 Oct 2016 09:34:43 -0700
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 7 Oct 2016 18:08:25 +0200 (CEST)")
Message-ID: <xmqq4m4oi0d8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4B3B2C0-8CAB-11E6-87F5-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - changed the exit code to 128 (emulating a die()) if
>   require_clean_work-tree() was asked to be non-gentle.

Ah, I didn't spot this the last round.  Good change.

Thanks, will replace.
