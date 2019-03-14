Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F65620248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCNPVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:21:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:51685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCNPVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:21:09 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEXHd-1hFgRS0Fvl-00FiXR; Thu, 14
 Mar 2019 16:21:03 +0100
Date:   Thu, 14 Mar 2019 16:20:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: regression in new built-in stash + fsmonitor (was Re: [PATCH
 v13 11/27] stash: convert apply to builtin)
In-Reply-To: <87ftrpbnkg.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-12-t.gummerer@gmail.com> <87ftrpbnkg.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-547523389-1552576863=:41"
X-Provags-ID: V03:K1:SrDz3YfFhNfRM7qcy/tMSit8TLbh/Lruaz9s0CzZVLAL/URBuf2
 kQWz1OrJ35Wb8Oy+g/2SFBcDEZKaSDuKNY0393xQ5m2SzxApXNRncABwYXBfsfTuvEdlCh6
 5TGmaCfYVNlszvnTBiG8sa2gQ6CGk/5cwgfbSkndlD6ul4LeljWH613rgFF6H+RXt6plOEw
 Z1AO3NKOpQQnU/KUqW9cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0sh+8+/quKE=:4WtRSh/x3+wJ4FFDcXyDm0
 YR6rT8QC4FA1GH+O5QQniDsiTbTQDR1hEn6JQ5Ze2dMD/qc8nNk41bhBcI0OKjmSwSSkMqwC5
 eqz2XaN+uaRuW53oz18mRKVXN4j9uHEg4479POBpSltqeuUdc/NHAiEEGZkJ/Pk0aXYzxvcLI
 zkMyz/roph9nO3UoH6k8hz/7ToOeOlgs0lya7irvIlxKPfgo249ubZmZMdJ84wxnvqRX+vBbf
 WhCUoATSF1W7mCCyqAiLszcq82oH7UwSlXAthg//PexpOQ6/Y5XgyEPieZ4Pgt+o7K6QhpKgY
 sc84a/KzKWxyreyawTgn+Ltijf84+kRj4lz0NRag4a8sPiZ98ABKzEj6eLQK3dFyEW7ZhWDDQ
 gQL7qPP9AUc4e7f74NShEMd/ngOqqokqCA+MH0X/zUtyF2eCg3THuiQ0OftXL951DgKdt4JH4
 zEpF8EWpUsy4dHGGRm9UCLk2TstBgkEenhKpAyErDEC8DcoYgVvcwyuJ4OG7TWlCAqhr9dawj
 ptek2d6dZXqw9B1ILofbqSEuIZVMUtZH9kjbS58Za4fvN0lI8WNiXCEkXPpIZq+ZU8PkBNZ25
 HlPflhIJ+MnIbtGrPxjOQykhkyIV5p2J7+om3VUF3XOnkU920PsjvUlOZbbxUt1nZG4bJ+H+Y
 wt9VtFdnyUWEslPxM6o6O5lLw7XpD0kO/adFxWfePOLUewBBlXJlxq5vA6yEdpuN/TCpVxEyO
 92VHcDnw5jsoFwFHCFggtfXy8N8XlV2f6XoHc5VngZOzFGynT6iM5C4xI1944Ftnc5dt7tywJ
 +MIBeCvxBD6k/MFfrQWJmpwJabXh3rXDAwHcNsB8HI8WvcvO7dSRL7SKbxNFQqcmj5XpXebDh
 N2GJBCPbt4fXp+CIEbAGpGnXbz+dXbGTS8aZLiSm0VywCdIP8SrUpKyakJ8ztYh6t6042uyYi
 v7tOvEjHbXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-547523389-1552576863=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Thu, 14 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Feb 26 2019, Thomas Gummerer wrote:
> 
> > From: Joel Teichroeb <joel@teichroeb.net>
> >
> > Add a builtin helper for performing stash commands. Converting
> > all at once proved hard to review, so starting with just apply
> > lets conversion get started without the other commands being
> > finished.
> >
> > The helper is being implemented as a drop in replacement for
> > stash so that when it is complete it can simply be renamed and
> > the shell script deleted.
> >
> > Delete the contents of the apply_stash shell function and replace
> > it with a call to stash--helper apply until pop is also
> > converted.
> 
> This
> 
>     GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all ./t3420-rebase-autostash.sh
> 
> Now fails, which bisects to 8a0fc8d19d ("stash: convert apply to
> builtin", 2019-02-25).
> 
> Tested on both a CentOS 6 & modern Debian testing machine:
> 
>     + git rebase -i --autostash HEAD^
>     Created autostash: 5cd734b
>     HEAD is now at 0c4d2f1 third commit
>     hint: Waiting for your editor to close the file...
>     error: There was a problem with the editor '"$FAKE_EDITOR"'.
>     Applied autostash.
>     + exit_code=1
>     + test 1 -eq 0
>     + test_match_signal 13 1
>     + test 1 = 141
>     + test 1 = 269
>     + return 1
>     + test 1 -gt 129
>     + test 1 -eq 127
>     + test 1 -eq 126
>     + return 0
>     + rm -f abort-editor.sh
>     + echo conflicting-content
>     + test_cmp expected file0
>     + diff -u expected file0
>     --- expected    2019-03-14 13:19:08.212215263 +0000
>     +++ file0       2019-03-14 13:19:08.196215250 +0000
>     @@ -1 +1 @@
>     -conflicting-content
>     +uncommitted-content
>     error: last command exited with $?=1
>     not ok 36 - autostash is saved on editor failure with conflict
> 
> Are you able to reproduce this? And if so I suggest running the test
> suite with some of the other GIT_TEST_* modes documented in
> t/README. Maybe it'll turn up something else...

Yep, totally can reproduce it :-(

I'll try to investigate a bit,
Dscho
--8323328-547523389-1552576863=:41--
