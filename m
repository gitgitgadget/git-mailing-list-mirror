Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F71620288
	for <e@80x24.org>; Fri, 21 Jul 2017 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbdGURWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 13:22:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754803AbdGURVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 13:21:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C34C195B90;
        Fri, 21 Jul 2017 13:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TROeVj6QDmdFgofA3NDjvy5rEYw=; b=UNOMkB
        3QSc2J2XlqaDLTL/qW+2/UJaVS1Si3bTMnESuX4BIJblkWaSGeuPOInBmKIDF+X3
        2qMwhTbOwAw+gRPuEZIZjjZ9VrbmmsUV5xjRhgxKsb8ow7kTHZ6B7Hg43TqR4KqA
        DmCPsZSLg+zgMRnFkkmVMj+pXC25yygRMlRJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAib6Uy9UGT1P686dI7D3gx2doJJLuD9
        SCu67h/aXxiiN2ExIKEkeIS+vtXCMH4Nhc9xMUQ7W0fbtn5iaAoVMHQgKv8Tch4V
        ImB5nwI9+PA9UWToNMLrVRcqLR6gVKlcsmrpmdEd7yEnfZitxawhXQCt2k52zQcg
        Q5GqRVZmJa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAF5995B8F;
        Fri, 21 Jul 2017 13:21:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF63795B80;
        Fri, 21 Jul 2017 13:21:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Magnus =?utf-8?Q?G=C3=B6rlit?= =?utf-8?Q?z?= 
        <magnus.goerlitz@googlemail.com>
Subject: Re: [PATCH v2] l10n: de.po: update German translation
References: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
        <20170721151144.4410-1-ralf.thielow@gmail.com>
        <xmqqshhphitv.fsf@gitster.mtv.corp.google.com>
        <CAN0XMOL2E3+raBkH3LHg15ZYP8zH4Qv8oh1Zn+G6C6LZxJerdA@mail.gmail.com>
Date:   Fri, 21 Jul 2017 10:21:37 -0700
In-Reply-To: <CAN0XMOL2E3+raBkH3LHg15ZYP8zH4Qv8oh1Zn+G6C6LZxJerdA@mail.gmail.com>
        (Ralf Thielow's message of "Fri, 21 Jul 2017 18:32:27 +0200")
Message-ID: <xmqqfudphfj2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E535464-6E39-11E7-ABFA-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> after applying the patch, entries in date.c turned into this
>
> -#: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156 date.c:167
> -#: date.c:175 date.c:180
> -msgid "%"
> -msgid_plural "%"
> -msgstr[0] "%"
> -msgstr[1] "%"
> +#: date.c:122
> +#, fuzzy, c-format
> +msgid "%<PRIuMAX> second ago"
> +msgid_plural "%<PRIuMAX> seconds ago"
> +msgstr[0] "vor %lu Sekunde"
> +msgstr[1] "vor %lu Sekunden"
> ...
>
> which seems to be OK. A full diff after updating de.po after this
> patch can be found at https://pastebin.com/5yeSnGQj.
>
> Ralf

Thanks for a quick report.

