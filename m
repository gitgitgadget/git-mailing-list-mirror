Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C1C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiCGPuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbiCGPt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:49:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A66657BB
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646668126;
        bh=8BrrfrA93WxJwp7+KSeczsgsUUHUOc97XtUQmpX3Zxs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fCd6ejMQz1ow8tn4Pl6D5vjf+QZUMMTtyIi4iCP5ziXQodADwNwKTBtnExb9AWyAL
         BGy+2Xb6/0f7lgnsNjwtGVhwMvXJcGUqvC5T3Mz/z5+kBgOWqsrUmKgSvv2UEzlYn0
         vlOj0HpZns1/2EmcUBn43bw4LEuVOw4m74w2AeDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1nzUUM1sVo-00aTUp; Mon, 07
 Mar 2022 16:48:46 +0100
Date:   Mon, 7 Mar 2022 16:48:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
In-Reply-To: <xmqqee3i2mlw.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203071646500.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com> <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet> <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lRlW1AprUn9mUCz8rP+23WTXYpiNO39EJOzSeSL5WqNU+6hnm8E
 Sn2kEzLIF/n0pMbUjdagESgbD3umJ32hNxD9Vtlio/tow8T22/tEVfdQb/jRV5sx09vrTOo
 xlWDGp/6gwyfyeuJ3QF+2KCt6s6pmhL/+J8k/4RdXZQD9ey2VYPiMQzyn48Q3uiOtxPuU8i
 6FxIkRbs5662Occ3pNM3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkC9YQoU0fM=:lNm/USckLRIohuuPaXnTYa
 HGhgQCwDvAEkGn5fATKSQ2fRlpEEewa7QoPx/GXiVm9wtAYMJCG5beYAwE0vLjV++rHnRjR5h
 JczbV6t7dfOGQM4PGBELIwkLEWPLramJ3EWTQq1s0uQzQe75zK6+R7dbuTwL/MF2Zqe1dhxt+
 bQ5fKeX6ThDCYNg0iAOE/owfRUkAkI2X1zT4Ko7nfWN5DS/n+mw+LVEKhEuGnjDUIQytR0TUi
 fZ6XGNqw5ew3fUbZKs79Cngs2gffDnHM1NWGtTBn3W/2nf+zR/kJRA9B263zw8poMPwGLMrr+
 qjLj2xhW7Tbqsx5xiGB1oLTZ/VVvRNWcGmxGwkfoU0s1ZBUr0fCEu7t4ABiK16Ammwj+6uj2l
 7KGRnUudGWrjH+E56DcCSmIJW0FCTk20ZdA869hRNqzHKhcN+GlYEvykBIsROS3OZvHrq3WhT
 B39hEcX8wma8XxYtJO1Qe6VCbeCtkyEaZOa4iGrjo1SKq+LCcCPN81NuGsA2lr4nHTlQmQSUr
 kyhHScE1eT64Fx4ab3jZF+HGQv8HmgZEnMo6hYZUS5mTNXelciicAvovaesL2mRjo5gs305oj
 35ssJP29bTO5WFjIPp08qzf2mvvfcv723n3UquE48hj1xy+phK94JlYxHjA8DhwiYpDjCUqJc
 MBQYoPZa+xtNfaHHf67I897NTZpXjpzmihSV1+sNsTlTeQ0p+bVopiEqRxKE3Cla2AG/rh7WN
 /q/W01XUmSlLU3CmEZwCmhLIvyJLe707JZvt1kamwYlQMHlB66QAcsJPYdIaM3OflntHWmvjz
 jNiuNNTYvlA8gD5glFwiCoXpgqnTKOuUJj1KGgPBBW6Tezs+I64xaKnmhTUBobUqcweOi+NGi
 uyF05gRcaq2f0D9ZuiyGeAlSqQN7MmN6CBBUIC3bZ13tDLAT664Q9SGjPkzMi0VSQl3/BPong
 syEpf48AlwM/H67GwBValIubywExzk0t8s5CO8Ni6kMgR+++vVhxIIgNnimw7PEkcagu2tn7F
 +nGNu9lAkOfSXUNeIuetU0Ta6osiPZ9VJ1izTGEI3laLcklNT0BhFpwkH5WfhfJGaGRMR7voA
 lioLRJTDQ4Rdd4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 3 Mar 2022, Junio C Hamano wrote:

> GitHub CI seems to fail due to lack of "paste" for win+VS job.  This
> was somewhat unexpected, as our test scripts seem to make liberal
> use of "cut" that goes together with it.
>
>     https://github.com/git/git/runs/5415486631?check_suite_focus=3Dtrue#=
step:5:6199
>
> The particular failure at the URL comes from the use of "paste" in
> 5ea4f3a5 (name-rev: use generation numbers if available,
> 2022-02-28), but it hardly is the first use of the command.  There
> is one use of it in t/aggregate-results.sh in 'master/main' already.
>
> We could rewrite the tests that use "paste" but looking at the use
> of the tool in the test (and the aggregate thing), rewriting them
> due to lack of a tool, whose source should be freely available from
> where "cut" was taken from, does not sound like too attractive a
> direction to go in, but I do not know how much work is involved in
> adding it (and in general, any basic tool with similar complexity
> that we may find missing in the future) to the win+VS environment.

I added it:
https://github.com/git-for-windows/git-sdk-64/commit/e3ade7eef2503149dfefe=
630037c2fd6d24f2c14

It will take ~35 minutes (at time of writing) for
https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D95542&v=
iew=3Dresults
to make the corresponding artifact available to the
`setup-git-for-windows-sdk` Action we use.

Ciao,
Dscho
