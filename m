Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62981FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbdDREuI (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:50:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52699 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdDREuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:50:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FB157505B;
        Tue, 18 Apr 2017 00:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NexB78YX+1h2bFFpjPUahBnojeA=; b=PclO4H
        S630Rj2PygPe6TPr1Om5+xniUnEaB02DoBAHZvX4xX3jyA1oprwMKihhTiSXZsYk
        EZwQ1TqXk5buINw1wpMPqNSs2YN+BSixebz/xfeOBXUe+Z0MqJTVs8+FfQdEx7Zq
        8agOYL5v2u8uAFUHeavGJ4CyooxRbv0BGIP60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K9E7RV3PWrwkZ2ga2j6Qq/P8QVfEVkGG
        JeANJgxzUgPpqRrE5GE9DXDb8g83lHs4w5YGMhHTqI7DwrpmEI7EIbiXbJ3AARxX
        Ubd7BlLVJXVgi1mErtt/uDlFgwMIjPkt5t8yelUqNe0fHtjjKsKB/yQnppOkKI6+
        jjJo/BVyQZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87C207505A;
        Tue, 18 Apr 2017 00:50:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E087C75058;
        Tue, 18 Apr 2017 00:50:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] fetch-pack: show clearer error message upon ERR
References: <20170410210511.8505-1-jonathantanmy@google.com>
        <20170412180602.12713-1-jonathantanmy@google.com>
        <21160598-dbb4-2f14-8e22-f6299a1d9004@google.com>
Date:   Mon, 17 Apr 2017 21:50:03 -0700
In-Reply-To: <21160598-dbb4-2f14-8e22-f6299a1d9004@google.com> (Jonathan Tan's
        message of "Mon, 17 Apr 2017 10:49:35 -0700")
Message-ID: <xmqqvaq2e2v8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D4D6562-23F2-11E7-8BE3-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio, I noticed that this did not make it into your "What's cooking"
> e-mail [1] - is there anything more that you would like to see in this
> patch?

OK, now I've read it and it makes sense.  Thanks for working on it.
