Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4325C433F5
	for <git@archiver.kernel.org>; Sat, 28 May 2022 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiE1RYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiE1RYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 13:24:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0311A29
        for <git@vger.kernel.org>; Sat, 28 May 2022 10:24:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2E6E18E4D7;
        Sat, 28 May 2022 13:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kPYITT1WliDK
        UOyMPBIO3swAOW8l1FD7ubAn7eYCkc8=; b=YHs+hCK8HQ5hkybGnTAdLfwYWFr+
        r1oYuNj4Ll0BQ8s46FqRp4kaLJiehGGITzu5FufjuwuPTI5wXUIdLWlhxpsvOC33
        dHTTsdN4lx67zJe6aK36H2n4dt7QtdqvAIVc8kBAg2V8VUsYLt1PF8bY3tjDQkEU
        QfiUbUJjuKl7tPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBA4318E4D6;
        Sat, 28 May 2022 13:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9265F18E4D4;
        Sat, 28 May 2022 13:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
        <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com>
Date:   Sat, 28 May 2022 10:24:15 -0700
In-Reply-To: <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 28 May 2022 17:53:35 +0200")
Message-ID: <xmqqr14dzi2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0038DC2C-DEAB-11EC-9598-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But the commit message & documentation here really should be updated to
> reflect that this is currently superfluous to inspecting argv in the
> hook process, and that we're providing this anyway for XYZ reason.

Or this probably is better added as part of the series that actually
adds the mechanism to trigger hooks defined in the configuration
file. =20

Then "we do not need it now, but we will in the future because we
will do XYZ" does not have to be said, which is a huge plus.

Thanks.
