Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6721BE7AD76
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjJCQdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbjJCQds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:33:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161E91
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:33:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4E362CB90;
        Tue,  3 Oct 2023 12:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=DpkKv780+mHhaTc3pWBDqPTEjqVR+ODA3yP6R6
        Fwk6U=; b=rD/0N1QD1uwIg7T8Ek6L/KNoin8kBxueVneJFiprzIpcXuhfJNzi2s
        Nitjyw1hxqLdiuVoEu0A+cBWlVlxonHt7CK2svAd+SEjGFPlcQhgv60fns6HR3wJ
        wrmp1z/0EpTeBN6DSO9ddVotxVgXp/Xa1C+Zfr3bEOo8RhzCWUf9k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEAF02CB8F;
        Tue,  3 Oct 2023 12:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 658422CB8E;
        Tue,  3 Oct 2023 12:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
In-Reply-To: <871qecgpg1.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        03 Oct 2023 10:01:02 +0300")
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
Date:   Tue, 03 Oct 2023 09:33:40 -0700
Message-ID: <xmqq34yr3btn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D5BF21C-620A-11EE-905A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I believe I've addressed this in details in my reply here:
> <87o7hok8dx.fsf@osv.gnss.ru>, and got no further objections from you
> since then, so I figure I'd ask to finally let the patch in.

You need to know that no response does not mean no objection.  You
repeated why the less useful combination is what you want, but that
does not mean the combination deserves to squat on short-and-sweet
'd' and prevent others from coming up with a better use for it.
