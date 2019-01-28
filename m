Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660C3211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 05:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfA1FYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 00:24:42 -0500
Received: from mta-10-3.privateemail.com ([198.54.127.62]:59889 "EHLO
        MTA-10-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1FYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 00:24:41 -0500
X-Greylist: delayed 9779 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 00:24:41 EST
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
        by MTA-10.privateemail.com (Postfix) with ESMTP id 59F2A60041;
        Mon, 28 Jan 2019 00:24:41 -0500 (EST)
Received: from MacMini.local.mail (unknown [10.20.151.221])
        by MTA-10.privateemail.com (Postfix) with ESMTPA id B81E660038;
        Mon, 28 Jan 2019 05:24:40 +0000 (UTC)
Date:   Mon, 28 Jan 2019 06:24:39 +0100
From:   Sebastian Gniazdowski <psprint@zdharma.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <etPan.5c4e9217.46ea0041.4d5@zdharma.org>
In-Reply-To: <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
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
> On Mon, Jan 28, 2019 at 9:54 AM Sebastian Gniazdowski
> wrote:
> >
> > Hello,
> > Could a .gitbless file be a solution? I would list in it, e.g.:
> >
> > TODO
> >
> > and this way be able to use `git -dxf' again. What do you think?
> 
> There's a patch that adds "precious" git attribute [1]. I was going to
> resend once the backup-log [2] got reviewed but I might just send it
> separately to handle the "git clean" case alone.

That would be nice solution. In the email, you ask for a name other than "precious". So maybe "blessed"?

-- 
Sebastian Gniazdowski 
News: https://twitter.com/ZdharmaI
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
Blog: http://zdharma.org

