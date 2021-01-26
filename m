Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D8C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454082067C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbhAZWBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393644AbhAZR4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 12:56:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88B61AB085;
        Tue, 26 Jan 2021 12:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O+7pZ848aPnfALdSpihSXe4mQ+o=; b=bjv8Q0
        +DpZviZ5Lw15ZGsBI+GIVVsNIMxDLxd0vFuOI7/PEfk5QfeU7A5iy8V4DLlpwT0c
        pQGSgN7gqAs8YH9QSXbC3EMTBmKlNtgMFzN0YYbQGIOpqIQQFEmc1I1R3LesgwO+
        kVL69jziMx/rPYfsm64o72bTyQGchu3GB4kw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z7uS+2vfGCOfTMzThKzALCP3YebqeqdI
        0UbGS7gTcMstHQujtsaAk89g1kZlX8FHubF1pZbGvpaTxYi/mTuT/eA272KJ+USe
        iEvI4RFhVF7C4J0ipTl8+qvCIY7cphZdBKLQIGvCpq3om+EHJt8tRKrKGzd8Ez8/
        Xtv+8Cgk7T4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73914AB083;
        Tue, 26 Jan 2021 12:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AA1DAB082;
        Tue, 26 Jan 2021 12:55:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Finish converting git bisect to C part 3
References: <20210125191710.45161-1-mirucam@gmail.com>
Date:   Tue, 26 Jan 2021 09:55:05 -0800
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Mon, 25 Jan 2021 20:17:03 +0100")
Message-ID: <xmqqh7n337nq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FAF5A14-5FFF-11EB-AB8D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a third part of patch series 
> of Outreachy project "Finish converting `git bisect` from shell to C" 
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.

Did we lose [2/7] somewhere in the mailing list?  I see the same
thing as what is shown in

https://lore.kernel.org/git/20210125191710.45161-1-mirucam@gmail.com/

i.e. a 7-patch series that lack its second part.

Thanks.
