Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5F9C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 15:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiKJPKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKJPKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 10:10:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E5303D2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093024; bh=hLVDqCYaxyB1CWxG1dR9IIW05u5TsMQhO4+CSldcyz4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V6K1Gzb4g+9kubSwzRIC4ETEcPoz1UQlBmE3PVaf9rM79qCobWdN5V50mFLIpeBpa
         8lTLrDBbyxJD8TsV5VqtSmzfPu1iqWfzSXpacPn+VPBO2rOr/eD9CjQyvTJTSbkwXJ
         GhlJFRux8wH9Ehi0ZbcFPjXjDOw6jWnEo4y89WlU35zg0/1m/eBcRTn6BpUKY/HLL/
         H7U15nsRpxu6fuv9A6dHjpQxXGmibReuj3X9wYDSU6e6jArXt4iP7Np3Im2QxIOWF0
         8cjgMic2iF2BlqbBcRjP2NNyi+iMgt0GY6bKcNgsOfPGCCsbcKY+vM8B1GBcU85k5P
         BAq17Uejy0VZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1pA7ui3dcF-00sv2e; Thu, 10
 Nov 2022 16:10:23 +0100
Date:   Thu, 10 Nov 2022 16:10:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Michael McClimon <michael@mcclimon.org>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
In-Reply-To: <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
Message-ID: <28orrrr1-444q-6595-po76-3nr67r1pp4p0@tzk.qr>
References: <20221016212236.12453-1-michael@mcclimon.org> <20221016212236.12453-2-michael@mcclimon.org> <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net> <Y0y7UdLf3qd7RgVQ@newk> <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FRBpJFYh/b4w4G7PUCwM6nO4IagAZuKM3CjntQNc4X917hEoKkq
 z17qPnWJP02JmB/amnFrK6PX2gs10ofCuWjaVgWJKE8a7YYPtjbpD6iTc72xsXdZxtnrHGt
 PO6SSIfF/rviOSN4dSnV9BTm2VgsCq04gDzYD9b8A5DUtwKh/5CyyoofEn5qX8X31k/GFJj
 SpIQUFXV7fmw9xHMu2cvQ==
UI-OutboundReport: notjunk:1;M01:P0:YKCqxMuIcXg=;Bj7fFYViDKK8yc7dNH1v2tPoTU3
 QjPQMCtCs+U2H76/a8V1QEzECQ2+bIPB5FfkpHp94sVc49tI9DekdFZDmXYxOezceL565yGla
 rDYjkMnWQStcuzpJpfbfn/oFrVjDxglibMPUiBXtYumC1P8pqlIh7DMdHLMameFur0eL8kSC1
 iLdICN4QK4ibFxTApkEN04heu172IzcPXAw9v1hfsaybSfyo1ReEbbX+GsXtAhNx0HtmwgJ0U
 uoUkt2F0VAp+MtrA3nprUmc03BLoJvIMznqe8IT3X52n2SpRcZvbNpyY4+i8DEiSmFREqPR7/
 1r9zv2cn2T7EggGpNX3i//UXixa8FxD23ZpzFK9doUUTKOwC8o1CZKJJsM3ASog8j5MTt3T8W
 mnGZuBN29gYVdOOMJDeEjxez9yP3sk0JlxaFK8B+euIkqhl7RSqZiyS26NWM6wAXEkFp+eg9d
 TPP+QmkX+xtuiW0+J/53c4MEjBsIgjvTYQrMkL1uXHiQXfRb1PgJGXJCHNZtNfyEWZn99+x2Y
 CWjXSc+KWY+RM2RmQ1j95wP5PFlkWn/Lr2avGV2JCA9p5AAQLBkAaugBFsnOFq6lKQuQKbfsa
 7lhSpczmi34kbIHuhHw/fIUP1xdCq3O9QYdn+FdBZCEwHmbi/nhiBQj9PPpZviRh7E77bMUkq
 Llv/uxGgQ7Uo0CvEg1iqia9sR6F/4QDd5IgkS68vvBMQJD0rVUD3i2gIgpu2KGRAbO73F6EJ8
 jHzRlpDjrOaio4ggpdY0QVEJHq4pfeOYAm7o5QhrAcls9Mx+0Df2xgYUM6KBSDkAfLuaV609r
 0zrbvE76Ti1XjGkpmMOAdJK8fxwUrAoDEYAxwEwiJW7Owm0oYZIaO2a4CFC1uW0+reKSUJVg8
 JEj4jJnHLgIdqCzgJthSzMjO4dvZ869B1f1PAcC08AKejCZFD9QGtUxXTlnNkij2Gx/p6sL0U
 s5biimTsY5A+4hZY3nO4mxpFzq8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 17 Oct 2022, Jeff King wrote:

> [... talking about safe.directory ...]
>
> But curiously this still does not pass after your patch, because we seem
> to actually open the repository! I think this is because the C code
> allows an explicit GIT_DIR to override the safe-directory checks.

Yes, I remember that this was something we discussed at some length during
the embargo: what to do with the explicitly-specified `GIT_DIR` when
verifying the ownership, and my recollection is that we asserted that
setting `GIT_DIR` qualifies for "they know what they're doing" (in
particular when it is done in a script, not interactively).

Ciao,
Dscho
