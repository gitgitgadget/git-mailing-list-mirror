Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36011F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 05:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392384AbfJYFIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 01:08:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63836 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391798AbfJYFIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 01:08:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82EB423D75;
        Fri, 25 Oct 2019 01:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1VCiv25xgJjyQKCJVsmac22r4Ns=; b=u6hOYj
        sdiSZohI7usWI4vZD7aQGgmM0da7HEhZZ7+7c+ZOrIKHHblD6XhKz4PZnJhQO2qZ
        i/IVEh8l56G9RdfTRI0MirROxd3ZvFzi6J20rqLm09lla48Y1ryMn4AItkEL6HPm
        KC8a0bdGx0YjcYdn1wlg9XPC+ZXJSKbd3nlSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FtVomoPc4lexF4oNscyKNBTh/SfYx0vf
        jo1gR+1kAuDILHrugtTgzJO9Xsbxgn26oARIoayEBJdYhpTE6rXDCYitB3MXI3TT
        pDXq1pgHsLXq/IaOkuXCR8A4fImeFmtkgW5nYMdkPl0M3IkM8xwn2BNH+BMDh2Pm
        ma8EcyQgq78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A48323D74;
        Fri, 25 Oct 2019 01:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6FD823D73;
        Fri, 25 Oct 2019 01:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output local-part of email addresses
References: <20191024125332.29958-1-prarit@redhat.com>
        <20191024202947.GN4348@szeder.dev>
        <5d9b8cbe-489e-b3eb-873c-4aee2e2015d0@redhat.com>
Date:   Fri, 25 Oct 2019 14:08:13 +0900
In-Reply-To: <5d9b8cbe-489e-b3eb-873c-4aee2e2015d0@redhat.com> (Prarit
        Bhargava's message of "Thu, 24 Oct 2019 19:05:00 -0400")
Message-ID: <xmqqwoctcszm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 730255AE-F6E5-11E9-A4DE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> It can't harm anything to have braces but if the preferred git coding style is
> to only use them when necessary I will remove them.

It harms readability.  Don't try to be different just for the sake
of being different, especially when you think "it can't harm
anything" aka "there is no strong reason to do so (or not to)".
Instead, help others by making sure that their eyes do not have to
get distracted for such meaningless differences from existing parts
of the system.

Thanks.
