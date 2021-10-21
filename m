Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C616C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A56361A4F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 17:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJUR1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:27:55 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:44779
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJUR1z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Oct 2021 13:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=cessssaigkdq5uletp7pzdlghxldyiuc; d=coderkalyan.com;
        t=1634837138;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:To;
        bh=lIeLOTZJ6LNqjShTcrRLUoBf+Jl3Qul2eJmdeCIqpTo=;
        b=IU0gQYopUuC3Z0qPiHeLJYnJuBLW/gNduq61J5DJIrhN1qds35/dZ7IsygHi1Pf1
        NjO5EyPSu/Y4t3NMlvPq6rNS96uQsKyehQSoelBmQjkHzugf4XTC1dYgs5X/zDG1d/q
        /elV8jdsjYfqCIwrq0xGZt+vIsKX2sPCCq6FrNzQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1634837138;
        h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:To:Feedback-ID;
        bh=lIeLOTZJ6LNqjShTcrRLUoBf+Jl3Qul2eJmdeCIqpTo=;
        b=jP6I5J1dy3BNDI7iNxGonpXN8yPOm+XBD3NljC4zzz6jG9rP9stYmt2FnrJn8w+K
        ubVjLYyhodmFHqYnfJ9KJ+DFotWoOxwD7ocwF/n+9aP9WaXD76Ki8ihyw4XFlOsYNnJ
        NLaUY7hqte9tzcCDOrFxU7Jalke0yqMqbVXEFdq4=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 21 Oct 2021 17:25:38 +0000
Message-ID: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
Subject: Git submodule remove
From:   "Kalyan Sriram" <kalyan@coderkalyan.com>
To:     <git@vger.kernel.org>
Feedback-ID: 1.us-west-2.6woXiZ10/hvs78i2LW4ugcJq1GLEuVeUxt3YeADpvNg=:AmazonSES
X-SES-Outgoing: 2021.10.21-54.240.27.18
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I was curious why git-submodule does not have an `rm` command. Currently
I have to manually delete it from .gitmodules, .git/config,
.git/modules/, etc. See [0].

I'd like to contribute my first patch to this project by adding this
feature, but wanted to check first with the community if there's any
particular reason it was chosen not to not be implemented, or if it's
simply that nobody has gotten around to it - it seems to be a relatively
common feature someone might want.

Anyway, please let me know if this is something that would be accepted,
or if anyone has any comments or suggestions.

Thanks!
Kalyan

[0] https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial#Removal
