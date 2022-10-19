Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1959C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJSWBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSWBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 18:01:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F78AD73CF
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 15:01:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E222F1AE3FE;
        Wed, 19 Oct 2022 18:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S+B7g0wvpfoh
        vfNLEbvkpPZhit240k+Wyzf5VgyyTcU=; b=svjZASv1uHAcTerJ2nybJJoiF4kM
        pqdHi6Y/Qoa21IjmQfSV0z1yvx3rh9XXQTuyseO9/sne4bAYAEaHQ3VVc4j8umZI
        mf84A9UNPE2CUendqwA7tI/jTvtdVcGC5Xwj1m2oy0D2nmtiSnoT0Y9GBlLcYEtm
        D5mM8k9bzJt1YSw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D81E41AE3FD;
        Wed, 19 Oct 2022 18:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F06161AE3FA;
        Wed, 19 Oct 2022 18:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
        <xmqqa65rr6g1.fsf@gitster.g>
Date:   Wed, 19 Oct 2022 15:01:22 -0700
In-Reply-To: <xmqqa65rr6g1.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Oct 2022 11:53:18 -0700")
Message-ID: <xmqq4jvzpj65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92668828-4FF9-11ED-8580-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> -- Within a couple of days, someone from the core Git team responds wit=
h an
> -  initial assessment of the bug=E2=80=99s severity.
> +- Within a couple of days, someone from the core Git team, including
> +  the Git maintainer, responds with an initial assessment of the
> +  bug=E2=80=99s severity.

The "including" here looks even less clear.  Does somebody other
than me and I should respond?  That is not what I wanted to say.
Hence ...

> -- Other core developers - including the Git maintainer - chime in.
> +- Other core developers chime in.

... I wonder if it would be better to consolidate the above two into
one bullet point, e.g.

 - The security-list members start a discussion to give an initial
   assessment of the severity of potential vulnerability reported.
   We aspire to do so within a few days.

> -- The Git for Windows, Git for macOS, BSD, Debian, etc maintainers pre=
pares the
> +- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers pr=
epares the
>    corresponding release artifacts, based on the tags created that have=
 been
>    prepared by the Git maintainer.

"prepares" -> "prepare".

>  - Less than a week before the release, a mail with the relevant inform=
ation is
>    sent to <distros@vs.openwall.org> (see below), a list used to pre-an=
nounce
>    embargoed releases of open source projects to the stakeholders of al=
l major
> -  Linux distributions. This includes a Git bundle of the tagged versio=
n(s), but
> -  no further specifics of the vulnerability.
> +  distributions of Linux as well as other OSes. This includes a Git bu=
ndle
> +  of the tagged version(s), but no further specifics of the vulnerabil=
ity.

The bundle contains enough information to recreate these tagged
versions under embargo, hence the release notes for these releases
that discloses the vulnerability.  Perhaps drop "but no further..."?
