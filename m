Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D4A1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdHSUzp (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:55:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751684AbdHSUzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:55:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C30D08F271;
        Sat, 19 Aug 2017 16:55:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gjSEAj+Md59zdhnekvyjBvl2qBs=; b=TsJQkw
        TrJ3oSjeG6oBm4h1Jrg6pSSbkM6vcepLuS4h8vzx6D49zASr9J3cIQ5l6hF/qeIT
        kmpJ3IKwOSrxMysMnfxs98qQfMBoi4E5HHaiRJXRtXPpSp/W6U0UcGonKBDkDdlA
        sDPpmIrfs60Amc6V31TCOeo4GRfd7H0MoF4Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p7mvKfd0cVI2peamPpMmdA9TQ0r/OOrg
        1/hJuoDoED47qmssXNOSrzZq+Db+Kp8i+2ZjYcEKuJ785JdhM+TKIDx71ZiUr1Cm
        VaN3Kfw5E0wTu0YVucjUMiuo4of98nMTVZZroqj/jawwzBzuYalOSePHLp/Aymf+
        VnMv3r5bm1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF5248F270;
        Sat, 19 Aug 2017 16:55:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21E5E8F26F;
        Sat, 19 Aug 2017 16:55:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] stash: add test for stash create with no files
References: <20170819201326.6872-1-joel@teichroeb.net>
Date:   Sat, 19 Aug 2017 13:55:35 -0700
In-Reply-To: <20170819201326.6872-1-joel@teichroeb.net> (Joel Teichroeb's
        message of "Sat, 19 Aug 2017 13:13:24 -0700")
Message-ID: <xmqqpobr8ego.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0675152-8520-11E7-97E7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see three patches that add tests, but it is hard to judge them
without any explanation on what the point of them are.

Are you documenting an existing breakage?  Are you extending test
coverage for some breakage we recently fixed without adding tests to
ensure that the fix will stay unbroken?  Are you planning to touch
the implementation (perhaps to add yet another feature that uses
some existing code) and adding new tests in advance to avoid breaking
the existing code?  Some other motivation?

These would have made fine material to write in the cover letter for
this series.

Thanks.
