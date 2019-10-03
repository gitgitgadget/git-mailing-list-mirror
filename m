Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852D11F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfJCWbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:31:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56773 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfJCWbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:31:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4758D93FD4;
        Thu,  3 Oct 2019 18:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zg8593iPNnp8
        79IaF4YvcgyLMlg=; b=KSWqqi6LkPC7b0IFEW4s7JHj4GcWXVBxj1Md7o0Gthcp
        Sx/3y22L+nEjvn6CWZtLQnk8rACWaXnCSaBBYJLVZQQiPoGCtvEKT6CAmCF/7arV
        wCdmaloJU/N924BdqxkfoadG8jWNedcxFBIbNFLvTvVlKd73Ql2SM32f14Qhw1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cICHxC
        pUBL8F2j+YWFKkdCI1t+er5nVUigx35m8YLtWt/FMVvX8NSM1vgjttZi0ct5+Kzq
        IrLrP1HRYvYrgnAgyp7t9V6kiPfhaoGvklmwEW2T7I2m222/fm3djBJSwr1wH1HW
        +7HCyJ3hvXjguHm0TOR92LVJpkkzzZeDmu/dM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3308793FD3;
        Thu,  3 Oct 2019 18:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2610093FD2;
        Thu,  3 Oct 2019 18:31:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHvzyLf=Wwhv45qKdKjiTVwHtsMdfA0hd5Ejf5fmhHyPg@mail.gmail.com>
Date:   Fri, 04 Oct 2019 07:31:39 +0900
In-Reply-To: <CABPp-BHvzyLf=Wwhv45qKdKjiTVwHtsMdfA0hd5Ejf5fmhHyPg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Oct 2019 13:28:01 -0700")
Message-ID: <xmqq7e5lbgvo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92C36BC6-E62D-11E9-AAF3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Actually, Ren=C3=A9 posted a code cleanup suggestion for patch 2/8, so =
I
> sent a V3 re-roll[1].  Could you pick up V3 instead of merging V2 down
> to next?
>
> [1] https://public-inbox.org/git/20191003202709.26279-1-newren@gmail.co=
m/

Thanks for stopping me.

Will take a look.
