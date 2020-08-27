Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F6C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2E6207DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="CZFgd+ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgH0TWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:22:49 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47620 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgH0TWs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598556168; bh=5L37yezw5U2+VD3RL7GkajsAjasIMcWlRUM+PXbhXaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To;
        b=CZFgd+pswL2nmxMt+W31QJXonMqPSwZ8I5mart4JtxNcQfzVjcqEMg+h5FHvZlvwK
         Pl/QrZAnPBJxsWIMRRZ2ssrZkJF/nGUpiDmuYxVxcXeEJLlHalN5rzvIQxNybnJHYA
         ZGXJtBM54F5HdxaFIR6uw2Z8FKzqcOADqd69W1kk=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Date:   Thu, 27 Aug 2020 15:22:32 -0400
Message-Id: <C580V29CV3CD.206BQIAA5KQKM@homura>
In-Reply-To: <xmqqy2lzq4h4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 3:21 PM EDT, Junio C Hamano wrote:
> Yes, and I'd assume most mailing list have a single to: address, and
> people use a repository to interact with just a single project, so I
> think it would be natural to have it in the per-repository
> configuration file. Is it true that you do not set it and that the
> lack of the configuration is why you are getting prompted?

No, this didn't make sense, I was mistaken. This shouldn't be the cause.
