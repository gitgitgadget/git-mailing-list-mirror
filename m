Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4351F406
	for <e@80x24.org>; Sun, 17 Dec 2017 06:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbdLQGSu (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 01:18:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54752 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbdLQGSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 01:18:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E27CFB1D;
        Sun, 17 Dec 2017 01:18:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nw2glQcerJcRcsqt+31QRO5mYMY=; b=ccwl17
        eoywbD/g2X/IFpeYBrbdutavZNlSIJtEDFJMJkZxQ3FvsIJ6LBH8yBRCvF65Dd6U
        ixGfjP9KC1uNiQbzWgIAzOPhbDv54h+andwyPlw0DDAk1AeA74l3xOq7G8dagD7B
        obqjRzXebzSfwpBYeQAGuh4S8mESTUiYUbOJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rGntjKnxGw0LT91Tme5hxhUcWgR8xBKo
        8p26GIhM5Z5H0psmc50gtzHdeUyE//VgLOsKcRjJbTeUn+NzMSVUXcoEeOjOJhA4
        DGl21Oy5rSIYPp5ZMYEbQLb/dxWSptPQxHBBPeChZCn8y1F7TDW02X0raadENsMt
        IMaPp89LPxI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DABCFB1C;
        Sun, 17 Dec 2017 01:18:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6967DCFB1B;
        Sun, 17 Dec 2017 01:18:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: Re: Re* [PATCH v2 2/2] t: add tests for pull --verify-signatures
References: <20171209090530.6747-1-hji@dyntopia.com>
        <20171210065358.8156-1-hji@dyntopia.com>
        <20171210065358.8156-2-hji@dyntopia.com>
        <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com>
        <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com>
        <20171216093440.GB5617@darpa.mil>
Date:   Sat, 16 Dec 2017 22:18:47 -0800
In-Reply-To: <20171216093440.GB5617@darpa.mil> (Hans Jerry Illikainen's
        message of "Sat, 16 Dec 2017 09:34:40 +0000")
Message-ID: <xmqqzi6hop14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24BDF49C-E2F2-11E7-8EB4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> Thanks!  t7612-merge-verify-signatures.sh also lacks cleanup for
> test_must_fail brokenness.  Would you prefer test_when_finished to be
> included in the two patches as a v3?

No, I do not want a v3 as these are already in 'next'.  Just like my
follow-up clean-up you are responding to is [PATCH 3/2], if you want
further work on it, the preferred method from now on is to send in
incremental updates on top of what has already been accepted.


Thanks.

