Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4557C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DA661376
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhGFOkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:40:25 -0400
Received: from mout.web.de ([217.72.192.78]:47987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231754AbhGFOkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 10:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625582261;
        bh=Gnbw7pLknitflWZnSJFKIA9nh+RjjcWlojPM76MUsfU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EUTqQ9J+2P36d8+pDEOg6JP1nAAm05mLZSOQsU6EggycLG4Uy1UnP6Khn8hynjgvK
         nWNtsr6feKe6d1gn9lNetckSJO6tmNqaU1Dme5ioqxVFiXY1RwVa6W/hqJmZhOauu8
         ldpTukAlPHW/rgxYQmjWS31OqBuIy3Do9JW7GmaA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LvSLn-1l225d3Gyp-010aym; Tue, 06 Jul 2021 16:25:10 +0200
Subject: Re: Antw: [EXT] Re: bug in "git fsck"?
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
 <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
 <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>
 <60E40275020000A1000422F7@gwsmtp.uni-regensburg.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>
Date:   Tue, 6 Jul 2021 16:25:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60E40275020000A1000422F7@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BD51ELliNZM2kMYJLm9sEhF7053cRhiH8LlvISy86+TiLlssnqu
 umuWwBk0eW93YJ+lnLKEF/mRBQCCIW9A0t1vpPW/uOkaXsZbdAM8ZcxIso2CgZZwdl1mcsG
 MtTgHGAvlDg0zZgXUDmgvPS4wWchfCupyWgysiR8LYDpMha++W0NnsUz03vsJ6JWUvGxzq6
 DpI3qOIJXfY564g4iJBjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yVuNXCSJ4Ss=:kmG8No7OLgiem6Mk4n0zA1
 Yqkcg+GaAnoxF8nH8DNbN9PMMcOHQ7kD7zfpKD+lniDqzq08SOMeUlYkDEOkJJ4akyP+en40K
 yADKmZwuh/LXIkp28AFaaQj96d9GFKzsA9TBDblSG8mqZGggOb5OUTSqI5I6CQHcwoMhC0bqs
 V/wyiddjjVovjcIShqDMMFUogXh5IudE0IgdkCyX2doDuHE/kdnR5gNg3UT2JwIRQp3+R0x8G
 wK0R72wcby0nC7O8oBOUmtONeuLF1GcAoXL9bUA3hUOEvQ45xoMxYgPa1ZrVUuWTrd0zd19p8
 Y0N626k6nlCiB70PXcJNEMIz8ApuVfK8vnnPMN8EyZUEzZ5jw9Z5/+7uim33AZqmp54JZdIhc
 ghVzsV2E/yhpm3woRHUIXFpsBEIvZlM5DC/HWrLy0merAat+2dmWhkyx99x3V5z1rwCmumoBT
 5GujRtHuNBKBCDQbkGZW1GHvkzNYFJFfdnE5sdCqihNLSrp9HwP/sfFDqE1VKfs8laZ+f0WPi
 azpiumUuBLEGy8wWoVd1wAA8ESd5EGuUKwseyzAIhIqudIqXKg4mZRMbgjl4kLcS89NLeBCxb
 Aw9wonKT99aB36yy8HKdXd+TydR/t5IsQH9nZDj7h8/zokAADjyuMNKTyS89tZJpqzhs4zliV
 Z2KDl/eR8jTAgt32lQMRDKuzil4ciBmLnzmnFOB6n64zwpu67dfwUm4HubE8LJBbEB/jrJv7q
 Y8paYtOR1breU3np1UMFWnlBJVvS/i1nKSNfloLrx+ZzRyfQwi7XG9J49eNBNihj3EBEfl0sd
 CWAEZYKYAtgZ+txy06Nlpw/LUA+nwJL0MQtu+CRmJiLIne3Puve0s7H3jxcQygWC+IMWT6Cxz
 s2nfYXPYev4iOKFazWE8aW8rhjnL6xjRoHE0tsHmZklWsh8DVcvWIVdxNz1qAZSonRFDPTHxh
 QuniB/mAj2CtlhcS/2jOT+9Ea/ymEfQAeNExi3Xo3r7SiYeyy2bhbybOJlPXh1CK2T4oM8VJx
 cJ4EnDGd17JiDd/aAsUeR3IJg9NrVyEDCuzJdu7r4bwQpsCeKnGA8AJB2Pnm2+nDJDH145K1/
 77kl2rTVNQMlfGk3wNaYJudXRZpmj+9WOcv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.07.21 um 09:12 schrieb Ulrich Windl:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> schrieb am 05.07.2021 um 16:44 in Na=
chricht
> <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>:
>> Am 05.07.21 um 09:42 schrieb Ulrich Windl:
>>>> You *can* overwrite them using "git branch --force foo" and then
>>>> "git branch -d foo" works.
>>>
>>> Would it be OK to force the branch to any commit (e.g.: "master"), rel=
ying
>
>> on
>>> the fact that any reference (read: "master") to that commit will preve=
nt
>> actual
>>> removal of the commit?
>>
>> Yes, any valid commit would do.  This turns dangling branches into
>> normal delete-able ones.  Other branches are unaffected.
>
> OK, but either it does not work, or I did not understand what to do:
>
>> git branch --force bitmap-generic
> fatal: Not a valid object name: 'bitmap-generic'.
>> git fsck
> Checking object directories: 100% (256/256), done.
> Checking objects: 100% (173/173), done.
> notice: HEAD points to an unborn branch (bitmap-generic)
> dangling blob 0458be7cf03f35be365c819afe0104ff3c178ca0
> dangling blob 3000d29f0a652f3f7ed25572cac9969b90adeca5
> dangling commit 90e8531086d3efaeefdf6c8d39b6782e49dd2a0d
> dangling commit b598195f859106662bde746f391a7df9162231e9
> dangling tree fb4866ab5cc2f0c34a63334b90550ef7199a2098
> ...

First: Please make backups.

Here's what works for me.  First reproducing the error:

   $ echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa >.git/refs/heads/broken
   $ git branch --delete --force broken
   error: Couldn't look up commit object for 'refs/heads/broken'

Now I have a broken branch that I cannot delete.  We should be on the
same page now.

   $ git branch
     broken
   * master

So I'm on master, a valid branch.

   $ git branch --force broken

Now the broken branch is overwritten and points to the same commit as
master.

   $ git branch --delete broken
   Deleted branch broken (was 83d267b).

And now it's gone.

Ren=C3=A9
