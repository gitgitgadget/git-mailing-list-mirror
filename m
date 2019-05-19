Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B876D1F461
	for <e@80x24.org>; Sun, 19 May 2019 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfESRk4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:40:56 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:24368 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfESRk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:40:56 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id SIRzhkPzXp7QXSIRzhbJ0r; Sun, 19 May 2019 10:49:51 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=hviv9FE1fq7uVRFmnYUA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e.
 select from rtb's)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
 <87lfz3vcbt.fsf@evledraar.gmail.com>
 <720a0b5f-cc20-5b75-8222-68eed77beeea@iee.org>
 <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <a83183ec-a87a-b080-6e72-489e7fc1ebd6@iee.org>
Date:   Sun, 19 May 2019 10:49:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKPltBftlLfvQULzdWhzMBymhDWaFWcVfdt4QMWgiHYKs+zeyLCBP58UbmxmCrSY9dxkvy+M84eb5w8Xeb8gsgXN1fVAm/3IZ7FBzzOT8NEI9A2R90Uy
 1fCtVynDWrxcV1U/kkSCrr1SKk8s+z9EP6iRXi8ie4JMApWnoHLUJZ1WGKStQx31OBpl0zOD4TMDUG1rbJuTlKHYn0+WvXvc6+p/RhTTfoz2oqOKXCdReWh+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 19/05/2019 04:07, Duy Nguyen wrote:
> On Sun, May 19, 2019 at 2:55 AM Philip Oakley <philipoakley@iee.org> wrote:
>> I'll add the answer to one on the stackoverflow Q&A's I'd looked at. I
>> hadn't put the branch -a and -l options together.
> Maybe update/add some examples in our man pages too.
deffo on an update! For the -r option I did not expect to be able to add 
a remote name (no option listed, nor method noted).

Just re-read the branch(1) man page and much of it is buried in the 
first paragraph with/for the --list option with lots of caveats and 
pairings.
--
Philip
