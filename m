Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E5AC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD2820C09
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9+04Dkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgE0RSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:18:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56191 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgE0RSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:18:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B896C4DD12;
        Wed, 27 May 2020 13:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jfy7IVu/eXKHQllAnRfB+XbfVsY=; b=L9+04D
        kd3vTURlazVa6s5IdkMte2L0bcUgzjXUI+dlRAQpMbqStY+uaEsXd5JcLmDPLEyo
        3db036OBqUITyg+Oy/1msMhkzIHXvhRGjUIOC9yN7V7LVgYVmGejcL6nBXgl8H/o
        LSAGim6id033buWQ5FTUEwdnLZMKTqReZCPmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wFcg31qbrlUkbTMyd/Jxv63lHe7wICd6
        JludX6ohfbqcRc7ObtniNOSBcuMOnzn/U5g4bBdztTSKoxlxi33TgtTu5XfxY/zY
        KjQDWqNxf82oN9Mnlp1rG4M4M1rerkDgK0o3kusdKasSUDqZ7S5yVFRPKJ1cX1br
        90F9HOOBl2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B14FB4DD11;
        Wed, 27 May 2020 13:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3908B4DD10;
        Wed, 27 May 2020 13:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@his.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200525232727.21096-1-keni@his.com>
        <20200525232727.21096-2-keni@his.com>
        <xmqqmu5umsjg.fsf@gitster.c.googlers.com>
        <79C90EFA-CF65-4AF7-82B2-0B1B6FABA0F8@his.com>
Date:   Wed, 27 May 2020 10:18:43 -0700
In-Reply-To: <79C90EFA-CF65-4AF7-82B2-0B1B6FABA0F8@his.com> (Kenneth Lorber's
        message of "Wed, 27 May 2020 12:52:25 -0400")
Message-ID: <xmqqsgfll2j0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E26887C-A03E-11EA-8CAB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@his.com> writes:

>> I am not sure if .sample scripts should be a topioc of this glossary
>> entry at all to begin with.  And I think it outlived the usefulness
>> to describe what was in versions of Git that is more than 10 years
>> old.  I wonder if it is a better idea to take your new description,
>> but remove everything after "The sample scripts are enabled..."
>> except for the "see ... for details" link?
>
> I had considered it but didn't want to presume.  If I don't hear any objections
> I will take it out.

If it is not too much trouble, it probably is a better organization
to make this a two-patch series, whose first patch leaves the
original description on .sample files in, and the second patch that
builds on top of the first patch removes the description on .sample
files.  That way, if people still likes to see the description on
.sample, we can just drop the second patch and still use the first
patch.

Thanks.
