Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB831F462
	for <e@80x24.org>; Mon, 10 Jun 2019 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbfFJTQE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 15:16:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65303 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbfFJTQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 15:16:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ECAA162B2E;
        Mon, 10 Jun 2019 15:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J0e9go3AtHDC
        A7RLalNVDi5ci3M=; b=v3qBjWjY7zOH/Vne847IfNKpvsl9CTG5CtKx41GZ4r8x
        k59HmUUd3WkgVpyZwddOJlm+BIXgKp1/0Yi1HvsklPjBHue/wS9QhHe+Cy8wxUSm
        SoiFGCiAkf0UcFGKKlHNUXKkaTd96xyhQAOX7Ko+z0L2kKi/bmObZS+ocn/nEQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=muAe4Z
        7FICDWtncqjlcLQ4/F7sXmLXApRcOnUebEH7q98lwvkrFlpdUXij28pAMlHi48at
        9tN6laSInL6U1rxbqSLRbt07HAlgSWTYg4qhJ0XYu8VIen0J+D8I+f0jgU7WlECH
        UPApH6cSbVYPgD5SlJCbdegH/4oCaIu9NTdcg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37C6C162B2D;
        Mon, 10 Jun 2019 15:16:01 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C39162B2A;
        Mon, 10 Jun 2019 15:15:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, timcharper@gmail.com
Subject: Re: Inclusion of translated git manpages into the packaging systems
References: <1979608.xhrAu3A07H@cayenne>
        <nycvar.QRO.7.76.6.1906101906140.789@QRFXGBC-DHN364S.ybpnyqbznva>
        <1835964.yutTd2aTbA@cayenne>
Date:   Mon, 10 Jun 2019 12:15:58 -0700
In-Reply-To: <1835964.yutTd2aTbA@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Mon, 10 Jun 2019 21:02:17 +0200")
Message-ID: <xmqqmuipmett.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E589B26-8BB4-11E9-90A8-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> I can provide an archive comprising the precompiled manpages so that pa=
ckagers=20
> don't need to mess up with po4a.

That's an interesting thing to hear---if this effort eventually
relieves me from having to supply preformatted manpages and HTML
docs (after all, en/C is just one more locale from your point of
view, right?), that would be an excellent news for me ;-)

The last-mile packagers that are directly facing end-users would be
happy to have a place (or two) that they can pull the pre-built docs
for these locales from, and they would not particularly care where
exactly those places are, I think.
