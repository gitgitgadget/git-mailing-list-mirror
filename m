Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70151F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161260AbcHaRMS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:12:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56511 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161043AbcHaRMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:12:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 329D438F4D;
        Wed, 31 Aug 2016 13:12:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T0VJ31otwyOC9mR3oPvMsKjXg/Y=; b=AveZ5w
        7/XQUfDNHIGTrzdR2NTGkB5CgVsapBkP0UBoJbCou6yZ/Q2AAVnFzEYt9EU9+KTe
        yF0jkjradTMBn13fNxVtXmE+TEovBJakMtBdRA6vQxrfrnucV+cZNbAjNJRVtreA
        8ZDfjlsiuEFz1MpHiI10ueigiIwoMbzwBN2IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nctR2zgjVT5DhfHf1kuKsgNfwhORfAAF
        Ma3cM3O60RUHVWd3Sfd1U+esfEh+NIR3bg6E0caN4k9gOk69ebeWZFNLX/bFbIE7
        GOWQOiRkr58kiDb2z5NFwU8L3aKSnIujAsIGrXPcAbmjQZSUP/by7wnvt1+ctM/C
        en+yYaDELbo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28BD338F4C;
        Wed, 31 Aug 2016 13:12:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CE0238F4B;
        Wed, 31 Aug 2016 13:12:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [GIT PULL] l10n updates for 2.10.0 round 2
References: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
Date:   Wed, 31 Aug 2016 10:12:12 -0700
In-Reply-To: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
        (Jiang Xin's message of "Wed, 31 Aug 2016 22:14:34 +0800")
Message-ID: <xmqqy43c2783.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101CC7D4-6F9E-11E6-91B7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Would you please pull the following git l10n updates.
>
> The following changes since commit d5cb9cbd64165153a318e1049f8bf14b09a16b11:
>
>   Git 2.10-rc2 (2016-08-26 13:59:20 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.10.0-rnd2
>
> for you to fetch changes up to 5c57d7622e3c7c685345f9736c4c924349a321dd:
>
>   l10n: zh_CN: for git v2.10.0 l10n round 2 (2016-08-31 00:11:13 +0800)

Thanks.  Pulled.
