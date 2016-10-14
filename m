Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005BD1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbcJNRFA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:05:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59031 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932631AbcJNRE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:04:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92F274503B;
        Fri, 14 Oct 2016 13:04:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vJ8LAMm44rwROsfbrBK692gWSOg=; b=Sr+j61
        vhnTliR6Sl478wy4ccZRxeB8yOe13azKYjzfz2BtHhSGP8LO2RAywpWqWFD/dQj5
        GY7Pqn5wsLRLGnkZm8me/4QhLqgIgTMYauZMsXdWn9hckfsWtIBDWr+lhJ/e6U7b
        VtivvgUQlZXVya4yrlG6N9iUzR6nRiVsx8UaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+omLnrfXrbI8RJrVGC3Mq/5jVzMv1ZA
        5bPZDYvCgAOGm6MY7PyXdp1MiyGo2/0Rzq1riXnD89Qb66fSs/I7NrtEmsyB880w
        e26FticvvoSywSzVoUNfJvu9FztIbjmL86z9Fguolhpj+cHQz4unS3wjDB9W0KcC
        1y408jPhhhY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9B94503A;
        Fri, 14 Oct 2016 13:04:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06C4D45038;
        Fri, 14 Oct 2016 13:04:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
        <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
        <vpq8tttr2ps.fsf@anie.imag.fr>
        <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
        <vpq1szkolud.fsf@anie.imag.fr>
Date:   Fri, 14 Oct 2016 10:04:49 -0700
In-Reply-To: <vpq1szkolud.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
        13 Oct 2016 07:32:26 +0200")
Message-ID: <xmqqk2dazwsu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51DF5CEA-9230-11E6-A0E3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> We clearly can't guess, but we can be consistent with Mail::Address, so
> that git's behavior depends less on its availability.
>
> Patch follows doing that.

Thanks.  I love that somebody counters with a much better way to
solve it whenever I suggest an outrageous non-solution to a problem
around here ;-)
