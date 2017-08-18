Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080A820899
	for <e@80x24.org>; Fri, 18 Aug 2017 02:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbdHRCUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 22:20:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50901 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753857AbdHRCUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 22:20:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A137D943B2;
        Thu, 17 Aug 2017 22:20:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=JzfTPf
        x3VxXb/ZtBbcVOzxhHETTTjScM9+cRZBdTO4YvwV2A2rWvMj8a5v/tzpbwIOP0Bu
        u3OmE83+nAkzWWh7qU6NVtXA2oegNyuaXM2RCxUtQtgpFejD2D8aBjFcflrBVaHW
        1dSciKbs61u3eJFS+ZVpXIeSTSKphQTBX2OuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YFxPE2EUw9mEiUpr9p80OyZcWhQepFo9
        k/Fd9/rTeT4HcT0EVqgCyvO0a51pwoTcxvJNE7O3DiKnFcng8y71LdgmHjvsHUgY
        sFz0xR9lO/X5CzsUOCnIBITxaxUNwyf0TySyRmyq7MdYWl5twcnWlk3/Beanljr5
        f7CF+2Oo5Ec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A3FD943B0;
        Thu, 17 Aug 2017 22:20:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00826943AE;
        Thu, 17 Aug 2017 22:20:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Modernize read_graft_line implementation
References: <cover.1502905085.git.patryk.obara@gmail.com>
        <cover.1503020338.git.patryk.obara@gmail.com>
Date:   Thu, 17 Aug 2017 19:20:40 -0700
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com> (Patryk Obara's
        message of "Fri, 18 Aug 2017 03:59:34 +0200")
Message-ID: <xmqq8tihehvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D56BD566-83BB-11E7-A64E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will queue.
