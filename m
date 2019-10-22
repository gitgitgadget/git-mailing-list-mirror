Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA211F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 14:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfJVOua (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 10:50:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39205 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfJVOua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 10:50:30 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iMvUR-0001yG-5Y; Tue, 22 Oct 2019 15:50:27 +0100
Subject: Re: [git-for-windows] Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE]
 Git v2.24.0-rc0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <74f50326-e613-8545-2c69-65cd29dd3cfb@iee.email>
Date:   Tue, 22 Oct 2019 15:50:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Install went Ok.

Did a quick test on the config locations and `git config -l 
-show-origin` has 'lost' the ProgramData location as planned.

The minor pedant did notice that the new location is listed slightly 
differently from the release notes.
`file:C:/Program Files/Git/mingw64/../etc/gitconfig`  --system,
while the release notes simplify the path to C:/Program 
Files/Git/etc/gitconfig

Dunno if that's worth a minor fix to the release notes to clarify for 
the broader Windows community. Maybe others can comment if they think 
it's even worth it.

Philip

On 21/10/2019 23:05, Johannes Schindelin wrote:
> Team,
>
> a couple of days later than I wanted, but at least it is now here:
> https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc0.windows.1
>
> Please test...
>
> Thank you,
> Johannes
>
>

