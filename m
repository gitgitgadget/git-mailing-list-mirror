Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801FB1FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755672AbdJJIsR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 04:48:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755165AbdJJIsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 04:48:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DACB9925A7;
        Tue, 10 Oct 2017 04:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qza4CDkmYAnPo3pfVRvjwM1Qnxg=; b=QkrUWs
        TDYtBEt6lxBdNkFuQqNkTFOTEQ8/Wn9/pkrLnQfEnWJEbK537w0czm3AN/lpPK4O
        XlHH1q5tupMuW99HOkiviPqNqtOpiCYMJq+ckHEC9L01d7/4OiSIm7hCB7Pq6OwH
        gFA7/8GzE0ekfVcB/1V9Ysfxu7kaDVzGKAllw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C8dY7u84JpDtJymaIP5Zflp5zZCUqVWI
        d6xzpx7ys1gsYf7lOJo6gjGL2TBqSKabeQDybWIRiTkHjaI43PxHl6GfrRD/Q5Fv
        UmWO/rbiHnhVBLb020XgSbVixedNB3hgOpb7/l3Hqs7uTQ/r0dzvdFqtNnRKe0C8
        r40EIUwLFto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE6CA925A6;
        Tue, 10 Oct 2017 04:48:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CE54925A2;
        Tue, 10 Oct 2017 04:48:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        matthieu.moy@univ-lyon1.fr,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Subject: Re: [PATCH] Documentation/git-config.txt: reword missleading sentence
References: <20171005081733.18529-1-nathan.payre@etu.univ-lyon1.fr>
        <CAPc5daVKM9PXYfKb3zMmCH3F8DeGcLHNtTCLDxMogOTH8uxWzg@mail.gmail.com>
        <CAGb4CBUaQJOskTiXm0w+3V7E8kkaA5EiG1w0s39WDCVH-5AVoA@mail.gmail.com>
Date:   Tue, 10 Oct 2017 17:48:08 +0900
In-Reply-To: <CAGb4CBUaQJOskTiXm0w+3V7E8kkaA5EiG1w0s39WDCVH-5AVoA@mail.gmail.com>
        (Nathan PAYRE's message of "Tue, 10 Oct 2017 10:19:59 +0200")
Message-ID: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE50D498-AD97-11E7-9956-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathan PAYRE <second.payre@gmail.com> writes:

> Thanks you for the this complete answer,
> we take note of your comments.
>
> We would like to reword something else in the same line
> and we don't know what is the best way to do that properly.
> Should we do a [PATCH v2] or revert the last commit and
> commit a new one?

I'd imagine that it is in the same spirit of the old one
(i.e. "let's make it less confusing"), so let's have a single patch
that has both changes which is [PATCH v2].

Thanks.


