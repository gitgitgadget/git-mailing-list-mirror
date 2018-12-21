Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FAF1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbeLUUTO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 15:19:14 -0500
Received: from box.datamaskinaggie.xyz ([45.55.255.105]:56257 "EHLO
        box.datamaskinaggie.xyz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeLUUTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 15:19:14 -0500
Received: from authenticated-user (box.datamaskinaggie.xyz [45.55.255.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by box.datamaskinaggie.xyz (Postfix) with ESMTPSA id 287671400BE;
        Fri, 21 Dec 2018 15:19:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidwbrown.name;
        s=mail; t=1545423552;
        bh=A/+7QJi0MpYRmtME/o85xbrQn0fixf+KxnncxWZOXcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K1GnQKm11P/xikI+Ks9CNmAD6aSp0HOH+kq82Bf4qanq+jxAet2hkWgoZV88C7yRZ
         Mg5Rr18ZRcnXZFD1z9kODPb3pPIrmPrVe4E4dMGz+LHjuXn6HT+SimTmNRqwni9BAH
         hk6TXb57C+WV3g+TH4o9akysYB9kU0HOItELvW2ZhZkJFJI8T/0aTexiFVetVkBDum
         jrPNHctYEvmiVS9ZRc11qM5W/SH86JfPMrk2Azo85MCADspy151JTqh/vN7Iuc6P8s
         8No4NLG7PkQvl3vFFWr944tjfOF+NBSWAv9oIWEf8Ogn2W3g+LfXlXnpGuWICog0oc
         o1b5fUY/wO2Gg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Dec 2018 14:19:12 -0600
From:   David Brown <david@davidwbrown.name>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Unable to install latest git version. Claims git process pid
 running
In-Reply-To: <nycvar.QRO.7.76.6.1812211652150.41@tvgsbejvaqbjf.bet>
References: <d2bb51d06b263f5a4d60256e5c2ff33c@davidwbrown.name>
 <nycvar.QRO.7.76.6.1812211652150.41@tvgsbejvaqbjf.bet>
Message-ID: <7b41b16c39632660c48bffc90e171ab9@davidwbrown.name>
X-Sender: david@davidwbrown.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howdy Johannes, thanks for the speedy reply.

Unfortunately I have hit refresh many times in previous attempts.

Notwithstanding, the dialog maintains the error condition claiming pid 
10128 must be closed prior to install.

I'm a big fan of Git but not a Windows fan in the least.

I have downloaded the latest Windows git and killing as many apps and 
pids possible after Windows restart the installation goes south 
nonetheless.

Please advise.


On 2018-12-21 09:55, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 20 Dec 2018, David Brown wrote:
> 
>>  - [ ] I was not able to find an
>> [open](https://github.com/git-for-windows/git/issues?q=is%3Aopen) or
>> [closed](https://github.com/git-for-windows/git/issues?q=is%3Aclosed) 
>> issue
>> matching what I'm seeing
> 
> That's a new one. I saw many bug reporters simply deleting the issue
> reporting template at https://github.com/git-for-windows/git/issues/new
> (and usually then filing only very little information, definitely not
> enough to make sense of the bug report), but I never saw this bug
> reporting template being used to report a Git for Windows bug to the 
> Git
> mailing list yet ;-)
> 
>> ### Setup
>> 
>>  - Which version of Git for Windows are you using? Is it 32-bit or 
>> 64-bit?
>> 
>> $ git --version --build-options
>> 
>> git version 2.20.0.windows.1 cpu: x86_64 built from commit:
>> 95155834166f64fe9666f2c0a4909f076080893a
>> sizeof-long: 4
>> sizeof-size_t: 8 **
>> 
>>  - Which version of Windows are you running? Vista, 7, 8, 10? Is it 
>> 32-bit or
>> 64-bit?
>> 
>> $ cmd.exe /c ver
>> 
>> ** Microsoft Windows [Version 6.1.7601] **
>> 
>>  - What options did you set as part of the installation? Or did you 
>> choose the
>>    defaults?
>> 
>> # One of the following:
>> 
>> $ cat /etc/install-options.txt Editor Option: VIM Custom Editor Path:
>> Path Option: BashOnly
>> SSH Option: OpenSSH
>> CURL Option: WinSSL
>> CRLF Option: CRLFAlways
>> Bash Terminal Option: MinTTY
>> Performance Tweaks
>> FSCache: Enabled
>> Use Credential Manager: Enabled
>> Enable Symlinks: Disabled
>> 
>>  - Any other interesting things about your environment that might be 
>> related
>>    to the issue you're seeing?
>> 
>> ** A so-called VDI running on a Dell WYSE **
>> 
>> ### Details
>> 
>>  - Which terminal/shell are you running Git from? e.g
>> Bash/CMD/PowerShell/other
>> 
>> ** Bash **
>> 
>>  - What commands did you run to trigger this issue? If you can provide 
>> a
>>    [Minimal, Complete, and Verifiable
>> example](http://stackoverflow.com/help/mcve)
>>    this will help us understand the issue.
>> 
>> ** Windows git upgrade dialog **
>> 
>>  - What did you expect to occur after running these commands?
>> 
>> ** latest version of git installed **
>> 
>>  - What actually happened instead?
>> 
>> ** No such pid 10128 to close therefore cancel install **
> 
> This typically means that that process existed *at the time the 
> installer
> checked*. If it was a short-lived process, you can check again by 
> clicking
> that "Refresh" button on the lower left.
> 
> Ciao,
> Johannes
> 
>> 
>>  - If the probleminsert URL herey, can you provide the
>>    URL to that repository to help us with testing?
>> 
>> ** Internal company url. Windows git install dialog is issue **
>> 
