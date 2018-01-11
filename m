Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408EC1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeAKUhJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:37:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60823 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeAKUhI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:37:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB3AFCA1B4;
        Thu, 11 Jan 2018 15:37:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HQxjw1acMDTqv7OmUZJ+RQB3xPI=; b=cJMHgV
        Wev+i6O7OMj8GQE8ItZLG/LTz1ZkedheLW3ouau0MAWGN7eZwyfVLBayKgDUUEFg
        5JvnvZ2Jgl1v7C6PK4CagbiA6BSr7QWlWRI4asCI4RK05xymIToIYkASjJr+7r8u
        sliBG7WQWsyuAHZA5FHLS8zlzXC9123fVpuww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MqroVEf7fj9qnognN2fEHf42PTATZHAf
        z/NpmU/BVjpCVtGXbHN2DQ9z+fRGG8DbntFSgiIVumcNj3jBMvEAAKvKb2FaVueu
        qzJFXdncgwQNaHKepTNalvW9AQUUd4BQPRQdapLBWnByQD1o9k2BE7ZZealPCa4O
        dUh8CBXkTa8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B246DCA1B3;
        Thu, 11 Jan 2018 15:37:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08124CA1B2;
        Thu, 11 Jan 2018 15:37:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 0/2] Incremental rewrite of git-submodules
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180111201721.25930-1-pc44800@gmail.com>
Date:   Thu, 11 Jan 2018 12:37:05 -0800
In-Reply-To: <20180111201721.25930-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 12 Jan 2018 01:47:19 +0530")
Message-ID: <xmqqlgh4xhce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30A0646C-F70F-11E7-994A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Changes made to the previous version of the patch series[1]:
>
> * Since later on with certain patches, the number of bit-parameters to
>   be passed to a few functions depend on many parameters, I prefered
>   using a single flag bit.

I am not quite getting what you meant to say here.

> * Memory-leak of the variable 'remote' in the function:
>   print_default_remote() was avoided.

avoided how?  I am not quite getting what you meant to say here.

> * Additional condition were introduced while freeing the variables:
>   sub_origin_url and super_config_url.

As I said, I do not think the change goes into the right direction.

