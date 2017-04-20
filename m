Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URI_HEX shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C76207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971382AbdDTViu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:38:50 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56685 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S971369AbdDTVit (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Apr 2017 17:38:49 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3D9FA9E2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 17:38:48 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute7.internal (MEProxy); Thu, 20 Apr 2017 17:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=6qTM15mJZe51A7LvcTLIsVQ5Uf73RQDcH27RqUjRBeg=; b=T+ZlSJ2H
        3+dnUR8qITuVy1qpWzxbtXjLuvTXuJrYl7QawaC7ChZrJsE6wPsspCnD8YEjMpzm
        8zmkk3G+6QYtNPH1L5U/ntF6I1l7EZ3I5bPxip6xFi7jvH4rGOQx/w7CcWGYnjYw
        EUyd9VUsiyOfoiL6YMZzWzeNiPaYg7IWZp8K8K3Ts1pCOlVMNPvKE1TuKTET4GRJ
        2G5zC6XxuVSQ7ZMr6oDgU9yVjTI/vyxKOaiPEyTln/1XaykFLXGB0f3efhhu9/qg
        eu5ITqBCrtR6hAojLIsXZvJhjXHoOGJIqNmcRrNZX9B24Md58BPpncgACdXO0frG
        amMu7kHH7EfOOg==
X-ME-Sender: <xms:aCr5WAE_k7_nvlTbiO8tzwvzoKvdiRQFJyKghU-Du3oSpF0kjF2fww>
X-Sasl-enc: zBIvKc3P051GseU++jje2bnjlFC1Otd/pK7ef+mYRIlf 1492724327
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id C630724370
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 17:38:47 -0400 (EDT)
Date:   Thu, 20 Apr 2017 14:38:47 -0700 (MST)
From:   galt <galt@folkplanet.com>
To:     git@vger.kernel.org
Message-ID: <1492724327147-7657474.post@n2.nabble.com>
In-Reply-To: <4A951EFB.1010400@draigBrady.com>
References: <4A85F270.20703@draigBrady.com> <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com> <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain> <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain> <alpine.LFD.2.00.0908162151180.6044@xanadu.home> <4A951EFB.1010400@draigBrady.com>
Subject: Re: Linus' sha1 is much faster!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Ph=C3=A1draig, c=C3=A1 bhfuil t=C3=BA i do ch=C3=B3na=C3=AD?
T=C3=A1 m=C3=A9 i gCalafoirne.



--
View this message in context: http://git.661346.n2.nabble.com/Linus-sha1-is=
-much-faster-tp3448007p7657474.html
Sent from the git mailing list archive at Nabble.com.
