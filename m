Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E28CC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiDYN7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbiDYN7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 09:59:00 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED5821E14
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:55:52 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nizBu-0000cc-Bn;
        Mon, 25 Apr 2022 14:55:50 +0100
Message-ID: <f373dfbc-51b6-2985-68aa-412599df2b43@iee.email>
Date:   Mon, 25 Apr 2022 14:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: --help for git commands
Content-Language: en-GB
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        =?UTF-8?Q?Dorian_Mari=c3=a9?= <dorian@dorianmarie.fr>
Cc:     git@vger.kernel.org
References: <CAHZPcmD3xmsuM5XQzczqKQEcVXXXc=c9cH9cpqDNPTpBrwd2iA@mail.gmail.com>
 <CAJyCBORnAsJjC6+JmDX_nMMnAEZbLbhVNK9QKB7cb88KGUsARQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAJyCBORnAsJjC6+JmDX_nMMnAEZbLbhVNK9QKB7cb88KGUsARQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Dorian
On 25/04/2022 07:22, Shaoxuan Yuan wrote:
> On Sun, Apr 24, 2022 at 2:26 PM Dorian Marié <dorian@dorianmarie.fr> wrote:
>> Hi,
>>
>> I think it would be nice to have a simple help like other programs do
>> when doing `git [subcommand] --help` or `git [subcommand] -h`.
>>
>> It would be a short version of the manual.
> I think we do have a "simple help like other programs do".
>
> You will get the git manual page for a command, for example, git-add,
> with one of the followings:
>
> `git add --help`
> `git help add`
> `man git-add`
>
> Or, you can get a "short version of the manual", i.e. usage string, using this:
>
> `git add -h`
>
The `-h` option is listed in the command line interpreter (cli) guide
`git help cli`
and the help command is listed via the `git help help`, which also notes
the `git help git` method for getting git's own help/man page.

All part of the many 'obvious in retrospect' parts of Git ;-)

Philip
