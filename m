Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0B61F454
	for <e@80x24.org>; Mon,  4 Nov 2019 06:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKDGSi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 01:18:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52740 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDGSi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 01:18:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9242AFB52;
        Mon,  4 Nov 2019 01:18:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0yNg02CRRaWq/lms6nKLwQCJ4Hs=; b=amsjhr
        MoN7yKa3RFe8vq5UAJCEmivpEUWqw/mmbdbtvXUUb2aiq9gNysmr+26J8YQpZPem
        7gvFDOhpgxmua56KGYD1UWkcRheOcH13PWpmJNSDzd14y1uXqmK31Sqw/DQTY6Xg
        rxCMJSYfGwxONRzDzdd34Jc2OabIQuxqGTT7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ia8PFBEO59kSR/AhGzCtYRIdHxWGFx2U
        BH0QG1g6GsmFktZDJzUa6LqzvMzDSDxHeDSplRM+RgNLGMZbQvu6t/BiVuLwoAXE
        d2E+bv3Hejj5Cyx4cElsQtlU4ne9J3jIO5+FE7Z18i6JEgseNxE22vgTPEuI964P
        DHlv6QB0+eQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C270BAFB51;
        Mon,  4 Nov 2019 01:18:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECEE4AFB4D;
        Mon,  4 Nov 2019 01:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.24.0
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
        <20191104054924.GA47418@syl.local>
Date:   Mon, 04 Nov 2019 15:18:32 +0900
In-Reply-To: <20191104054924.GA47418@syl.local> (Taylor Blau's message of
        "Sun, 3 Nov 2019 21:49:24 -0800")
Message-ID: <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE8276CC-FECA-11E9-8379-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thanks for a great release. As always, your release notes were
> very helpful in putting together GitHub's release highlights [1].

Well, thanks for writing a version readable from humans ;-)

My reading hiccupped when my eyes reached this part, though:

    ... commit graphs can represent an order of magnitude in the
    performance of loading commits.

There is a word, perhaps "improvement" or something, missing in the
sentence?
