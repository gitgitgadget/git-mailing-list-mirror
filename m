Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C1C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfILTrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:47:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63096 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfILTrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:47:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABC58259BF;
        Thu, 12 Sep 2019 15:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TbbxEllwzaHBUFjvfuygHXtMkmg=; b=ulOroe
        8h1OLl+Jm83lOmKPiNqsayGtJ1DFHDhha2hYhE/slBiCIV5PN4fpUGPpZzFOE17q
        dBsqsl5v1Dg2p+71/EBncAAYvBFlgWwhOG7ziuWc59y7eLaXtuQUguGMU2/+Y4WN
        n3ychkUiDeDyeKXkIEoaagZVYhXszrAhg6Gns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=owy228APXoaX3Rk9320ll2XmgeWiouF6
        lHOSdrznMd8iOKXOdTI/Sk8iE2whol1Vy475aNWPdVOf9vUd4uG1L8xXQfnhpY/L
        NQnurZXxnQ+FDG11GQkGqsAy0FI6UuPbdSwY9oYeHiZOtxCJEkLTxpjlnAutHaSX
        FBL7NV8LC+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A31E9259BE;
        Thu, 12 Sep 2019 15:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0719F259BD;
        Thu, 12 Sep 2019 15:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Max Rothman <max.r.rothman@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
        <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com>
        <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
        <CAFA_24JW_oRXB+40M2wKtEDQeC5VYjTC0D9GLEm5oa5E_dGtSg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1909121053070.47@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Sep 2019 12:47:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909121053070.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Sep 2019 10:54:15 +0200 (CEST)")
Message-ID: <xmqqpnk5fgar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BD87F4E-D596-11E9-BD0E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Max,
>
> The patch looks good to me!

Thanks, both.  Will queue.
