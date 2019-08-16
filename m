Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70051F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfHPUGo (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 16:06:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53298 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPUGo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 16:06:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A7888FA22;
        Fri, 16 Aug 2019 16:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZSiACEPLfusFFUY9RIGccKPb/10=; b=oPusGd
        B8QSb4xrvwMjKzMT80DPykT6Gw7ZKBnou7PXMtKeNjJtPocyPfwLCOYsAcwzfc8/
        At/amXldxbiHgzwwH8A42dPW1uORUK5ZQWqL7Pg+gj+JnUTSQIrqmoicej1lOyXH
        H1JoxtWv54mxrvhU7TbgN8+xFo8dccEnyIOls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IIj5FC0mH3R1XbgKxlVBExcQD0LPHA0G
        wa7HFZ4LgrZ04WvVJrE9nqng3hFpJqnrrprFPH8uvu2CtxRGG9Xa+NDxSXKjzUA0
        BESlebs/cH/Qlm9P/N3xpJAr+l/k5hlXva+lzTLLAaS9L4rrN8c7XfgS8ulBsvna
        9VDAIwH46FE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 224648FA21;
        Fri, 16 Aug 2019 16:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 546C48FA20;
        Fri, 16 Aug 2019 16:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Carmine Zaccagnino <carmine@carminezacc.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias Ruester <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Philipp =?utf-8?Q?Wei=C3=9Fmann?= <mail@philipp-weissmann.de>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [GIT PULL] l10n updates for 2.23.0 round 2
References: <20190816091636.2846-1-worldhello.net@gmail.com>
Date:   Fri, 16 Aug 2019 13:06:39 -0700
In-Reply-To: <20190816091636.2846-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 16 Aug 2019 17:16:36 +0800")
Message-ID: <xmqq4l2g27u8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CDA06E2-C061-11E9-AA03-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.23.0.
>
> The following changes since commit 2e27de94d485a6da0c8e264c165e55100f1a13a8:
>
>   Git 2.23-rc2 (2019-08-09 10:15:39 -0700)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.23.0-rnd2
>
> for you to fetch changes up to a6cd2cc485b9ba73934a059245aa9de7e68a2d4c:
>
>   l10n: zh_CN: for git v2.23.0 l10n round 1~2 (2019-08-16 16:59:17 +0800)

Thanks, pulled.
