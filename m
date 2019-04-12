Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6A820248
	for <e@80x24.org>; Fri, 12 Apr 2019 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDLItW (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 04:49:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:35897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfDLItW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555058954;
        bh=oja6IJtATOx/52zY748prWTptCMxxQjNZDVydKJBh2s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UD4TJOW1DHbcof6CAbd2iquP28FAU+E3gmUYRjuQppcKfVcdZflRbDRb0Q7xncu1x
         Qmi9hiDeNUNST/f/QSl457Uq+OAXSmzHr1M1XB6mZwkfo/KYyGEm7aP/Ars/vdUDzB
         fctfy1z/MIN3lPkyajuHYHvKDUzx9FthLNXmOuvQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaKaw-1gauMG0lWo-00m1ir; Fri, 12
 Apr 2019 10:49:14 +0200
Date:   Fri, 12 Apr 2019 10:48:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by
 default)
In-Reply-To: <87r2aubsza.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904121048220.41@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com> <20190325183505.GA28920@dev-l> <87r2aubsza.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-469640890-1555058954=:41"
X-Provags-ID: V03:K1:syj78tZLfWEnw8Ia1yEn/izzB0lgJ85bcBxWTsCxC3LULe64EGf
 DvmTjRH27zKko2rP9tOokzh71PAqK70F7zk1NN+hwGjSsMWePcq1TNujBe9AmO9TAlgxE7K
 kz5RjgTxJE8uLrqmtLGq+86vXhN1bEauMA2Dr2EcKmvx/lymn3luSxy+8gV6ewzCvAeajyE
 Ntxu9nhxddsk8umGtLB3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dnoDsZ/0vCk=:rW8T0aHxX9UxD6QkpY35Of
 PFTscG3viTBncwURP9v9jbgFZmujkAvpq5WjtwZqFsfqeMF79YCXLmmF+x7TUvJDG3DCsNA1F
 DwubDbgGiDIed7qF2H3rpRTwpR4/X7lG8QsTP1VL8uZmZG4B6KScV2Ah50f76gU4UIiMuVmw4
 knPlLnZgbxKg+eV0sJXD++72UzrDv8x0WuDnt1r7AmfGz1pD7Ec6KEJWJ9CixeOc6CCRRufDY
 G9OBhSuCohfBiOwwpIWrYlXoNzpNMcTqLXK98pL+o8kkeUKfA/D+gc996tISrZ4zpRW16KIEO
 TuAIQNtndLhs7FrwT8lPV/vedSIYBBxxJGThXc6wBKtsc5tGQWU2eT3em7ii3pxSDOXQlwruj
 VXh7SY80KLBetfTDOyBdxanJkZ0kstXI9coF20tCG7IK+CowRn7wH1cLmeClFBA06PdCJ19yj
 YqNNAay351kwJlzGjwuVYiCPvSf3aRQtL6xHsyjhH3bkfT4Qe3jvTBN+7RAjTD16nuq3MeiL8
 MdtSAxhgMrvC5pF551P8T+gGDzxuOOlHqomjFTXj8jvTZGyXv4B4kxa4V0sEBx0c23jAReW2V
 OEn3W+gVaSp/di1IsVDaQOlZYl3hWTO7HXhBxBkBHjlIy4hAZN0do8C7JBCn3hCNHAaSi+XpI
 E0EkZDQFzEJp7MLzlJtfPCCnou9wSMgyZcRV+nRuFbB72Io2Yu9iHMF8Y/4HRu7fpX8tLMfyo
 JprIg+AGKCYx6vxaKDBpc+PF0W0rl9vE2S+S/x2gxBV91zbrF0movNxn8W8ZytpgbTjd0z64/
 As5KcG0Mz8JpyLC7Tls9cEvrn0NtTqSZbptI2qZNb5TjPJJCm8v1SVBYomvvp3P1nrRwI6eLK
 Ubn8PbhW7YptwMktOG+wmIrnP1VyDJyhTgLvEufo3EUxzA1muJYObl0YnqlIDs7yZAsswBglL
 kGMRS96SOTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-469640890-1555058954=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, 25 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Mon, Mar 25 2019, Denton Liu wrote:
>
> > Hi Johannes,
> >
> > Thanks for catching this. Perhaps I should've been more diligent and r=
an
> > the entire test suite before submitting but I was running low on
> > batteries only ran the rebase-related tests.
> >
> > On Mon, Mar 25, 2019 at 11:14:23AM -0700, Johannes Schindelin via GitG=
itGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> [...]
> >> @@ -325,6 +329,7 @@ file: (not set)
> >>  EOF
> >>
> >>  test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
> >> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
> >>  	test-tool parse-options --no-ambig >output 2>output.err &&
> >>  	test_must_be_empty output.err &&
> >>  	test_cmp expect output
> >
> > Would it make sense to include a test case to ensure that
> > GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is working properly?
>
> To elaborate on this since one might wonder "but aren't these those
> tests?". I think you mean if we shouldn't have a "test_must_fail" test
> there that asserts that parsing the options will die with the default of
> GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dtrue. Yeah, that makes sense, it=
's
> currently a blind spot that we just assume will keep working.

Valid point. I added a test case in v2 (which I'll send out in a few
moments...)

Thanks,
Dscho

--8323328-469640890-1555058954=:41--
