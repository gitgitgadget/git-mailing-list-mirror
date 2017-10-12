Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E897820437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbdJLLFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:05:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753246AbdJLLFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 07:05:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7470E97761;
        Thu, 12 Oct 2017 07:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w3Mq6WL5U76uJqlB/r6caRvLEno=; b=kbO59j
        Uj26YYTESEqtR2L/JAM/lKiEAFyd3ZBumnNvT9XqNWw3Pu7eCzGcYkunCopPs1jl
        Gmgvvz/z8caYJZSge2sZx9qHZjESrRTH52Ie1sppbcjNU7bZe0ZlsMkdG2KTWyWO
        dbBU0SPWF8aqJQ67EZiMHNnH4kNzB9YZStsBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vSJHikZeexdKPnYJTAujJ9QebXVHaw1T
        OflfwvxDIluoNPYgzonuzTfNSBu18PN7zh6rC4Gc8/N2Xj7gzPJS3sgk0zlQxzK/
        G/ATIBOyDKXoKbUQARo+xQz2JdbQqOgv/eIIBoyWFfSrFtoRi41kWc6JDwAs8vCD
        jxtDkozaAX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D94297760;
        Thu, 12 Oct 2017 07:05:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE9339775F;
        Thu, 12 Oct 2017 07:05:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/merge-options.txt: Add -S/--gpg-sign
References: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
Date:   Thu, 12 Oct 2017 20:05:19 +0900
In-Reply-To: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
        (W. Trevor King's message of "Thu, 12 Oct 2017 02:02:17 -0700")
Message-ID: <xmqqbmlczkwg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CFE491E-AF3D-11E7-A6D0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Makes sense. Will queue.
