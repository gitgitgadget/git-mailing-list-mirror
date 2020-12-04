Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E02C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B668F2078D
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLDXPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:15:17 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46834 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLDXPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:15:17 -0500
X-Greylist: delayed 3570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 18:15:17 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 5CFDC1325;
        Sat,  5 Dec 2020 00:14:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SHEHp73tfB0O; Sat,  5 Dec 2020 00:14:35 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 1CC5C12F2;
        Sat,  5 Dec 2020 00:14:35 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1klKHZ-00Cb5X-Kv; Sat, 05 Dec 2020 00:14:33 +0100
Date:   Sat, 5 Dec 2020 00:14:33 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: check result of index_pack_lockfile
Message-ID: <20201204231433.w2iaj4q42ubc7cbs@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org>
 <xmqqwnxxcht4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnxxcht4.fsf@gitster.c.googlers.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, le ven. 04 déc. 2020 14:44:39 -0800, a ecrit:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > The fetch-pack command may fail (e.g. like in test 15 - fetch into corrupted
> > repo with index-pack), in which case index_pack_lockfile will
> > return ...
> 
> Thanks.
> 
> It sounds like the same as 6031af38 (fetch-pack: disregard invalid
> pack lockfiles, 2020-11-30), which came from
> 
>     Message-Id: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>

Oh, indeed!  I hadn't realized there was a "next" branch.

Samuel
