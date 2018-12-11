Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3AB20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 14:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeLKOsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:48:07 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:25446 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLKOsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:48:07 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id WjKOgjc0gwhzSWjKOgEUZu; Tue, 11 Dec 2018 14:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1544539685;
        bh=SOuT3mzFF7pBDOIbFErR1RN8vgmrsricAUBHu2GRYPE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R65yAK/k3NoUTJtDVw65o20rahGVmerOTm0iQMcO5KKMydmkXB7POPUYwhjW4Lo6u
         mR6/NQjnnrjk3zMmhrqOtKw5LWbIz76dYqemG2UBEkl7cCbfvP0My9vJHzxS7Ei1VZ
         LdHGsQRcHOeZCC4flI6dcN/PlybxopYleogcW5lI=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=1URkNucaAAAA:8 a=scWrzWlcn1TraaugJn8A:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=sQBCBFvkJtL6dM0WAy1K:22
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
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <be3d2a6e-e960-6e43-17bf-9f67837f74e5@talktalk.net>
Date:   Tue, 11 Dec 2018 14:48:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1812111049560.43@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIhm47nOmm0K9mUB76bn5se3WMEjc6uL+D2VHSZKsQsmZKEwrHp0bMh7HRk1YlTIZg6Lxyis1AjhMN/2bA+9cETXs8sqi1TJGt3zmjPwyCFLjZTFwXfh
 Qwq9TIHlfuxTIQTrAUbN0zAXkYFuN00KQKefj76CFE2p43IRntKmdFXZILhGdlYTNHTGZOeolL3Vn6HajY5fog00/SKWTRdveMsG1oy4xI52Ybh/EAbxNhHy
 bya9a4G/sbju0ZFCMR2knV5GHCovv+Wm2FrsYPaoYIW+YkQ10Eq55t9eMBwSr9eNxPg1g9mbZa0NyADRVwCOhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho and Slavica

On 11/12/2018 09:56, Johannes Schindelin wrote:
> Hi Phillip,
> 
> [Cc:ing Slavica, the Outreachy intern working on converting `add -i` to a
> built-in]
> 
> On Mon, 10 Dec 2018, Phillip Wood wrote:
> 
>> On 09/12/2018 20:31, Johannes Schindelin wrote:
>>>

<snip/>

>>> (which I take as being inspired by Git GUI's "Stage Selected Line"),
>>
>> not particularly, I don't use git gui I just wanted a way to easily
>> stage a subset of lines without editing the hunk.
> 
> Okay. I used to use Git GUI quite a bit to stage individual lines, but
> recently I tried to stay more in the terminal and used the `split` and
> `edit` commands of `add -p` quite extensively. Wishing for an quicker way
> to stage individual lines between all of my debug print statements.

Yes that's one of my main uses for selective staging as well

>>> and thought that it would be useful.
>>>
>>> I could imagine, however, that it would make sense for `git add -p` to
>>> imitate that feature more closely: by allowing to stage a single line
>>> and then presenting the current hunk (re-computed) again.
>>
>> that sounds like it would be quite tedious to stage more than a couple
>> of lines,
> 
> It would be. But then, if you want to do anything slightly more
> complicated than staging a hunk or a line, I personally prefer the `edit`
> command *a lot*, as it lets me even split unrelated changes in the same
> line into two commits.

I was hoping for something simpler than editing patches just to stage a 
subset of lines that do not need to be edited.

>> and it could be awkward to get it to stage modified lines correctly
>> (While I was writing the feature I tried git gui, I think it is supposed
>> to be able to stage modified lines correctly but I never persuaded it to
>> do it for me. I also tried gitg, tig and hg commit -i but I couldn't get
>> them to do modified lines either)
> 
> Git GUI works very reliably for me, but then, I have Git for Windows'
> patched Git GUI at my finger tips (oh how I wish we had a Git GUI
> maintainer again).
> 
> It should not be awkward to stage a single modified line at all.
> Essentially, you take the hunk, strip out all `-` and `+` lines except the
> one you want to stage, then stage that with `git apply --cached
> --recount`, and then you simply re-generate that hunk.

But that involves editing the hunk or have I misunderstood? The aim of 
my series was that you'd select the '-' & '+' lines for the modification 
and it would stage them properly as a modification so given

1 -a
2 -b
3 +c

selecting 1,3 would stage

-a
+c
  b

not

-a
  b
+c

(see https://public-inbox.org/git/878ta8vyqe.fsf@evledraar.gmail.com/ 
for the background)

>> I'll try and re-roll in the New Year, when does the outreachy project
>> for converting add -i start? - it would be good to try and get this
>> pinned down before then.
> 
> Too late. Slavica started on December 4th, and you can even read about it
> on their blog: https://slavicadj.github.io/blog/

Thanks for the link and hello Slavica! - I look forward to reading your 
patches when you post them here.

Best Wishes

Phillip
