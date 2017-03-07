Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C4C202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 09:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbdCGJHi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Mar 2017 04:07:38 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33054 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755266AbdCGJHf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2017 04:07:35 -0500
Received: from app04.ox.hosteurope.de ([92.51.170.11]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:128)
        id 1clB5g-00058u-OM; Tue, 07 Mar 2017 10:07:32 +0100
Date:   Tue, 7 Mar 2017 10:07:32 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Marius Storm-Olsen <mstormo@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <1831082528.2738206.1488877652752.JavaMail.open-xchange@app04.ox.hosteurope.de>
In-Reply-To: <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com> <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com> <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com> <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com> <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com> <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com> <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
Subject: Re: Delta compression not so effective
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev61
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1488877655;6b842616;
X-HE-SMSGID: 1clB5g-00058u-OM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Marius Storm-Olsen <mstormo@gmail.com> hat am 4. März 2017 um 09:27
> geschrieben:

[...]

> I really don't want the files on the mailinglist, so I'll send you a 
> link directly. However, small snippets for public discussions about 
> potential issues would be fine, obviously.

git fast-export can anonymize a repository [1]. Maybe an anonymized repository
still shows the issue you are seeing.

[1]: https://www.git-scm.com/docs/git-fast-export#_anonymizing
