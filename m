Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C5C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5120658
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QEUdvjG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZQ4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:56:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62795 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZQ4g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 12:56:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADD90D3EA7;
        Sun, 26 Jul 2020 12:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=95jTNFNnIVX6w3uql5vpJJ5WKBg=; b=QEUdvj
        G91DpjcQlijGtxDMGXTB7qTAaQs6d0nRNlUFOr4lGPwxACjuhbJ249K/dRsZ4kkT
        hSwyScP2ZXubFMb/5ifLm87n/IynmN/BZBYegNTA56koc4qj2OW7kZjGSo0kRvNi
        JyrVTfXvTwXMsQxa1z3RtIsjnlTS+k+V+0V9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F5QPxvIGFo7RRBks1ySox6K/fyoNM+nb
        xdmCyG6juIDKHYdNR+4Mgyo45J+yZvtDBt7cJD+Sec6TOaMVciouwb+zdljl2z1j
        EC1mjfUuGkeGzH023D7xfB2kpWunbCyw61c/MvremcsYEL+jSgS/vJMnq46eW0qh
        kkfoIAG6wU0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A557AD3EA6;
        Sun, 26 Jul 2020 12:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7DD0D3EA5;
        Sun, 26 Jul 2020 12:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.28.0 round 1
References: <20200726163119.21834-1-worldhello.net@gmail.com>
Date:   Sun, 26 Jul 2020 09:56:30 -0700
In-Reply-To: <20200726163119.21834-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 26 Jul 2020 12:31:19 -0400")
Message-ID: <xmqq7duqi5a9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4D5B720-CF60-11EA-A424-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> The following changes since commit bd42bbe1a46c0fe486fc33e82969275e27e4dc19:
>
>   Git 2.28-rc0 (2020-07-09 14:00:45 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.28.0-rnd1

Thanks.  Pulled.
