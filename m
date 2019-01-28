Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAEE1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1Pae (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 10:30:34 -0500
Received: from mta-06-3.privateemail.com ([198.54.127.59]:37534 "EHLO
        MTA-06-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Pae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 10:30:34 -0500
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id 19F266003D;
        Mon, 28 Jan 2019 10:30:34 -0500 (EST)
Received: from MacMini.local.mail (unknown [10.20.151.235])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id 746D96004B;
        Mon, 28 Jan 2019 15:30:33 +0000 (UTC)
Date:   Mon, 28 Jan 2019 16:30:31 +0100
From:   Sebastian Gniazdowski <psprint@zdharma.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <etPan.5c4f2017.992f4fd.4d5@zdharma.org>
In-Reply-To: <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
 <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
 <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
 <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
Subject: Re: There should be a `.gitbless; file, protecting files from
 git clean
X-Mailer: Airmail (528)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28 stycznia 2019 at 06:05:31, Duy Nguyen (pclouds@gmail.com) wrote:
> There's a patch that adds "precious" git attribute [1]. I was going to
> resend once the backup-log [2] got reviewed but I might just send it
> separately to handle the "git clean" case alone.
> 
> [1] https://public-inbox.org/git/20181111095254.30473-1-pclouds@gmail.com/ 
> [2] https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.com/ 


The backup log, if done properly, could allow to use git more freely, without nerves that something will beak. I wonder if it could restore also the state before an improper `git clea -dxf' call? I think the chances are low, because this would requrire to save untracked files, but it's worth asking?

-- 
Sebastian Gniazdowski 
News: https://twitter.com/ZdharmaI
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
Blog: http://zdharma.org

