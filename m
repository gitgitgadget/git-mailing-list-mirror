Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46191F461
	for <e@80x24.org>; Mon,  9 Sep 2019 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfIISCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:02:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56602 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfIISCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:02:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A6C2A0A2;
        Mon,  9 Sep 2019 14:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UWcot4ZYsxUKaxcztIvpDqotesg=; b=k/sDSL
        gJxbHqIFzZsBZZBaWYoDmAiUEjv9HR0CJSivaPd73edB64Wjk4LPNwdePJm/nHSS
        f1rUy4Dx6Bryo4XsWSvpWq18+7UElBEhfzEcuNrAO1klCLlBMBBkPR0V/yvKHCUx
        b8Yu6hA6ZV3gYivNMSuhqJDH6aoXsTLbjUzlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vjnMU6n4kA4ZZZEX30Cu4hZg9A+PP2FE
        R2L1KK7n8eSTNCFa/2fI5i84437rRskdh8/2vc2dRbWy0mmiwoZFebDwOMqVZSe8
        m9lPFWaL3qjyCTRFg9NIKf9GX9OP+z4DNFRPi4sa8sQLvuQMwV0jOGaMp773uz6D
        nOR5/tFAHfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DC822A0A1;
        Mon,  9 Sep 2019 14:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08C9C2A0A0;
        Mon,  9 Sep 2019 14:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v4 0/6] rebase -i: support more options
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
Date:   Mon, 09 Sep 2019 11:02:28 -0700
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sat, 7 Sep 2019 17:20:28 +0530")
Message-ID: <xmqq8sqxl557.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD6FF602-D32B-11E9-A3CF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Following the suggestion of Phillip I've rebased my patch on master (745f681289)
> and cherry-picking b0a3186140.

Sorry, but that's horrible.  The latter does not even cleanly apply
on the former.

Let me see if I can find time to whip this into a reasonable shape.

Thanks.
