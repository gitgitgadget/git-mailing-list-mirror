Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ADA1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdHSQuy (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:50:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbdHSQux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:50:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17CF8A791A;
        Sat, 19 Aug 2017 12:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=vczWce
        Zij/fRBC8H0P7gsEx65eqAaSTQCExn+RVXjpJYpcNOcGcejau2SXHVpLQXcfMOam
        3b0vxgyOMpdo5B0oNz8xz2GrOSF2JuIHHviP15mDFY2l8Jc2HzOgKeqchPfPejZr
        SbnWvz4qabUWMA100lK6+rExgyzdiJRDEHIds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0CcDJ6b8acX3k5in2rU4Ev4d6XKVyZx
        VkjXanWD6eRBcVqeXivGsEfGt3EN0yS7lU1n6zY++x+JHJmfac1+45AkQnchQAFS
        db2W55n88OWIwAVBZL/d5gZrepoMG3j2y6uYVwYGg6MAP009DvpZYwKWQIKIlBnF
        u9sqSU8bRs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FCEAA7919;
        Sat, 19 Aug 2017 12:50:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B560A7918;
        Sat, 19 Aug 2017 12:50:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: remove unused inline function single_parent()
References: <0993ee6c-712b-505e-9cfc-364d7ab71261@web.de>
Date:   Sat, 19 Aug 2017 09:50:46 -0700
In-Reply-To: <0993ee6c-712b-505e-9cfc-364d7ab71261@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 19 Aug 2017 10:12:45 +0200")
Message-ID: <xmqq7exza4d5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CB2F14E-84FE-11E7-BF7B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
