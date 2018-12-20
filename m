Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64B61F405
	for <e@80x24.org>; Thu, 20 Dec 2018 18:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbeLTS2c (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 13:28:32 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52750 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732679AbeLTS2b (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Dec 2018 13:28:31 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ga33d-0003xM-JI; Thu, 20 Dec 2018 19:28:29 +0100
Subject: Re: rebase: Ask before doing anything not undoable
To:     Ricardo Biehl Pasquali <pasqualirb@gmail.com>, git@vger.kernel.org
References: <20181220173348.GA5203@localhost.localdomain>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <3a7a52c3-3ae7-6e5e-b660-49fb21dc7d17@virtuell-zuhause.de>
Date:   Thu, 20 Dec 2018 19:28:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181220173348.GA5203@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1545330510;2a0cad30;
X-HE-SMSGID: 1ga33d-0003xM-JI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2018 um 18:33 schrieb Ricardo Biehl Pasquali:
> It was the second time I've typed "git rebase --co",
> hit tab (for completion) and enter, and the result was
> --committer-date-is-author-date instead of --continue .
> 
> Please do ask user before run actions like these! I have
> not found a way to undo that. I had to perform a reset in
> the repository.
> 
> PS: Notice I was expecting a command of interactive rebase,
>     and I got a bunch of commits's date (and hash) changed.

Do you know about the reflog? This let's you undo these kind of changes.
See git help reflog.

