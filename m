Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0AAC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjG1CHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 22:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjG1CHg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 22:07:36 -0400
X-Greylist: delayed 102309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 19:07:34 PDT
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882032D75
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 19:07:34 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690510051; x=1690769251;
        bh=ODqrZrs3J5gJ1W6Ords8jv4K2/CVnu6XhLJVL5bSIIQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=B7qUZcB3wJdxOf0+x0g7VbfGRkRAeuxLdp5yXmoWUXEQwQje9hAhmeNQq0/iIZdYj
         sdG85wThmUbD+9bHPXfrbeY2110/S6EMCyO2+JWktOvuwkVhVZKMtBE1dCS88VUj3t
         rTyYCAT9pAnWw63xEuISql9dVHYMcEGfUfYUptXLPDbcwvQR6FedayTNmw6NsE7+0i
         tE2RbZ/zs2F+y5lBgmX8zrywqwNM3u1r17yZxD+KhksXoUc4oKdBpYc3JGxYJ4b5Bu
         mGx4Yv9SbvX4/b06GIqfo3NkkODxpcTdB/3A4MBkRwTQU5TP+9yPZXwHe93o1z6lit
         5DkyoWO+CxXPQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too much
Message-ID: <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5>
In-Reply-To: <xmqqmszg987u.fsf_-_@gitster.g>
References: <xmqq3583uyk0.fsf@gitster.g> <20230122071156.367jwwt3d5txvkl4@tb-raspi4> <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g> <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4> <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com> <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/27 05:43PM, Junio C Hamano wrote:
> Finding mistakes in and improving your own patches is a good idea,
> but doing so too quickly is being inconsiderate to reviewers who
> have just seen the initial iteration and taking their time to review
> it.  Encourage new developers to perform such a self review before
> they send out their patches, not after.  After sending a patch that
> they immediately found mistakes in, they are welcome to comment on
> them, mentioning what and how they plan to improve them in an
> updated version, before sending out their updates.
>=20
> [...]
>
> +Please be considerate of the time needed by reviewers to examine each
> +new version of your patch. Rather than seeing the initial version right
> +now (followed by several "oops, I like this version better than the
> +previous one" patches over 2 days), reviewers would strongly prefer if a
> +single polished version came 2 days later instead, and that version with
> +fewer mistakes were the only one they would need to review.
> +
> +
> [...]

Speaking as a fairly green contributor to the project, it may be helpful
to include some guidance on what is "too long" vs "too short" when
waiting to send out the next revision.=20

Likewise it may be worthwhile to mention how the expected "minimum time
between revisions" will generally shrink as you get to higher revision
counts and fewer changes between revisions.

