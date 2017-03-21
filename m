Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C510A20323
	for <e@80x24.org>; Tue, 21 Mar 2017 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756786AbdCUJOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 05:14:24 -0400
Received: from [195.159.176.226] ([195.159.176.226]:35988 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1755537AbdCUJOY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 05:14:24 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cqFrk-0003wt-4H
        for git@vger.kernel.org; Tue, 21 Mar 2017 10:14:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Regression: Reword during rebase -i does not seem to trigger
 commit-msg hook anymore
Date:   Tue, 21 Mar 2017 10:14:06 +0100
Message-ID: <1f14be35-4688-7d0b-bb84-bfc901dba807@gmail.com>
References: <oaotoa$qkp$1@blaine.gmane.org>
 <CAGZ79kY7bCt_3Fse_Qi43Aej=MgN1ABLTx7eLmPCs+aP2e9ZwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kY7bCt_3Fse_Qi43Aej=MgN1ABLTx7eLmPCs+aP2e9ZwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/2017 18:43, Stefan Beller wrote:

>> With this version, when I do a "reword" during an inteactive rebase session,
>> the commit-msg hook doe snot seem to be triggered anymore. This was
>> particularly useful to let Gerrit's commit-msg hook add missing ChangeId
>> footers.
>>
>> I can work-aorund the issue by doing an "edit" and "commit --amend".
>>
>> Is anyone else seeing this?
>
> In 2.12 RelNotes:
>
>  * "git rebase -i" starts using the recently updated "sequencer" code.

Thanks, that looks like a possible culprit. I can *not* reproduce the 
issue on Linux with "git version 2.12.1-382-gc0f9c70", thought. So 
either it's Windows-specific, or it has been fixed in 2.12.1 already.

Regards,
Sebastian



