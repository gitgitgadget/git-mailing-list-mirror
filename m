Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D009B20C39
	for <e@80x24.org>; Fri,  8 Dec 2017 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdLHR6c (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:58:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752457AbdLHR6b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:58:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 641D1D21AA;
        Fri,  8 Dec 2017 12:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v679rdI9AUzVvLRHREv/QI0Haz8=; b=lUs7Tt
        roOitzh4bGGXTkNxkYfaP39FTCoCoGyK02xLCVL332hN1uicja4nlnr2J/oPo/7Z
        kHjB1acvPT8hK6h5Z83iFGrpUGVeE4BbHSl1S2Ks6tog7YScMwa9rujtWgAQWY3V
        w0zHd+vOGbLc+i/qG55OxyL9KJ3SdGjvZcv/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K0VKiymvCD+JHltAMBLoKnLOQH+lPmmo
        3GrDrDqsO3ymmeZR4b4aLvtfHnXrH774KrReOttswRBXmf+ZKr19Qn0+R1pgh2sf
        YnlPmTv4+6NtMZtTvAgEW3UJe45hNJkS3utE6tnXJ7JUaXrb9fGf6G9n/xPcPevH
        bWRjwEOxVEM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59DF3D21A9;
        Fri,  8 Dec 2017 12:58:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D30C3D21A8;
        Fri,  8 Dec 2017 12:58:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
References: <20171208155851.855-1-git@jeffhostetler.com>
Date:   Fri, 08 Dec 2017 09:58:29 -0800
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Fri, 8 Dec 2017 15:58:35 +0000")
Message-ID: <xmqqtvx185kq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6681974C-DC41-11E7-AF78-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This is V7 of part 3 of partial clone.  It builds upon V7 of part 2
> (which builds upon V6 of part 1).

Aren't the three patches at the bottom sort-of duplicate from the
part 2 series?

