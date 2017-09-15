Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4F820A25
	for <e@80x24.org>; Fri, 15 Sep 2017 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdIOSeA (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 14:34:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751611AbdIOSd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 14:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D218B9888E;
        Fri, 15 Sep 2017 14:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NzGNcTSXtJ1623gMHKg+j5FdbSk=; b=pqQoDm
        kG1XoosUzF0tAiZqD3qBPy7qFpAWwm2tkfiNo3ctaRcAHuN5+bodi8P5auE97yJ8
        tbWyW9Kkd8gZd659QnFpCyIUaVoe6T6JU2gqmlWFlUwwTptEyZIMZyWy4L+pS+sC
        NHoPazZbGduotBrBRigFpDfLL4rHc67tNmpK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sH1OKU6sNQ6PKa5tabA2VgPruOIBfRr3
        pweyrLQIxqP5SRg2wUpv93IyVWv8UC1hn+PGtCAyRe70X+n/3G7MO9Wm9ZsKRJ4A
        /96By5tKpcNMI4K5NbRxxOs46856Su3fkydShvRNJvig1Z30M/1kBrH/9/I5qIKb
        Ae6I528nQ1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C97A89888D;
        Fri, 15 Sep 2017 14:33:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34B409888C;
        Fri, 15 Sep 2017 14:33:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
        <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
        <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
Date:   Sat, 16 Sep 2017 03:33:56 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> (Johannes
        Schindelin's message of "Fri, 15 Sep 2017 18:18:19 +0200 (CEST)")
Message-ID: <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F34FA6C-9A44-11E7-B0F6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you want *contributors* to ping the thread themselves, how about
> *posting your updates there, too*?

I do not understand this comment at all.  That is what I and others
already and always do by responding to the patches, and when trying
to see if a topic is still alive, with thread-specific responses and
pings.

If you are demanding that "What's cooking" report to be sent as a
response to all the topics, that will *NOT* going to happen.  It is
meant to give a summary of the current state to help contributors
and reviewers be aware of what is happening across the entire tree
and not limited to a specific topic.
