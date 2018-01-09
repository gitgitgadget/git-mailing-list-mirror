Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9251FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 19:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935117AbeAITB2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:01:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56188 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935111AbeAITB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:01:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0516C8716;
        Tue,  9 Jan 2018 14:01:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wSFp2KhYP6M8SzMCrEuuZcL+G5k=; b=OirHch
        7IdYcf/O4/OpJxRAQbmt3nYyHKn2bPAcMrRX10OQZARpYQoD8vWZkNR/DD5iXUg2
        kJjSYaYgHs6vUVa8pSkCJ11AqrLRo8f+ITxPE4r3RtqdORmHSa/X/5m61aeupfSK
        kI9f0WNR1R+0MGYxcaLpCWhS7iFH8/B9Nl+eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qh8sRSLpYnlNtwg2Pe3AocVkFngkv9U0
        N2cvp+QAdTTmAcSgQhKuNqjck7Fm+C9dzuWEaN4TqYO2gc4b+6W9BcyldhBlCcfo
        CMhITIf1G4QtVb9Fd2sQzorRqrfc6ywIdOAYQb4x5J1xd1Nq3/fcUvSStYTB66Rz
        o8PQDYhinr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C85B9C8715;
        Tue,  9 Jan 2018 14:01:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46D6DC8714;
        Tue,  9 Jan 2018 14:01:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] "Fast-"track Git GUI changes
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
Date:   Tue, 09 Jan 2018 11:01:25 -0800
In-Reply-To: <cover.1515508360.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 9 Jan 2018 15:32:50 +0100 (STD)")
Message-ID: <xmqqinca6em2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E0CC462-F56F-11E7-A290-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As it seems to be impossible to get the attention of the Git GUI
> maintainer these "days" (I have opened Pull Requests on October 16th
> 2016 that have not even been looked at), let's just side-step that
> contribution path which seems to be dormant.

Good to see that finally somebody else steps up after I did the same
for a few times recently.

> These fixes have been in Git for Windows for various amounts of time.
>
> Note: there are more Git GUI changes in Git for Windows, I only
> accumulated the ones I deem wort considering for inclusion into v2.16.0,
> still.

Thanks.  I am not sure if it is too late for 2.16, as these are not
fixes for regression during this cycle, though.

