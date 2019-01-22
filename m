Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B49E1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVU1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:27:09 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:33133 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfAVU1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:27:08 -0500
Received: from [192.168.2.240] ([89.242.180.111])
        by smtp.talktalk.net with SMTP
        id m2dUg9YCEoI6Lm2dUgMMHx; Tue, 22 Jan 2019 20:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548188826;
        bh=p0CkSfY6273jJ4z1u1hehlQI45n3A6ZsMtcxuHl1JHg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nNE6KNXUYsfO1YSquXRaDpvjzqiVerVQxJ7wnuu+aNIFhAObE3mXd9MmoxZrQLw3B
         FewHW9gziVw2JmGF96aY9HWO6FiczNhY+7XPf76uNyz8xeKl5p2EPYf/0gGNhIJ+xh
         PEIO9G3z/9vfJKpInuE6ky9OTiIpP0IvDOt+a7ns=
X-Originating-IP: [89.242.180.111]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yUcx3x9LIBXmIswB4ICbEw==:117
 a=yUcx3x9LIBXmIswB4ICbEw==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=-AnQz9JOAAAA:8 a=EMhOuU-xG3zMp16ooY0A:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=3bnadFWGKyIZm4bBUiDd:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: pw/add-p-select, was Re: What's cooking in git.git (Dec 2018,
 #01; Sun, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Slavica Djukic <slavicadj.ip2018@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet>
 <d69259ce-bc45-9201-693b-3902a6379265@talktalk.net>
 <nycvar.QRO.7.76.6.1812111049560.43@tvgsbejvaqbjf.bet>
 <be3d2a6e-e960-6e43-17bf-9f67837f74e5@talktalk.net>
 <nycvar.QRO.7.76.6.1901212154300.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <64557c5b-8a91-2a01-fa98-5a5d8b90e49f@talktalk.net>
Date:   Tue, 22 Jan 2019 20:27:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901212154300.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfACsLiNxX16m5hYuBxRQDkmZjp3C/R+Folpyt2demBPYIJep4h+jFc7mUq29gZJzxBx5i+6U2Ay+vnCKWyiWClMSKiC9C1oPvCJSXXR/spsfuUgDfaOp
 HfZoVcq5fpzZWXF1J7dyf0nx5qQLt6SxzGBxy8oyxZaQYLXlOCJPvxUWoStkzTDL2TP57zE+Tq5cevE645c2JMfv+1ufZTuvwLUt5CNtO9DlMu+58ss4wAyo
 jFNp+MRp3yEVjOEL8rgrVJBjTD66tuQUfldC0YVZLZQoqZi1fljcEFSrkAe+oNSpUmKdcr8pqBUAE6FQx5o51xj1HwOPNgj5faLK7Q6bElQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 21/01/2019 20:58, Johannes Schindelin wrote:
> Hi Phillip,
> 
> 
> On Tue, 11 Dec 2018, Phillip Wood wrote:
> 
>> On 11/12/2018 09:56, Johannes Schindelin wrote:
>>
>>> On Mon, 10 Dec 2018, Phillip Wood wrote:
>>>
>>>> On 09/12/2018 20:31, Johannes Schindelin wrote:
>>>>
>>>>> I could imagine, however, that it would make sense for `git add
>>>>> -p` to imitate that feature more closely: by allowing to stage a
>>>>> single line and then presenting the current hunk (re-computed)
>>>>> again.
>>>>
>>>> that sounds like it would be quite tedious to stage more than a
>>>> couple of lines,
>>>
>>> It would be. But then, if you want to do anything slightly more
>>> complicated than staging a hunk or a line, I personally prefer the
>>> `edit` command *a lot*, as it lets me even split unrelated changes in
>>> the same line into two commits.
>>
>> I was hoping for something simpler than editing patches just to stage a
>> subset of lines that do not need to be edited.
> 
> Personally, I found that Git GUI's "Stage selected lines" worked well,
> even if I could only mark consecutive lines. That might be a valuable
> simplification in your case, too, to allow either individual lines to be
> staged, or alternatively a simple start-end range.
> 
> The trick, of course, is to present the updated hunk after staging the
> line(s)... That's what makes it so fun to use in Git GUI.
> 
>>>> and it could be awkward to get it to stage modified lines correctly
>>>> (While I was writing the feature I tried git gui, I think it is
>>>> supposed to be able to stage modified lines correctly but I never
>>>> persuaded it to do it for me. I also tried gitg, tig and hg commit
>>>> -i but I couldn't get them to do modified lines either)
>>>
>>> Git GUI works very reliably for me, but then, I have Git for Windows'
>>> patched Git GUI at my finger tips (oh how I wish we had a Git GUI
>>> maintainer again).
>>>
>>> It should not be awkward to stage a single modified line at all.
>>> Essentially, you take the hunk, strip out all `-` and `+` lines except
>>> the one you want to stage, then stage that with `git apply --cached
>>> --recount`, and then you simply re-generate that hunk.
>>
>> But that involves editing the hunk or have I misunderstood? The aim of
>> my series was that you'd select the '-' & '+' lines for the modification
>> and it would stage them properly as a modification so given
>>
>> 1 -a
>> 2 -b
>> 3 +c
>>
>> selecting 1,3 would stage
>>
>> -a
>> +c
>>   b
>>
>> not
>>
>> -a
>>   b
>> +c
>>
>> (see https://public-inbox.org/git/878ta8vyqe.fsf@evledraar.gmail.com/
>> for the background)
> 
> Why not staging them as line 1 first, then seeing an updated hunk and
> staging the next one? That's an easier UI to begin with.

If you stage line 1 first then the hunk would look like

1 -b
2 +c

If you then select line 2 you end up with

  b
+c

Which is not what you want if you're trying to stage the modified line a 
-> c. git-gui has some magic to get around this [1] but I found it hard 
to use when I tried it out a while ago - I think you have to stage the 
lines in a particular order for it to work.

[1] 
https://repo.or.cz/git-gui.git/commit/c7f7457026dc2f6979842f81cc17098579fec8d8

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 

