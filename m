Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09916C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF25A61283
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGEOra (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:47:30 -0400
Received: from mout.web.de ([212.227.15.3]:57511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625496291;
        bh=+zS3BqxbpgYfDcngPTk39hrWMLDEpE1kltQWQJ/jCsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=o748ZwS+f0MIkqsn7vznzpQdOOXBrCGYu+srJX3CkKRaaV22jlTXRsvopNePBA0ts
         5dK/U5Zd7KPZw+4mVNUSQhmclZZKcn5YaxYHOf3cgKpR6iYIQ1Dv/DxZSI3jSrbXm7
         HfdlBTBqtofEhIgBL1vKI1UX/11SPjyazhc+gqa4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MC0PR-1lufjr3Uuz-00CThW; Mon, 05 Jul 2021 16:44:50 +0200
Subject: Re: Antw: [EXT] Re: bug in "git fsck"?
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
 <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>
Date:   Mon, 5 Jul 2021 16:44:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmWc43Gu8CZm+8S5AuYCd1Ooig5vaumkj3e/Cq52EJvrlI8Ziiq
 t4ceBsby9c6SEqk3lmk+iVmt/LyPYX3fYIflRjNXxfFmPHiliZEhiBSDhJtGt4eD+mVWKr4
 bmR4r9rWs+kr6dNWrk7TjxfAyGY6rVVkFddwovkKs/tK9LngT+gFdy/vldVM3Ciik/WzjRG
 4gOJBhJ5vRm/wu1cxQ/ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uN1WXmzXNmo=:Ffh/z26LaYeWT+r8hSusJF
 AVopLnk7pYHHh265UiLrZnQH9d3huUHdhowM+LSi5t0RMgtKUPN9Sx6bgIy6kcTYymkLCPGH3
 Aze2Uu6JY0jT7nUF8hhuRXGxvwPI+FEPFh4qnLyfyBdwoKqdaxcHIajCawwfzD+cffeHvGg/m
 DXQ5RbnhMEMAQsuGdHXViQsGGddGlJmJte+Phytty5GcSZjfhwfBr2sN4LNrKs2g2bo2eJqfn
 26GLy6GxmwlYLyruRzFyrCh7k4vckATm+mwsKtccvUmEuPcqFaptHayuyZqrOKbUUIQeLVyQJ
 +cQkRq/3VY6b6EYGVllYQsHVr3yvIJfW2Ffi9STnazbJU3VqqKOIQp3R9gdVPJIwo1vPxkuW1
 tTdwvny23ROHwkWViyOHKhseeO60ND1WnGKlR0tbSNGnJ89G4hKXrwiJwDDMKnBFJL97GN/Nk
 SGe24nMce0Xz9kCJpH1G4zNORtkA7H8PFYihRPWecOSM34vKwOScvqT/ebmVTwKF3s6OotFSE
 F2duUmYmm1JKCCjhyEZU0KHnHCKvmg3PpVMx36AkDjbPjr75X0/2nL/0HOPvVaSbzU/s96DW4
 wB6CI7ro1Un9kJSr1vOOB8thOo6ijKGviMJ8xnRNAkw0cFl0VvKSET9VLgKfIDzTLAlVgWrrN
 a2ZkD+alVkziwWMdPebRNX5jw6ld5WLHKknQRItDlQmbwmT3qYLVOAgGM6pGdO0ooQ5otoV6g
 5VcwxlAfRXn9jhGXTv7tJUS/dLm3WCtKn2dC4ILLycKwe/f4vRDoU6nR7p/CUGhoetsw5gpla
 td6XmzpVP42dzwShbgODcf/7538amdCG3MmRvI4qireWPYFTqPAPyThW+ZVLqj63upr+XkCWx
 DFuDIvWAhIwMsNERCnCZ6JXmj6eW4YCUYUH+NI8wuTH5CFzt4ybKlkw3PsGtPN7QGxFFbkaRG
 CqrkPDEHvv7UmzEnqjp/SKlklU/ZxqQTby0waaEoFFSJMvFrD7SPRcMWaf+42E2milxZyRfGO
 cQ+Lt+gYkw8cCoU948mKG3SUEj3IKHMFzNNpRE2Y+w4kQsrtPlV60fGOAOSKqOb3Bw6p1yYV6
 oLVwenJ/zYkEmAUnuvUf7ubSz4RZRz3+OBT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.07.21 um 09:42 schrieb Ulrich Windl:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> schrieb am 03.07.2021 um 22:03 in Na=
chricht
> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>:
>> Am 02.07.21 um 20:15 schrieb Junio C Hamano:
>>> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>>>
>>>> I was wondering whether git fsck should be able to cleanup
>>>> orphaned branches ("HEAD points to an unborn branch") as described
>>>> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
>>>> it be editing files in the repository, but I feed that's not the
>>>> way it should be.
>>>
>>> HEAD pointing at an unborn branch is not even a corruption, isn't
>>> it?
>>>
>>>    $ rm -rf trash && git init trash
>>>
>>> would point HEAD at an unborn one, ready to be used.
>>
>> True, but the scenario described on StackOverflow is a bit different.
>> Commits were filtered out, and branches still pointing to them cannot
>> be deleted with "git branch -d" or "git branch -D".  Git fsck only
>> reports them.
>>
>> You *can* overwrite them using "git branch --force foo" and then
>> "git branch -d foo" works.
>
> Would it be OK to force the branch to any commit (e.g.: "master"), relyi=
ng on
> the fact that any reference (read: "master") to that commit will prevent=
 actual
> removal of the commit?

Yes, any valid commit would do.  This turns dangling branches into
normal delete-able ones.  Other branches are unaffected.

Ren=C3=A9
