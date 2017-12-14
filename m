Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12791F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbdLNS1X (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:27:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753722AbdLNS1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:27:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F247C7702;
        Thu, 14 Dec 2017 13:27:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a2GzTUBY9pxdn67xBFg2rZFIxE=; b=W3NLbg
        gm7Cm1lua9J6TDy/R8YcZIjSeYk7JOzoZIsNlDmfqPT0A9A+kykAE1PR/blVhdH8
        NBhp7ZlFR0JvpyutzA3yHhD0MPAJCeXMO7Zc9FfGqQLd5vy72frjuN9usBsiYrNa
        y4pw5Q5QYlcpYIdjH2bVSCDUD3i7vfAbVMCp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WxUgBKLsglg3LeznzGgS1j8fwqCznnGB
        mi1DWJfNR+PFJC4lz/Pt5ubCEvLXWoIhTUjL/HhS0iOZpxrvoJVk8Osl4be00DP5
        v9Nrx8ycl3Df0CF0Xb1tgUSfchcwrMVWIr+NV7W7qMnfrThGhz209C4ZMceiDBCW
        9DU7ylcQN3k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 872F0C7701;
        Thu, 14 Dec 2017 13:27:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED340C7700;
        Thu, 14 Dec 2017 13:27:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] partial-clone: design doc
References: <20171214152404.35708-1-git@jeffhostetler.com>
        <20171214152404.35708-2-git@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 10:27:19 -0800
In-Reply-To: <20171214152404.35708-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 14 Dec 2017 15:24:04 +0000")
Message-ID: <xmqqwp1ptbaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C3F3382-E0FC-11E7-9EB3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +  There are various filters available to accomodate different situations.

s/accomodate/accommodate/

I'll squash in this and /pacfile/packfile/ typofix while queuing.

Thanks.
