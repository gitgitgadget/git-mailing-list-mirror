Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ABC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B0C2067B
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLOSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:18:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32195 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgFLOSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 10:18:53 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jjkWC-000Cdo-72; Fri, 12 Jun 2020 15:18:52 +0100
Subject: Re: git log --name-only improvement: show old file name in rename
To:     Junio C Hamano <gitster@pobox.com>, Ed Avis <ed.avis@qmaw.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
 <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
Date:   Fri, 12 Jun 2020 15:18:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Ed
On 12/06/2020 00:16, Junio C Hamano wrote:
> Ed Avis <ed.avis@qmaw.com> writes:
>
>> The git-log manual page says
>>
>>        --name-only
>>            Show only names of changed files.
>>
>> But when a file has been renamed, only the new name is printed, not the 
>> old.  I think it would be more useful and more correct to print both 
>> names. 
Was this a concern that the manual did not clarify which name (old or
new) was being reported?
Philip

> It is just you who thinks it would be more useful.
>
> Scripts written by people over the last 10 years that expect to see
> new name would certainly hate to see two names start appearing
> there.
>
> Perhaps you can use --summary at the same time?

