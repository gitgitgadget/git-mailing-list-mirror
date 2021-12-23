Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93356C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhLWAaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:30:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61416 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhLWAai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 19:30:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D34516313E;
        Wed, 22 Dec 2021 19:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ew/UZgOT/yzD
        ET8fKRJ2+vSCDRnz6qi95Cr7aeMW8tQ=; b=o49oYcwa03IyfstmNMgNDPD2nCiU
        4wrm0ae4OVbRERWYyXjfDpR0qZwpNyMJdL1L0YgGx0or6p3Ek7aZ0la+PAGx2GeL
        myCp0JB2/YLFl5dlr+2IXRoKmUohfyS9QGagZ7BU+n+EjEvwzztqze6bQjvBviYL
        xhaLXjHZlzt8wdU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3597716313D;
        Wed, 22 Dec 2021 19:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9285916313B;
        Wed, 22 Dec 2021 19:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 0/7] grep: simplify & delete "init" & "config" code
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
Date:   Wed, 22 Dec 2021 16:30:32 -0800
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Dec
 2021 03:58:50
        +0100")
Message-ID: <xmqqy24ccgd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A7312DA-6387-11EC-8069-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A simplification and code deletion of the overly complex setup for the
> grep API, no behavior changes. For v4 see:
> https://lore.kernel.org/git/cover-v4-0.7-00000000000-20211203T101348Z-a=
varab@gmail.com/
>
> This re-roll is rebased on the latest push-out to "master", now-landed
> topic had a minor conflict with it in git.c.

I understand that this has no changes other than the rebase to
adjust for the "even when we are running 'git cmd -h', make sure we
try to find where the git repository is (gently)".  Am I correct?

I am not complaining for lack of improvements or anything.  I am
only making sure that I am applying the right version to a right
base.

THanks.
