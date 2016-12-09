Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840D71FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbcLIXNk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:13:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52514 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753769AbcLIXNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:13:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80D1A52D4D;
        Fri,  9 Dec 2016 18:13:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4UUOHS8r0CVZKFZIwqYfFIo9WNo=; b=GXynX3
        Sbq1l4ymoQJNAuFK7+65QKHmYqyb0bkHIvHMClvMjaS8dmAbu0A0DuoWC7fOGr69
        t9h/mYWoItFqVrsJa8e//znXdHdv6o0usi61BZlcg5Tj7Jqzu9b0Y/YXZiXcmlJC
        tnIlepPgH91ugxG/r1w2ioP6Re6pnDiPk4jPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ThtllxAVYSmbS8gTt722uWIbPdsrLxd3
        oMbOKROpxXzrncrYNmYop2TiO6xZt2KVXJlxzLi1Laxz7ekPUOeQRd3OoW9DmzYA
        7frf4orYK94sHmZvkXmB8HEL6LpzQNAgfqzXtC5iZcJak0cpVBvSdCt76TUqKzdO
        0MH7fk+dd64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78BC552D4C;
        Fri,  9 Dec 2016 18:13:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE48052D4B;
        Fri,  9 Dec 2016 18:13:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] doc: fixes to gitcore-tutorial.txt
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
Date:   Fri, 09 Dec 2016 15:13:36 -0800
In-Reply-To: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
        (Kristoffer Haugsbakk's message of "Fri, 9 Dec 2016 16:51:08 +0100")
Message-ID: <xmqq1sxgr90f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DA7E7BA-BE65-11E6-A0FA-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com> writes:

> This series of patches attempts to fix some minor mistakes in
> gitcore-tutorial.txt that I found while reading it.  They are all
> concerned with grammar and things like accidentally omitted words.

Grammar is not my forte, so even though I'll queue them as-is
because I didn't spot anything wrong in them and thought they are
all improvements, I'd appreciate somebody else to lend an eye or two
over them.

Thanks.
