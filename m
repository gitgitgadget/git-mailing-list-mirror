Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E7C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942093AbcJFPy0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 11:54:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56747 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942069AbcJFPyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 11:54:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76D4B42AED;
        Thu,  6 Oct 2016 11:54:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZQ9ho4MDjbu2ZQpSqarmh1DEO6w=; b=Xmp7LF
        s5yTB5v/ose12cb6XFzcOaqOVFYLO/cc9C7LKAyVkRHRCMZpkpcXqIX7pEJQfo4k
        XZ0O2kWZ6hC6DtRi6Dxg0YOb8V3Zs+EJPVvdTtHUHAxj+r0VV9FEIETsG+NGCAcm
        cb7nj22+MHaq+V4SFiDeXv1TlXWV9fZDc/8WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wj/G8XcS9JIZJgmnyLuNoaGj0JyhM3wW
        axs+wGh5dggfctoD7HR+5LY4C9Y08CX9/rTKH2p8Z+0vOaMN5kJVBSwntNT2waM9
        HzMXZVaa3RgyEifjzkdb22wEUdfC7dwwadVFa8HLW/cEKArHJQp5FK9x1IRB/qIN
        l/bA/rhgmW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E12442AEB;
        Thu,  6 Oct 2016 11:54:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD58942AE9;
        Thu,  6 Oct 2016 11:54:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Josef Ridky <jridky@redhat.com>, git@vger.kernel.org
Subject: Re: Feature Request: user defined suffix for temp files created by git-mergetool
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
        <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
        <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
Date:   Thu, 06 Oct 2016 08:54:21 -0700
In-Reply-To: <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org> (Johannes Sixt's
        message of "Wed, 5 Oct 2016 23:04:17 +0200")
Message-ID: <xmqqfuo9mq1e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26601216-8BDD-11E6-B999-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Therefore, I think that your patch as written does not help to reduce
> the confusion. It may be a building block for further improvement, but
> if you stop here, it is pointless.

Yup, you're right.

