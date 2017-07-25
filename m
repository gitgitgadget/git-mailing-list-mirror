Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D4F1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdGYVbL (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:31:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55270 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750964AbdGYVbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:31:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C34C9702FE;
        Tue, 25 Jul 2017 17:31:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fzszgotIeUasVioNrZKcI6RWevI=; b=Vx/4A0
        J+hnvXBnN/guoDPVynngkRzAYRm/uNRmHKmq+KCJz0zMmhToTY6PNPL7mUG/ZcZA
        FdRyt7XTDb3Z7lH1BY3UJ94quAL5xL1L5+q3S+KzeK66ow9W9Wv7fH2Vm0B6WC4d
        0JI5BnSQSmSPg232u9c6IyaZHJq4Tu5zV9Ztw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m9p+7LlRV77ByrvklXNs/BzhBf6HZuR0
        48ptUTlLIBTMLnpm4qJG46kiPGcz6gBWMwGvC25QGdcqMBro911/bLo2l1sGDnN1
        sqVIEoNCfkBtPa/KUPtuzwqkI2VOHGjanE/7cBW9ux8luGMzH65HcMF1RhlOBYqW
        LsJFQLYq6gE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB9E4702FD;
        Tue, 25 Jul 2017 17:31:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EA93702FC;
        Tue, 25 Jul 2017 17:31:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: add missing values "none" and "default" for diff.wsErrorHighlight
References: <xmqqa83sbamf.fsf@gitster.mtv.corp.google.com>
        <20170725205315.12030-1-asheiduk@gmail.com>
Date:   Tue, 25 Jul 2017 14:31:02 -0700
In-Reply-To: <20170725205315.12030-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Tue, 25 Jul 2017 22:53:15 +0200")
Message-ID: <xmqqo9s8td9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FDC0F86-7180-11E7-A425-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> The values have eluded documentation so far. While at it streamline
> the wording by grouping relevant parts together.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/diff-config.txt  | 11 +++++++----
>  Documentation/diff-options.txt | 17 ++++++++---------
>  2 files changed, 15 insertions(+), 13 deletions(-)

Looks sensible; thanks.  Will queue.
