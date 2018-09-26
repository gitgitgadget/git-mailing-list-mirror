Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0DE1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeI0DwH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:52:07 -0400
Received: from mx.sdf.org ([205.166.94.20]:52366 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeI0DwH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:52:07 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w8QLb35h013127
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 21:37:03 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w8QLb3ds003106
        for git@vger.kernel.org; Wed, 26 Sep 2018 21:37:03 GMT
Date:   Wed, 26 Sep 2018 21:37:03 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     git@vger.kernel.org
Subject: Re: Fixing constant preference prompts during tests
Message-ID: <20180926213703.GA22278@SDF.ORG>
Mail-Followup-To: git@vger.kernel.org
References: <20180926162638.GA28077@SDF.ORG>
 <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 10:15:06AM -0700, Junio C Hamano wrote:
>Nobody raised this so far as far as I recall; thanks for the first
>one to do so, as it is a sign that you are doing something unusual
>(e.g. have newer or different version of GPG than most other people)
>and others will hit by the same symptom later when whatever thing
>you are using as a minority right now becomes more prevalent.

Indeed I am. I use Qubes OS with a split GPG setup. I have a virtual machine 
dedicated to handling my crypto keys and I use the qubes GPG wrapper to 
interact with the signing VM through the Xen hypervisor. I think the only thing 
that needs to change is that the tests respect gpg.program setting in 
.gitconfig. Signing and verifying commits and tags works perfectly but the 
tests don't allow me to override which program is used.

It may be a little more complicated than this because looking at the tests it 
seems like they set up their own dummy user with dummy keys and use gpg 
directly. I have gpg installed on my client VM so in theory it should work. I 
can't tell exctly where the prompt is coming from.

//tæ
