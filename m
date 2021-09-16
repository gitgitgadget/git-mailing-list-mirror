Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3FC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD66113E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhIPMs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:48:56 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:50098 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhIPMsz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 08:48:55 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id ACF0D295FD;
        Thu, 16 Sep 2021 14:47:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id EF5AC294C8;
        Thu, 16 Sep 2021 14:47:32 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id klgxI_nh-tPw; Thu, 16 Sep 2021 14:47:32 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 204B0293F0;
        Thu, 16 Sep 2021 14:47:30 +0200 (CEST)
From:   wesley@schwengle.net
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com
Subject: Re: Possible git bug
Date:   Thu, 16 Sep 2021 08:47:08 -0400
Message-Id: <20210916124709.2824551-1-wesley@schwengle.net>
X-Mailer: git-send-email 2.33.0.364.gff7047fb76
In-Reply-To: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=7QKq2e-ADPsA:10 a=Refv260EGrHykDaHKwIA:9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/16/21 8:07 AM, Wesley Schwengle wrote:
=20
> New question, is there a way to tell rebase to NOT use fork-point via=20
> git-config in this situation?

I seem to have found the answer in the source code: rebase.forkpoint exis=
ts.

Would you accept the following patch that adds the following text to the
documentation?

Cheers,
Wesley

