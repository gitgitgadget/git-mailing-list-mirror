Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC0C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2AD221F7
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgDPVMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:12:19 -0400
Received: from nef2.ens.fr ([129.199.96.40]:39365 "EHLO nef.ens.fr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbgDPVMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 17:12:18 -0400
X-ENS-nef-client: 129.199.129.80
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 03GLC9ef007019
          ; Thu, 16 Apr 2020 23:12:10 +0200
Received: by phare.normalesup.org (Postfix, from userid 1317)
        id DA14BE9792; Thu, 16 Apr 2020 23:12:09 +0200 (CEST)
Date:   Thu, 16 Apr 2020 23:12:08 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200416211208.xqnnrkvcl2jw3ejr@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 16 Apr 2020 23:03:34 +0200
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Thu, 16 Apr 2020 23:12:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Wed 15 Apr 2020 at 16:01:52 (-0700) :
> * dr/push-remoteref-fix (2020-04-06) 2 commits
>   (merged to 'next' on 2020-04-15 at ecf60dc488)
>  + remote.c: fix handling of %(push:remoteref)
>  + remote.c: fix %(push) for triangular workflows

Hi Junio,

I just sent a new version of this series, which drop the second patch for
now. As outlined in my cover letter in
https://public-inbox.org/git/20200406175648.25737-1-damien.olivier.robert+git@gmail.com/
the triangular workflow patch still leaves some corner cases (and for now
is missing reviews).

I'd prefer to fix all of them at once, rather than have an almost working
patch. Jeff seems to be of the same opinion in
https://public-inbox.org/git/20200406214607.GA1251506@coredump.intra.peff.net/
