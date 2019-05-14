Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247701F461
	for <e@80x24.org>; Tue, 14 May 2019 11:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENLKE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:10:04 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:36644 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENLKE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:10:04 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QVJqhIsUwWIpcQVJqhwUpO; Tue, 14 May 2019 12:10:02 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=uPZiAMpXAAAA:8 a=_MSeebai26lSIMIXgSkA:9
 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Missing branches after clone
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <CACsJy8D9wDiTOfKP4sdMFQrR66qa4cLZuqqn32yH83_q0XjKRg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <aeb83b28-3db1-f37c-6cb0-6be5622da114@iee.org>
Date:   Tue, 14 May 2019 12:10:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D9wDiTOfKP4sdMFQrR66qa4cLZuqqn32yH83_q0XjKRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNxBLoow0IbPaYYZ2jvRpXhbQ7hCaVb8ghx2+uQC3jv2WOwXxWSRvpBLSOiXJLsQSN1QTyCikRI4bK/tmTwGgtqh1QltJ94FglslhZUk2gLwVM35qzvy
 RSnqrfMP2JUTeqca8Mri+F7W1QhneCmYzmKS4rSm4q7apVN8/dsps6AXxfZdx867BhEiw2nX6U/YCfbGq/ga+TpI4PXMjbzhb+iUjrbehLeJnTh60d5oy15+
 wPgDfqixJdx2PMkDWQOe5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 14/05/2019 11:53, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 5:33 PM Philip Oakley <philipoakley@iee.org> wrote:
>> Hi Ulrich,
>> On 14/05/2019 11:12, Duy Nguyen wrote:
>>>> Then I foundhttps://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches  which handles the subject...
>>>> But still the most common solution there still looks like an ugly hack.
>>>> Thus I suggest to improve the man-pages (unless done already)
>>> Yeah I expected to see at least some definition of remote-tracking
>>> branches (vs local ones) but I didn't see one. Room for improvement.
>> Yes, the 'remote tracking branch' name [RTB] is very 'French' in its
>> backwardness (see NATO/OTAN).
> The name is not that bad to me.
It was something that I struggled with initially, and its sounds like 
Ulrich had a similar issue.

I expect that those who grow up with the development of Git have an 
organic knowledge that is deeply rooted so the terms will be solidly 
founded for them (along with many other terms and implementation details 
that catch me out ;-).
>> It is a 'branch which tracks a remote', and it is has the 'last time I
>> looked' state of the branch that is on the remote server, which may
>> have, by now, advanced or changed.
>>
>> So you need to have the three distinct views in your head of 'My branch,
>> held locally', 'my copy of Their branch, from when I last looked', and
>> 'Their branch, on a remote server, in a state I haven't seen recently'.
> What I was looking for is this. I don't think we have something like
> this in the man pages (I only checked a few though) and not even sure
> where it should be if it should be added to the man pages, git-branch?
> git-remote? git-fetch? git-branch.txt might be the best place because
> this is still about branches.
>
At the moment its in `git help glossary`, but could be improved, and 
references to it given in the various man pages.
--
Philip
