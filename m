Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1081FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbcHWR04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:26:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65113 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751268AbcHWR04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:26:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A096036364;
        Tue, 23 Aug 2016 13:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=beJU1FrrXwdkLuf+vwucd47Y/7o=; b=jcLpXl
        poOuChBlB3q0/QPiFJ1MHhcPZbMUb9iPxa/y2eDfPqxZIU1j/wusNahl2bFfTG/U
        tUEOCTvIYioPHU0KDh5pXung3U1YZvsXV/1Ml+ElKeUj1IWmfZQwZf6kBxDot+bR
        k36vg+HTRSPiPr2dZZAY5E9GoD4DYD1TEooss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hyg/rWG5JdLYlC4bjHcSSNzEA8ELMXHA
        m8LMbBwRVKj2AVW/UdwUOQnpbqXfXxMKMHyCbUXtkaIGLwGFRKC5syZCadPHJLEk
        iXM4FZvldp+g60ES4kNIqsWtXdfIqaCX7M5aJGfJz62hSag0NEjiz5qjo0ZGOhNe
        FJAQ7OuIF0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 985C236363;
        Tue, 23 Aug 2016 13:26:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16BE336362;
        Tue, 23 Aug 2016 13:26:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucian Smith <lucianoelsmitho@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-svn bridge and line endings
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
        <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
Date:   Tue, 23 Aug 2016 10:26:52 -0700
In-Reply-To: <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
        (Lucian Smith's message of "Mon, 22 Aug 2016 17:04:47 -0700")
Message-ID: <xmqqh9abwg4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8F63770-6956-11E6-8E70-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucian Smith <lucianoelsmitho@gmail.com> writes:

> The setup is that we have a git repository on github, and I've checked
> out a branch on my Windows machine using Tortoise svn.  I make
> changes, commit them, and the branch is updated.  In general, this
> works fine.

Hmph, doesn't Windows port ship with core.autocrlf these days?
