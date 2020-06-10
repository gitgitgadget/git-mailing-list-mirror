Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A580C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACA8204EA
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MdOCSHGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgFJTff (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:35:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58143 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFJTff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 15:35:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90840DA2ED;
        Wed, 10 Jun 2020 15:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N9LfmsljcDqIUsnu0No3gk7dAy8=; b=MdOCSH
        GZWxvIb8zze5TZ4vrkzIOoTXQsgvAXGzq/tK5g+i4Fx5gC/ItSqP5xdwnV7jZx3B
        Yevfy7GAmR/KyAhX7FJmhExHUTU/gUzWJSB4STlU+dQ6T4zs3Zx43zr76qI0jOjx
        8HrFFX7EsDzS1b+fI6UAHQ/c85koT9EyczV8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=teNTKO23RXnn5GvzveJngGsKYkF8a6OW
        FuTBQBds/AlaSx5I5IAacu72+DV7AjiFA0E5asfUNxpONByJ+24M/iyQi9Q1KaxJ
        TxwPWuxzKn5wBO3p9qLwC4zc/gRs8gfgfdLfjMXvlbTXBN9mkji/peJdaUgdwJ5+
        12CXLYuXEvk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88BBADA2EC;
        Wed, 10 Jun 2020 15:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65C30DA2E4;
        Wed, 10 Jun 2020 15:35:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jimit Bhalavat <jimit@rams.colostate.edu>
Cc:     git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
References: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu>
Date:   Wed, 10 Jun 2020 12:35:27 -0700
In-Reply-To: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu> (Jimit
        Bhalavat's message of "Wed, 10 Jun 2020 12:06:07 -0600")
Message-ID: <xmqq1rmmg1ds.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A9AD67A-AB51-11EA-AC23-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jimit Bhalavat <jimit@rams.colostate.edu> writes:

> I am Jimit Bhalavat, and I am a Junior at Colorado State
> University and my major is Computer Science. Recently, I accepted
> to work on Hyperledger Git Commit Signing Project through The
> Linux Foundation and my mentor is David Huseby. I am writing to
> you in order to ask you if you are the maintainer for the GPG
> Signing Project?
>
> Which branches are for refactoring/new features in the GPG Commit
> Signing Project?

The fact that I know almost nothing about "Hyperledger Git Commit
Signing Project" (other than the search term returns some hits from
the search engines [*1*]) makes me suspect that whatever branch I
control is not suitable to contribute to that project, which does
not have much to do with the Git project, where this mailing list is
its home for.  Perhaps ask your mentor first?


[Reference]

*1* https://wiki.hyperledger.org/display/INTERN/Git+signing+with+DIDs
