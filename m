Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5982BC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39202613F7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhEMDjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 23:39:41 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:1992 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhEMDjk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 May 2021 23:39:40 -0400
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 973EE23D42
        for <git@vger.kernel.org>; Thu, 13 May 2021 03:38:28 +0000 (UTC)
Received: from mailgw-01.dd24.net (100-96-18-74.trex.outbound.svc.cluster.local [100.96.18.74])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 74F8323B9F
        for <git@vger.kernel.org>; Thu, 13 May 2021 03:38:22 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-01.dd24.net (mailgw-01.dd24.net [193.46.215.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.74 (trex/6.2.1);
        Thu, 13 May 2021 03:38:28 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Squirrel-Inform: 24b2c30c7fed85d5_1620877103148_2125421880
X-MC-Loop-Signature: 1620877103148:2026011828
X-MC-Ingress-Time: 1620877103147
Received: from heisenberg.fritz.box (ppp-46-244-246-192.dynamic.mnet-online.de [46.244.246.192])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 3802A5FC32
        for <git@vger.kernel.org>; Thu, 13 May 2021 03:38:19 +0000 (UTC)
Message-ID: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
Subject: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     git@vger.kernel.org
Date:   Thu, 13 May 2021 05:38:18 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there.

Could it be that git-sh-prompt no longer works properly?

With git 2.31.1:
$ . /usr/lib/git-core/git-sh-prompt
$ PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
$ cd someGitRepo
bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
$ 


Cheers,
Chris.

