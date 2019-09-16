Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5641F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfIPT6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:58:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfIPT6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:58:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2557A27296;
        Mon, 16 Sep 2019 15:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0UZEYg42oIvw
        lLfR7XoEPQqkt+Y=; b=h5U7qhvhdRr3qNF1yYFQNZI4TouxRsZqQodJcM8FxN63
        /aEu2Z2I8Mrvenmtm4ScvGqL6EfefJP6qyu6AoEe7jChVSYXaL6MjgHNACx302hk
        WV150Wx188EHVKzVHrMvc+CVlp6UDLRbQjJMIMWjSZxDF2X+rrY+uHm0Y0mK/qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iyFbh7
        bYGmT6P+WyT3qC98r5IC35cBLVuA5/rMWipVE6JTq8gWhHKd/hgsGU8jBqA8LiNW
        acq3isgLPvDhLGbAl4TlWT1TIDyi29NBRH7wZgribrEp2Zt7vWsjnnsHrkEMBauz
        2GVbtNT5wQ+BxIulkYngS7S3bgf0nHTVNlEco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13D1227295;
        Mon, 16 Sep 2019 15:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86D3527294;
        Mon, 16 Sep 2019 15:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] diff, log doc: say "patch text" instead of "patches"
References: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
        <CAN0heSoaYf0_2FhKQNnswLvFppu=dyBcKGYB_Jd=uF70yjNiCQ@mail.gmail.com>
Date:   Mon, 16 Sep 2019 12:58:06 -0700
In-Reply-To: <CAN0heSoaYf0_2FhKQNnswLvFppu=dyBcKGYB_Jd=uF70yjNiCQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 16 Sep 2019 19:19:44
 +0200")
Message-ID: <xmqqv9ts9fox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E033ADA-D8BC-11E9-8436-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Sun, 15 Sep 2019 at 21:26, Johannes Sixt <j6t@kdbg.org> wrote:
>>  I do not have the toolchain to check that a correct result is produce=
d.
>
> But I do. I've tested this patch and 2/2 with AsciiDoc 8.6.10 and
> Asciidoctor 1.5.5, as well as with Asciidoctor 2.0.10 (on top of brian'=
s
> recent patch so that it builds to begin with). They all render this
> nicely.
>
> Both of these patches seem like good changes to me.

Thanks, both.  I am neutral between "patch" and "patch text", but if
the latter is more easily understood by readers, that would be
great.  "patch *file*" certainly does sound misleading.

I wonder if the result becomes even clearer if we dropped "instead
of the usual output".  It is a given that presence of an option
would change the behaviour, so "instead of the usual" does not add
any value in the context of the explanation we are giving.

Also I question the value of the "running git diff without --raw
option" sentence; "diff --stat" is also a way to suppress the patch
text and see only the overview; I know it is not a new problem this
patch introduces, but the objective of this patch is clarify about
the generation of output in patch format, so...
