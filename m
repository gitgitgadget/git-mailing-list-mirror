Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D18E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdCMWa7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:30:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64042 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751150AbdCMWa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9464A83F8B;
        Mon, 13 Mar 2017 18:30:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y0+oWu8V7GKNsFqXItFRWnQxn9Q=; b=ygRF51
        PIm/YvFFab6DR9FmNR5zL0iV5zVfNVhgOFGIceShfwlWIhvfrXiq0SyMZFQXfObD
        1eDVmp/GTo03YSsWx2yTlUesoTeB4l3N8zp7EFIdtXxiVlua9wCEaWakoV2eSMVa
        40+6UYiF8muJgwXe5uygss1Rx7rIP1pI8eePY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mc+UYc2dHElE4X+IYuajfL1T2YGyuryr
        RsAiOrFRNVvErEIDoW292z/YZeGhQkheZMDUfAqqy1y7Nh5OX9eQBQdo3tp04eii
        lbn7AXIyhRgQ4tiCKMXsLQf5ZFgZa38v3sHZZ9afbmXvQMrhH+0qz1gcpLpeMI1V
        IQPp+R9SOcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D8A883F8A;
        Mon, 13 Mar 2017 18:30:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0191A83F88;
        Mon, 13 Mar 2017 18:30:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 0/2] bringing attributes to pathspecs
References: <20170310185908.171589-1-bmwill@google.com>
        <20170313182322.27539-1-bmwill@google.com>
Date:   Mon, 13 Mar 2017 15:30:54 -0700
In-Reply-To: <20170313182322.27539-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 11:23:20 -0700")
Message-ID: <xmqqbmt4n71d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B96E9272-083C-11E7-8603-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> v3 fixes some nits in style in the test script (using <<-\EOF instead of <<-EOF)
> as well as fixing a few other minor things reported by Junio and Jonathan.

Thanks.  Will replace.

I think this is ready for 'next', so let's ask reviewers to really
pay attention to this round, wait for a few days and merge it by the
end of the week at the latest.

Thanks.
