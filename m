Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8213820966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934900AbdC3UL6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:11:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59253 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934773AbdC3UL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:11:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0147F6DE0B;
        Thu, 30 Mar 2017 16:11:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=++8ztDXXkFBkAQLD1aBK6Ayac7o=; b=TDibV7
        VANRELv9UoqVqualotrWsr6sEhLrVfLN7Y8IrhsaoDp2GkgtKPeqZCkHE9gCRIP+
        VU0mzo87KtoWr43u9spoAlKTDLgFzC7G3lGEkMB9yqxK5Fbm/tvpM6n+WKN3W5C4
        MehPyUk+mGST/L4+O/h0vWY9+lSL7cJOxuWSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f3+7I+DZnRWbPTeb7Eq7D4hC1nv/7LP/
        21lssAKxL38bNUDs/cSSOU3ePSyJKlF/rmQW4ssWEnUeIfejSuZjTmnWmo3TQsKL
        bGVwAJSqVifHXuhsshIIyWbSUOse3CCA8tR2ZFtepnZmT6+dlF3L99qdOuD8wYAU
        fF4QRO/oVS4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC3CB6DE09;
        Thu, 30 Mar 2017 16:11:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52A856DE06;
        Thu, 30 Mar 2017 16:11:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v4 0/8] refactor the filter process code into a reusable module
References: <20170330155417.8928-1-benpeart@microsoft.com>
Date:   Thu, 30 Mar 2017 13:11:53 -0700
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 30 Mar 2017 11:54:08 -0400")
Message-ID: <xmqqpogy34om.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E788556-1585-11E7-929D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now 1 & 2 are as equally pleasant to read as others ;-).

Let's wait for a few days and then merge to 'next'.  I didn't see
anything questionable.

Thanks.
