Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9851C43219
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353670AbiBGL7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383262AbiBGLV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 06:21:57 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08564C043188
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 03:21:55 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCED8184744;
        Mon,  7 Feb 2022 06:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ZWUuPHcN+X6Ct3v0w7khtOOCb
        kaW/IckZYALhs5jHto=; b=hYLu6mQWZ1AqwfdYm0pwchwyrR2bFowemZ3Xkz2LT
        0P/K9E9gSdgzFeDTh8gP/dddfi1TFuoAZr98IEQSCcaeY5j2zs0WFGpGmk86BL1l
        EmseMIcxN9jYjxjrPGeh5A7ViamuYVgOFRMkvNNXcQXFwvzANTmz5KWirkWPoIKg
        9s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B93B0184742;
        Mon,  7 Feb 2022 06:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11EE0184741;
        Mon,  7 Feb 2022 06:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [RFC] clarify licensing terms for .git/hooks/*.sample files
References: <xmqqzgn3185p.fsf@gitster.g>
Date:   Mon, 07 Feb 2022 03:21:49 -0800
Message-ID: <xmqqh79aj50y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25707832-8808-11EC-BC42-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> +----
> +
> +NEEDSWORK:
> +
> +Below are draft entries that do show correct commit object names that
> +matter to, or contributors who write, the surviving contents of the
> +file, but these people haven't been asked to do anything yet (hence
> +they haven't responded yet, of course), so they do not show what the
> +licensing status of these files will be at the end of this exercise
> +yet.
> +
> +What I am hoping to achieve is to replace the text under each bullet
> +point to document who the authors/copyright holders are of the file,
> +and under what license the copy given to each end-user repository is
> +usable by the end-user.  It would be more useful if the license chosen
> +(which can be different per file) is more lenient than strict.
> +
> +----

In other words, what I had in the rest of this file was more like
working notes for us to keep track of what we learned about the
code, whom to contact, and later when we accumulate Acks, record
them.  The goal is to turn each of these entries into this form:

----

    * pre-frotz.sample

    The authors of this sample hook script have agreed to relicense
    this under the ABC license (https://opensource.org/licenses/ABC).

    Junio C Hamano <gitster@pobox.com>
    cf. https://lore.kernel.org/git/xmqqzgn3185p.fsf@gitster.g/

    A U Thor <au@thor.xz>
    cf. ...

----

where the references will show readers the relevant record.

Thanks.


> +* applypatch-msg.sample
> +
> +    This sample hook script was written in 2005 by Junio C Hamano, who
> +    hereby clarifies that the contents of these files, when used as a
> +    hook script installed by "git init", or manually copied by the
> +    user, is licensed under the MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version, will be asked to
> +    endorse this clarification later.
> +
> +    Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> +    b849b954d22ee069b0edec1a12c78782ae1e629d (adjust for newer Git)
> +
> +
> +* commit-msg.sample
> +
> +    This sample hook script was written in 2005 by Junio C Hamano, who
> +    hereby clarifies that the contents of these files, when used as a
> +    hook script installed by "git init", or manually copied by the
> +    user, is licensed under the MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Ben Walton <bdwalton@gmail.com>
> +    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
> +
> +    Paolo Bonzini <bonzini@gnu.org>
> +    8089c85bcba89464b9b2a32fa948ed85eb367e70 (advice against 59f3e254)
> +
> +    Luben Tuikov <ltuikov@yahoo.com>
> +    9a1ae9ab03abaffc977421f182997f3e735e7098 (make failure louder)
> +
> +    Andy Parkins <andyparkins@gmail.com>
> +    59f3e254801648322b2d5cd073ca0cc5009aa2de (hint to auto-add -s)
> +
> +    Junio C Hamano <gitster@pobox.com>
> +    89e2c5f17b901edf28a8bb778ece3f6c18bbb721 (initial version in 2005)
> +
> +
> +* fsmonitor-watchman.sample
> +
> +    Alex Vandiver <alexmv@dropbox.com>
> +    Ben Peart <benpeart@microsoft.com>
> +    Kevin Willford <Kevin.Willford@microsoft.com>
> +
> +
> +* post-update.sample
> +
> +    This sample hook script was written in 2005 by Junio C Hamano, who
> +    hereby clarifies that the contents of these files, when used as a
> +    hook script installed by "git init", or manually copied by the
> +    user, is licensed under the MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Ben Walton <bdwalton@gmail.com>
> +    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
> +
> +
> +* pre-applypatch.sample
> +
> +    This sample hook script was written in 2005 by Junio C Hamano, who
> +    hereby clarifies that the contents of these files, when used as a
> +    hook script installed by "git init", or manually copied by the
> +    user, is licensed under the MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> +    b849b954d22ee069b0edec1a12c78782ae1e629d (adjust for newer Git)
> +
> +
> +* pre-commit.sample
> +
> +    Even though the history of this file dates back to 2005, the
> +    current version contains no material from commits before 03e2b630
> +    (Update sample pre-commit hook to use "diff --check", 2008-06-26),
> +    which was written by Junio C Hamano, who hereby clarifies that the
> +    contents of these files, when used as a hook script installed by
> +    "git init", or manually copied by the user, is licensed under the
> +    MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Jim Meyering <jim@meyering.net>
> +    c646217e1366b0397552fad8c32acb47fbe8977d
> +    f1e3156e627fa66714deea665c8f3585088b9695
> +    c14daa4845ff2ec0d27807fa50f9fac1ca4d6462
> +
> +    Heiko Voigt <hvoigt@hvoigt.net>
> +    d00e364de99d51bb76e437820e23cfa820417ec5 (non-ascii pathname check=
)
> +
> +    Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> +    c30eb852e281d55b04465b7814e00396893f74f3 (initial commit check)
> +
> +    Richard Hartmann <richih.mailinglist@gmail.com>
> +    27b6e17a6d84a18861f05fd7c684ab443bf15244
> +
> +    Johan Herland <johan@herland.net>
> +    af1748b31eb68643f1b8d9d918f43611cf96d257
> +
> +    brian m. carlson <sandals@crustytoothpaste.net>
> +    03a7f388dafaee0aa084144efe7a8f9c151e5221
> +
> +    Lucius Hu <orctarorga@gmail.com>
> +    81e3db42f3212a8e441e4ecee9a2928921cb9045
> +
> +
> +* pre-merge-commit.sample
> +
> +    Michael J Gruber <git@grubix.eu>
> +    6098817fd7f64209664c701df30096dc0f4fb876
> +
> +* prepare-commit-msg.sample
> +
> +    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> +    b22a3079466b72e8a8b76065d6c28efe7eea4b16 (clean-up)
> +
> +    Ben Walton <bdwalton@gmail.com>
> +    502be959531b34e2d9283213b7bca51842639240
> +    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
> +
> +    Alex Riesen <raa.lkml@gmail.com>
> +    3015fa5846c19e79f99c1d6a49fd2510ed9291b8
> +
> +    Marcel Koeppen <git-dev@marzelpan.de>
> +    4be1fe1b944e568f47efcb9d1beb8639f50b723f
> +
> +    Paolo Bonzini <bonzini@gnu.org>
> +    8089c85bcba89464b9b2a32fa948ed85eb367e70 (initial version in 2008)
> +
> +* pre-push.sample
> +
> +    Denton Liu <liu.denton@gmail.com>
> +    6a117da6e523a82115733682f4d3f59755897d5a
> +    8c7e5059506c6840bfbd4dd8d1730784a5689719
> +
> +    W. Trevor King <wking@tremily.us>
> +    1a947ba3a3eebea80be6a6d1000614884807bc8b (adjust behaviour to BCP)
> +
> +    Aaron Schrab <aaron@schrab.com>
> +    87c86dd14abe8db7d00b0df5661ef8cf147a72a3 (initial version in 2013)
> +
> +
> +* pre-rebase.sample
> +
> +    This sample hook script was written in 2006 by Junio C Hamano, who
> +    hereby clarifies that the contents of these files, when used as a
> +    hook script installed by "git init", or manually copied by the
> +    user, is licensed under the MIT license [*2*].
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Ben Walton <bdwalton@gmail.com>
> +    502be959531b34e2d9283213b7bca51842639240 (adjust for newer Git)
> +    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
> +
> +    Jonathan Nieder <jrnieder@gmail.com>
> +    8db1ae57409b10ba48596198b329adba7fcb6b1a
> +
> +    Martin =C3=85gren <martin.agren@gmail.com>
> +    7560f547e614244fe1d4648598d4facf7ed33a56 (phraso)
> +
> +* pre-receive.sample
> +
> +    Stefan Beller <stefanbeller@gmail.com>
> +    77a9745d19b2b308c1ce97d18053322d1471bc4c (initial version)
> +
> +* push-to-checkout.sample
> +
> +    Adam Spiers <git@adamspiers.org>
> +    e632c464d5dbbda72ae370ff6e9cbe31c01b0bb0 (initial version)
> +
> +* update.sample
> +
> +    Even though the history of this file dates back to 2006, the
> +    current version contains no material from commits before a69aba6a
> +    (UNIX reference time of 1970-01-01 00:00 is UTC timezone, not
> +    local time zone, 2007-01-26), which was written by Andy Parkins.
> +
> +    Andy Parkins <andyparkins@gmail.com>
> +    a69aba6af3e96f8021c194691a851e78febd70bf (base version)
> +    829a686f1b50ba96cac2d88494fa339efe0c0862 (enhancement)
> +
> +    The following contributors, who may have made copyrightable change
> +    that still remains in the current version will be asked to endorse
> +    this clarification later.
> +
> +    Gerrit Pape <pape@smarden.org>
> +    Alexandre Julliard <julliard@winehq.org>
> +    Pavel Roskin <proski@gnu.org>
> +    John Tapsell <johnflux@gmail.com>
> +    Pierre Habouzit <madcoder@debian.org>
> +    Heiko Voigt <hvoigt@hvoigt.net>
> +    David Aguilar <davvid@gmail.com>
> +    Martin Amdisen <martin.amdisen@praqma.com>
> +    Lucius Hu <orctarorga@gmail.com>
> +    Denton Liu <liu.denton@gmail.com>
> +
> +
> +[References]
> +
> +*1* https://opensource.org/licenses/GPL-2.0
> +
> +*2* https://opensource.org/licenses/MIT
