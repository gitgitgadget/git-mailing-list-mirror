Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C27C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1629920874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QgQphmuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgJPWsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:48:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgJPWsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:48:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA70910226B;
        Fri, 16 Oct 2020 18:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/OcDxinz9qS4LRNc14DaVoPBQsM=; b=QgQphm
        uwkl4NivV/HpQoUHtNOv03JLV1SNouzaQUTky7/OQbfn1y21inyuJ2NcED9Kgd1B
        aGem0mT3HVzrvMpwygSss2X6d0xFbQ27KUfZMxXb9QbUzabbuW5NbdAEC0CsBWJQ
        Gr8oy1z2AAVDuCWcBNtPNysUZEqvA9wgINRM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=boP9fpsqwF4XR/OF5htKBOGn4ljRpd6Z
        7VY2YZIh3U6SMKR/h7Q2+t8pnDTnlBwuA/0H/JIrWgEuByHMBNZ9etYUZzpKCmJI
        4pUiiN/m/AeNly2mQFYLO96BvyV1BpwWYJMaUvuhFgRWncFpcg1M9gmEhbcWNetZ
        eJiz0+Hcwbk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D27EA10226A;
        Fri, 16 Oct 2020 18:48:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 289DB102266;
        Fri, 16 Oct 2020 18:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] MyFirstContribution: clarify asciidoc dependency
References: <20201016205232.2546562-1-emilyshaffer@google.com>
        <20201016205232.2546562-2-emilyshaffer@google.com>
        <xmqqo8l1amtq.fsf@gitster.c.googlers.com>
        <20201016215235.GA2208862@nand.local>
Date:   Fri, 16 Oct 2020 15:48:39 -0700
In-Reply-To: <20201016215235.GA2208862@nand.local> (Taylor Blau's message of
        "Fri, 16 Oct 2020 17:52:35 -0400")
Message-ID: <xmqq362dait4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCB38B60-1001-11EB-A30B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 16, 2020 at 02:21:53PM -0700, Junio C Hamano wrote:
>> As this is only moving the existing note around in the
>> documentation, it is not making things any worse, so I am OK to take
>> the patch as-is, but if somebody (it is fine if it were done by you,
>> Emily) can double check "apt-get install asciidoc" on a vanilla box
>> does bring in what we need, that would be quite good.  FWIW, we
>> write in our top-level INSTALL file that we require asciidox/xmlto
>> toolchain (the latter is needed if you format for manpage, i.e. if
>> you do "git subcmd --help").
>
> I was curious myself, and surprised to learn that 'apt-get install
> asciidoc' installs more than 2GB of dependencies. Yikes. Unsurprisingly,
> somewhere in those 2GB we manage to fit in everything that seems to
> matter, since:
>
>   $ cat /etc/os-release | grep PRETTY
>   PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
>   $ apt-get update && apt-get install asciidoc
>   $ cd copy-of-git
>   $ make -C doc
>
> ...works just fine.

OK, that makes me feel even better.

Thanks.
