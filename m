Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B4520373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdCMWbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:31:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753284AbdCMWbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:31:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6ED28638D;
        Mon, 13 Mar 2017 18:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HgsRO8lk9jTDPsrV97sIFaBteOM=; b=qhXE6U
        mD0iWG6ZZiVln21pe7bF4l02WsqHewKeTuC0VJTuCglf03ZYnsGpC2lvxVOJlTY4
        HNjL0eRu2CyOY9oNoE9QQPLmZ9eoy/cVF94BkeWJRfYpionwcKpNoVLTPJa0FlWt
        aIViqBXiWjkOgIGB2K/oPR1psL3VRxJIZPKWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BQuY1HGBBrEZGdM8heFC69kc8g/MLxES
        zIXOaC22VgY1IQzu67XMx6AO2pnZ6NNpA4ZFnYOMWyAzR4v4BbZPR/SHzpkjelrY
        3hV4T8iOKzsKFsR5TH6qwowlEI8oetbg44x+DM8B1q3XnX5TicH9OG4w5XVVxVIW
        Seageji2wWU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A05478638C;
        Mon, 13 Mar 2017 18:31:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 143ED8638B;
        Mon, 13 Mar 2017 18:31:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v6 00/12] Fix the early config
References: <cover.1489098170.git.johannes.schindelin@gmx.de>
        <cover.1489435755.git.johannes.schindelin@gmx.de>
Date:   Mon, 13 Mar 2017 15:31:15 -0700
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 13 Mar 2017 21:09:26 +0100 (CET)")
Message-ID: <xmqq7f3sn70s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C56621F8-083C-11E7-B2FD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> These patches are an attempt to make Git's startup sequence a bit less
> surprising.

I think this is ready for 'next', so let's ask reviewers to really
pay attention to this round, wait for a few days and merge it by the
end of the week at the latest.

Thanks.
