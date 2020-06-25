Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB666C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBEE20672
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbgFYNjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:39:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:10530 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405038AbgFYNjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:39:06 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1joS5o-0001jt-8b; Thu, 25 Jun 2020 14:39:04 +0100
Subject: Re: Capital letters do not work when using vi as git editor
To:     Daniel Dyk <Daniel.Dyk@ifta.com>, git@vger.kernel.org
References: <000232C3.5EF496D0@mail.ifta.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1eccf3a5-cce2-2109-5e04-ed9f43105a57@iee.email>
Date:   Thu, 25 Jun 2020 14:39:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <000232C3.5EF496D0@mail.ifta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/2020 11:21, Daniel Dyk wrote:
> Hi git-devs,
>
>
> I installed git 2.27.0 on a fresh Windows 10 system, there where no old installations of mingw or git. Unfortunatly I have encountered a bug with vim when doing 'git rebase -i' or 'git commit':
>
> I am not able to type capital letters, so commands for selecting rows (<Shift>V), pasting above (<Shift>P) etc are not working. I am also not able to type 'ABCDE' in insertion mode. Small letters and capital umlauts (ÄÖÜ) work. If I open the vi without git, I can type the capital letters. If I use nano as editor, I can type capital letters as well. 
>
> Downgrading to git 2.24.1.2 solved the problem for now (I double checked and reinstalled 2.27.0 again => same issue).
>
If I remember correctly this occurred because of changes to the terminal
support used. It's been reported on the Git-for-Windows Issues [1] list
and a fresh snapshot [2] created that resolves the problem .

Philip

[1] https://github.com/git-for-windows/git/issues/2689
[2] https://wingit.blob.core.windows.net/files/index.html
