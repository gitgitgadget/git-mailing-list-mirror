Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8071F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 01:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJOB7Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 21:59:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55232 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJOB7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 21:59:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31F9C25D8A;
        Mon, 14 Oct 2019 21:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OjrsxJ8g26ES
        b3wNJSdgdQcXO3E=; b=LYSu4j0WuucXaE9UJtLQTTaACoXk0ksmuMrJ9NllpS1G
        qFmaswfaLI1299g1ssKzjRvxarh8CzrXNPpemdRexCYO70MFCM1gmZM2XzY2lc+f
        S88+X+PDiXkYDXeHjotxAb6qxhm3UjomlP5vjjgqpzGI+9IOwYEnI68QjtC3444=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dlHqdo
        mw08B2xz9PQu/JaBdEgkFr7fFWBORJfIJjbEPwztGJNfsX+1/rXtiEjHKAYDcisz
        OzPnegmXI5y44IdpfQU3fGUOH0vSfnjqTMCgcPI6/+IS3Hz0N0S5dsHCcSACWQKY
        +yBEG30jfwUvTR3s9u34NTA6sNl2/D4rxEY+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26E7225D89;
        Mon, 14 Oct 2019 21:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 930F725D88;
        Mon, 14 Oct 2019 21:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "kdnakt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, kdnakt <a.kid.1985@gmail.com>
Subject: Re: [PATCH 1/1] Improve Japanese translation
References: <pull.396.git.1571016698.gitgitgadget@gmail.com>
        <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:59:20 +0900
In-Reply-To: <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
        (kdnakt via GitGitGadget's message of "Mon, 14 Oct 2019 01:31:38
        +0000")
Message-ID: <xmqqmue2db0n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67B80502-EEEF-11E9-973D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"kdnakt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -661,7 +662,7 @@ msgstr ""
>  #: lib/merge.tcl:108
>  #, tcl-format
>  msgid "%s of %s"
> -msgstr "%s =E3=81=AE %s =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
> +msgstr "%2$s =E3=81=AE %1$s =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
> =20
>  #: lib/merge.tcl:122
>  #, tcl-format
> @@ -956,7 +957,7 @@ msgstr "=E3=82=A8=E3=83=A9=E3=83=BC: =E3=82=B3=E3=83=
=9E=E3=83=B3=E3=83=89=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
>  #: lib/checkout_op.tcl:85
>  #, tcl-format
>  msgid "Fetching %s from %s"
> -msgstr "%s =E3=81=8B=E3=82=89 %s =E3=82=92=E3=83=95=E3=82=A7=E3=83=83=E3=
=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
> +msgstr "%2$s =E3=81=8B=E3=82=89 %1$s =E3=82=92=E3=83=95=E3=82=A7=E3=83=
=83=E3=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"

Both of these changes to word order make sense.

It's a bit surprising that these haven't been noticed/fixed for
quite some time ;-).
