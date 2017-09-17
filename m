Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBA62047F
	for <e@80x24.org>; Sun, 17 Sep 2017 13:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdIQNbJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 09:31:09 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:62224 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdIQNbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 09:31:08 -0400
Received: from [192.168.2.240] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id tZf8dGbLgpb8rtZf8dGqCY; Sun, 17 Sep 2017 14:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1505655067; bh=6GG3h7lVnimIuwbiDYBY44xWBFPgOZULgSahBjOtfPk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sfuOIgDyaiv9lEz6CCyWpdrAvGBAleEJPHO84jV2ob0/Lurzc3PnHG/PXGdFbbLO0
         Bt3m3EUWhx3Cq2bvScCrkOfCarB6SvrAX4BfWOot//rzuGILIjK5Xc8SMZMjA9Kkuo
         uV+MRNN7+GFlQDQMMzD3yyPytuhW+xuHlDo2Fxy4=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Xs9Mk7XThtz9oiwJoK4A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <oo62vr$pvq$1@blaine.gmane.org>
 <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
 <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
 <20170902000417.GE143138@aiede.mtv.corp.google.com>
 <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com>
 <xmqqbmmbwuq0.fsf@gitster.mtv.corp.google.com>
 <9e004c75-bc35-06ae-8479-9440059c4d0f@gmail.com>
 <CAHGBnuMBD1kVJoFLB-apUKbKJipOW3XTGqO+5W8jesY100ZFcg@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <71c4d0ee-bc64-0c94-7991-2cb6d0a2bfd1@talktalk.net>
Date:   Sun, 17 Sep 2017 14:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHGBnuMBD1kVJoFLB-apUKbKJipOW3XTGqO+5W8jesY100ZFcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEwifeQk3SCUJRPSpsNJtPh1BCpgAd5oi7jzgyVbtLRF2JRV7FBALZ+JPG5KUgRS6V7SL2Z7M9gRT4Ois9TXINLpBx0Uzz/HoI7NaequxeVsq+xDDmFq
 iUum5QZTNXlzkpz8GEOO1zCTz0BxKyOlM50MTCkEI/UTuaWP1HYooyDV1UwDn7/MdOpT6K9u1lo/obib1Hw0OBp0NfxT940+n3EhQ3dmyOhbQRws9ewZ7t5w
 JEZkteXy7+UbDsnr6BIJKBJgeMlVar9EbhTIKL7nK8H2CHWsp7EReNgDb3OCfrA0wQ9N90iS3UxUvOuVakxnY242MFfg5QU0dwAh2HL5Waw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/17 14:45, Sebastian Schuberth wrote:
> 
> On Sat, Sep 16, 2017 at 12:41 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> 
>> Therefore I would avoid "definitive wording" like "will drop" and use
>> vague wording along "there are various dragons out there" like this:
>>
>>      The todo list presented by `--preserve-merges --interactive` does
>>      not represent the topology of the revision graph.  Editing
> 
> I tried to avoid this introducing sentence from the original wording
> as it reads like from a scientific research paper instead of from a
> user's manual.
> 
>>      commits and rewording their commit messages should work fine.
>>      But reordering, combining or dropping commits of a complex topology
> 
> There is no need for complex topology. If you reorder the two most
> recent commits in a linear history, one gets dropped.
> 
>>      can produce unexpected and useless results like missing commits,
>>      wrong merges, merges combining two unrelated histories and
>>      similar things.
> 
> "can produce" is much too soft, IMO. Reordering commits goes wrong,
> period. Like wise "unexpected and useless results" is inappropriate.
> The results are wrong in case of reordering, and wrong results are of
> course unexpected and useless.

I agree that the wording needs to be explicit that bad things will 
happen. It should spell out that if commits or reordered, or the fixup 
or squash commands are used then commits will be dropped and if commits 
are deleted from the list or the drop command is used other commits 
other than the intended ones will be dropped as well.

