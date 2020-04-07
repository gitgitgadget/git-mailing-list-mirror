Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1DC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 03:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC342072F
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 03:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c55BUhIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDGDPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:15:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61970 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgDGDPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 23:15:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55B50CF68B;
        Mon,  6 Apr 2020 23:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e+QNR9MNUsuFN/02u/sHl00ikYQ=; b=c55BUh
        ItwDf3COYGJfIXU1Pyj/qdNeOkWlPvNH4i3oPiIjtEL7CK/9kfA9CwdlQAxqVImr
        xLspJK8OD4pobupGYNk/H2ZuOfZrN0cH7owUn5tT91ZD5sMG+B7GtwNAQJoxoVlI
        z/qPpF2fJqaHyhDPY5nxz0q1F7IHpguPCGvnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I3T29Bi6RKm6JKf7/OsUMm9aF2oGHybd
        XxGlQtqlPcW4cKbvFOEmmwSXUaDdyBrrT74J0ya0qjeF4RTZJOzloklIFzpt+kN3
        n+B1wERHEy8YLwcEoKL47PTH0c6VXD2TCXq07AFXEXwV5Nh3F9lZk5hwnjhK4znu
        a6etoqBakEU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4236ECF68A;
        Mon,  6 Apr 2020 23:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AC29CF689;
        Mon,  6 Apr 2020 23:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
        <20200406181216.5340-2-shouryashukla.oo@gmail.com>
        <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
        <20200407010709.GK6369@camp.crustytoothpaste.net>
Date:   Mon, 06 Apr 2020 20:15:08 -0700
In-Reply-To: <20200407010709.GK6369@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 7 Apr 2020 01:07:09 +0000")
Message-ID: <xmqqtv1wt29v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD5CE4A2-787D-11EA-9F39-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm fine with or without this change.  I think the original is clear to
> a native English speaker, but if we think it will be easier to parse or
> harder to misread with "made", then I'm in favor of the change.  I, of
> course, cannot speak for how either one reads to a non-native speaker.

I am not a native, but if I were writing it I would probably have
written without the "made", so I guess I am in slight favor of not
changing this part.

> I'm not sure it's fair to categorize it as a "grammatical mistake",
> though.

The patch certainly is an attempt to make the text better, but I
agree that the patch does not correct any "mistake".

Thanks.
