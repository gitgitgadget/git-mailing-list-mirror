Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FFA203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbcLLVfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 16:35:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56146 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751936AbcLLVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 16:35:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2520055734;
        Mon, 12 Dec 2016 16:35:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=at+NCqhmAk9RJozzeFKhgx1V7sU=; b=hQMFhH
        a/jf5BAoCcmtE1i16iBM//Q7rVmNaq578vJLk3nSGgN9abltlzVhRZOdXAbhCX7Q
        PCSIw1XJ1Hxz5qT7/RnE/GD7vmz6HXtFN7UGHwvf9G/N9GDqUoQiQqu/0+AWfzhd
        Sh4pVYl9eWqergol/OTjSX6Tk6uGcRcZyJcec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTYeQix5jWxOpmsiZ/3j/o330JpipwcC
        YbdVj6LhM1wFyKFQF0GKE7WLK8YlPyViOm68fWIXMcnoJvCvsS6zTCrpiisGy7W9
        1rkZVgJblPax0lTD/ukAPvAnqymqyHCwTkvJyWPtuEaAwWEQsfgvBm6gcNVZ51FS
        2DvQdPPljwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BEC955733;
        Mon, 12 Dec 2016 16:35:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B08A55732;
        Mon, 12 Dec 2016 16:35:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git ML <git@vger.kernel.org>, Frank Becker <fb@mooflu.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool: fix dir-diff index creation when in a subdirectory
References: <20161207101608.16058-1-davvid@gmail.com>
Date:   Mon, 12 Dec 2016 13:35:43 -0800
In-Reply-To: <20161207101608.16058-1-davvid@gmail.com> (David Aguilar's
        message of "Wed, 7 Dec 2016 02:16:08 -0800")
Message-ID: <xmqqk2b496fk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0137C9C-C0B2-11E6-AD53-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; queued and pushed out together with the follow-up series.
