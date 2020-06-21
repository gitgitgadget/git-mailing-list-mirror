Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E2C433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF910251F8
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 15:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgFUPnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 11:43:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47296 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbgFUPnS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 11:43:18 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jn27o-0007IJ-6S; Sun, 21 Jun 2020 16:43:16 +0100
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
To:     Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Amir Yosef <Amir.Yosef@mavenir.com>
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e9534404-7c2c-bec0-465e-7c0149734e3a@iee.email>
Date:   Sun, 21 Jun 2020 16:43:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/06/2020 19:21, Tiran Meltser wrote:
> Hi,
> This topic is quite common in various use cases (e.g. production configuration vs. staging one) and there are quite a few talks about it in the web.
> Nevertheless, there is no specific solution to this problem, only partial workarounds (including the famous merge driver “ours”).
>
> I would like to suggest adding the git a simple and precise handling for the need to mark file(s)/folder(s) that are branch specific and should not be involved in merge operation at all.
>
> 2 suggestions I can think of are (but any good solution would suffice):
> • Adding additional merge strategy indication the file/folder is excluded from merges (e.g. merge=disabled/none/skip/…)
> • Adding a new configuration file (like .gitignore) for tracking these special files/folders, for example: .gitisolate/.gitquarantine/.gitbranchspecific/.gitsilo/…
>
> Any comment would be appreciated.
>
>
There has been a lot of previous discussion on "precious" files in the
past, but without any solid solution.
(https://lore.kernel.org/git/?q=precious+file to start).


There is a current thread on progressive merge resolution, where not all
conflicts can be resolved by one person at one time, which may also be
of interest.
https://public-inbox.org/git/BY5PR19MB3400DC6B6065C1FFF2ED289890990@BY5PR19MB3400.namprd19.prod.outlook.com/T/#m56b34554612b44be17e61da6486c1f709c2cfe54

Philip
