Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB24207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 19:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbcJCTbU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 15:31:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55108 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751599AbcJCTbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 15:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1400742E39;
        Mon,  3 Oct 2016 15:31:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FEryM2IIqINFf7AYCPQxiN7QIME=; b=eaEZSl
        667iSdS+fJWyoDe1txQjsc7f4dfHpjUvgQdnjsmvbkZ7xoAtXIcGknMdbodSxa11
        1eG70CGmgjXWtQVoVGNjQ1brE+9CAQ16OZsyl2yDz9Te6xWLIahFsY+LpvnNRp34
        CGi6tIX1keOwV26itQz5axFlGIVXeAc/xCkdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r9uUOnHHSgSgL8y5xQVrKf3wJppPd4jo
        kWp770VZ7gsAgLgobSZ5Kq/QJB36tSyVhbesYkZOxa73lNPQAlsT2dp5m/R/mLWC
        iSUicc7r5WiBgu2RHDBDVSujLcZoXlvspDwUUdYOdJQ+77T1rU+jVQdUv3Zvh7FI
        qS4VBDuSEUk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AACF42E38;
        Mon,  3 Oct 2016 15:31:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8623942E37;
        Mon,  3 Oct 2016 15:31:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     "Satoshi Yasushima" <s.yasushima@gmail.com>, <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
        <87int9x1lp.fsf@red.patthoyts.tk>
        <xmqq60p98kym.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 03 Oct 2016 12:31:15 -0700
In-Reply-To: <xmqq60p98kym.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 03 Oct 2016 09:18:41 -0700")
Message-ID: <xmqq7f9p6xh8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F477175C-899F-11E6-8A25-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> I'm just starting to catch up once again. hopefully I can be
>> a bit more reactive than recently. Merging 52285c83 looks fine. I'll
>> stick that onto the 0.20.0 head and see what else I can pick up on top.
>> There are a few from the git for windows set among others.
>
> Nice to hear from you again.  I think I have a few topics I merged
> to my tree bypassing you in the meantime. Let me get back to you
> with a list of topic tips to bring your tree in sync with what I
> have later.

I think the following lists everything that has been done bypassing
your tree:

66fe3e061a ("git-gui: l10n: add Portuguese translation", 2016-05-06)
52285c8312 ("git-gui: update Japanese information", 2016-09-07)
2afe6b733e ("git-gui: respect commit.gpgsign again", 2016-09-09)
b5f325cb4a ("git-gui: stop using deprecated merge syntax", 2016-09-24)

52285c8312 and 2afe6b733e are already in my 'master'; the other two
are already cooking in 'next'.

So if you fetch from me and merge the above, you'd be in sync with
me (I won't be in sync with you, as you would have more than I have
from other places like Git for Windows set).

Thanks.
