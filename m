Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A17211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbeLBTj1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 14:39:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58615 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbeLBTj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 14:39:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C41129A8F;
        Sun,  2 Dec 2018 14:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rBuuudElUMMTjD4fGFfIV+ndDDM=; b=xTWw5Q
        LvRXSejcj2dROtWWcws7TCOLuE+Tby4P4gQwrtBGCEbggDUAwGCzks9y+vDJvIt+
        PgctLghhzqvtyyQ3fqocgJmdMKaFOyqfS30suU7Zipu7vGpbcGFiMzlDpqCUsfE7
        7l1gXgT2kDjA8z8bq0h6VOa3et+8dSF/Ta/hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NwHJvRLl+VdGsWbqXHBPBqd76e7gQqIx
        HW71XJwN1QT3CzzyPuhVqGzyEf2WK8Yuh27fnrPDF1VoySXaeTU9c/y6QHQqowtW
        0KiMKkMHe9zfLFyymCajuq3W2EAdwQTLVJo7PFp0U2hRdh01Mdt3eQmwjKScrzD4
        V2XtnSgxU1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6922E129A8E;
        Sun,  2 Dec 2018 14:39:21 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7DB8129A8D;
        Sun,  2 Dec 2018 14:39:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff for Git 2.20.0 round 3
References: <CANYiYbG6X4Z02bQNJzWr73DbyR58Wd6yq+z0KngTNfhkHZ6txw@mail.gmail.com>
Date:   Mon, 03 Dec 2018 04:39:19 +0900
In-Reply-To: <CANYiYbG6X4Z02bQNJzWr73DbyR58Wd6yq+z0KngTNfhkHZ6txw@mail.gmail.com>
        (Jiang Xin's message of "Sun, 2 Dec 2018 11:17:22 +0800")
Message-ID: <xmqqftvfiuqg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6DAFBCE-F669-11E8-8C32-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Git v2.20.0-rc2 has been released, and there are 5 new messages need to
> be translated. So let's start new round of l10n for Git 2.20.0.

A huge thanks, as always, to the translation team.  Jiang, sorry to
see that -rc2 slipped just after you sent out the round 2 message
and you needed to start round 3 just after it.

