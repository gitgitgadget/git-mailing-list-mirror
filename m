Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBBF1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJ2Vn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 17:43:58 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37953 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfJ2Vn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 17:43:58 -0400
Received: from localhost (unknown [1.186.12.13])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A41F8100003;
        Tue, 29 Oct 2019 21:43:51 +0000 (UTC)
Date:   Wed, 30 Oct 2019 03:13:49 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert <logic@deltaq.org>
Cc:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
Message-ID: <20191029214349.iffk37psv3n4v47y@yadavpratyush.com>
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
 <CAKPyHN3WEpVLnxYN5FsovW3G_borc+YrF05Npr0Wyvv6YhbcaQ@mail.gmail.com>
 <CAPSOpYsA9n6Y1vH1_+vRTCV7Mrvox4L2LpQmpXBnpH8ke0yDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSOpYsA9n6Y1vH1_+vRTCV7Mrvox4L2LpQmpXBnpH8ke0yDhQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/10/19 03:25PM, Jonathan Gilbert wrote:
> That's kind of neat, I wasn't aware of that facet of Git Gui :-) But,
> it isn't quite the same feature:
> 
> * It has to be manually set up on each installation.
> * It invokes an external process, I don't know if it's safe to assume
> that "rm" will work on all platforms (though I just tested it on my
> Windows installation and it worked).
> * It doesn't remove directories that it makes empty.
> * I don't see a way to bind it to a keyboard shortcut. That could just
> be me not knowing enough about custom tools, though. :-)

You can't as of now. Harish was in the process of implementing this [0], 
but I left some comments and he hasn't re-rolled the patch since. So 
unless I find some time to tie it up, this will remain un-implemented. 

Of course, if you'd like to see that feature in git-gui, feel free to 
pick it up and brush up the changes :). The latest version can be found 
at [1]. But it does not have a proper commit message (apart from the 
other changes I suggested) since Harish did not format the patch 
correctly when sending.

> * It only processes the first file selected.
> * If I select a tracked file, it will still delete it, and the feature
> I'm looking for is more of a "return repository to clean state" type
> function, like "revert" already is but extended to handle files that
> you can't actually "git revert".

[0] https://public-inbox.org/git/CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com/ 
[1] https://github.com/prati0100/git-gui/tree/hk/custom-keyboard-shortcuts

-- 
Regards,
Pratyush Yadav
