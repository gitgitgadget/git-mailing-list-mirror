Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8262C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743D2207CD
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="nodd9Ops"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgH0TPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:15:05 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47578 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgH0TPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598555704; bh=N9CEIlQ3/fjfg66V4Eft3LEBmKJ3gOfy4gTF/M0bpKI=;
        h=To:Cc:Subject:From:Date:In-Reply-To;
        b=nodd9Ops54e5Ge/F21m8KQILYxxaNdI9LsES2UvM4iM6wxn45TZpXGNLsDLGoh1Fc
         pFSifHzyw9fev71xIto9lPdYhaBTiFApebWZWb1uxgbFxTkehMw9Mg/nolsRz+UUZC
         0hOExHCFiGeJmYPik1gj+lnuSFKp/X9pDr28BoZg=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
Date:   Thu, 27 Aug 2020 15:14:57 -0400
Message-Id: <C580P9BS4VYA.15I6SHXQQ35HF@homura>
In-Reply-To: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do you have sendemail.to set in your local git config?
