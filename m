Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E265D1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 20:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfILUoz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 16:44:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50894 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfILUoz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 16:44:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91F8E7A6BF;
        Thu, 12 Sep 2019 16:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CBV+3FGDMs2qQSkA1UFxPH6mMl8=; b=f6rxKj
        bmItjpA/skKJYvwBD+zfQXESGNg7SFdf18x4orBvFnpQDOclXShoI1TbRXavf0nu
        60s0ha/U0ofvcRvBoS1dfK5hFwOJ5J2IA5wrGVFg9bAWhO2FcOozMWeOUnPqT34p
        4FcHsBFL2F/oyX/DtIyQ1gphFqBigLaAHm7Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cge6hKx1pJnJTitc4uH21YeMPoPx4+5w
        vZ+LgiTKBaMRWspaVD8Ti8qLVgAYwPcLQMKN8Qgc2FQZJkpGEmdw/I0HvHiX5Q3h
        AaOE5p6+9sr6thDvEuCoI/87to2NVTAMMEJnWWo5TIlADGNUBv+NH6aj2SzbXk5v
        goSx+/FLJeg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A5887A6BE;
        Thu, 12 Sep 2019 16:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5E2C7A6BB;
        Thu, 12 Sep 2019 16:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] completion: teach rebase and archive to use __gitcomp_builtin
References: <cover.1568317093.git.liu.denton@gmail.com>
Date:   Thu, 12 Sep 2019 13:44:48 -0700
In-Reply-To: <cover.1568317093.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 12 Sep 2019 12:43:52 -0700")
Message-ID: <xmqqa7b9fdmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A96C920-D59E-11E9-813A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, the completion function for rebase and archive don't take
> advantage of __gitcomp_builtin(). Teach them to use it so that future
> changes to options will automatically be included by the completion
> script with no extra work.

Nice ;-)
