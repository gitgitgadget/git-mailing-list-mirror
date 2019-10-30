Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0FF1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 02:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJ3Cwv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 22:52:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52809 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJ3Cwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 22:52:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2FD43E2D8;
        Tue, 29 Oct 2019 22:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UMtmjwdpfnvgWHe9/KiWRgYgzI0=; b=to4f6W
        nUK52Pe+x7mpLIyWVdueOwgX/chncrMbvh3CeYYZ7fxROAS5JPi9kEl5l/k+rmvx
        Gnc4DjjvKnTiHLQY8MJs/Dtc4gkHMzW21IW7rDqfOfc4fRU0ViCaPChmK1eEsqX6
        uWhg5V9YRbh5W/5BcbM9zxYyct2G403ZlAvsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KHiZveSd5AaOSSnLLie7LaV2DchMX9YA
        CNf0p4ZppFNUWeSnYO19Pzps+rM8yxWSv/2BS35LvZ+3tS+hh2VtPYZnF02Rdd9S
        hy7URtE5VUgQgQgwkOHcmq+qSLCr9tnC9uEhfUuE66yxB+XoNM0zucyA2cfMgnhy
        vd9z1EhjSys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E9A3E2D6;
        Tue, 29 Oct 2019 22:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B1603E2D3;
        Tue, 29 Oct 2019 22:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, William Baker <William.Baker@microsoft.com>,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com
Subject: Re: [PATCH 1/1] t7519-status-fsmonitor: improve comments
References: <pull.404.git.1571254547.gitgitgadget@gmail.com>
        <85ca71fadaa7390a32218d3a5553c83d60c06a7f.1571254547.git.gitgitgadget@gmail.com>
        <3e95662d-3c65-8511-a01b-226b0e572b83@gmail.com>
Date:   Wed, 30 Oct 2019 11:52:47 +0900
In-Reply-To: <3e95662d-3c65-8511-a01b-226b0e572b83@gmail.com> (William Baker's
        message of "Tue, 29 Oct 2019 13:07:17 -0700")
Message-ID: <xmqq7e4n3pxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B38AC5A-FAC0-11E9-B35A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> Gentle ping on this patch.  It's just a small update to the comments
> for an fsmonitor related test based on feedback I received in the
> segfault fix patch series [1].

Thanks for a reminder.  Queued.
