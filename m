Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728E21F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfGYKHO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:07:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:41829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfGYKHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564049232;
        bh=M7tyv19Qj1rnOtcKYdWEHIMkG7g6Z3ROQ34LHlC1ZlY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jOk++kjbts4RqAxne8JTFnKfwxnxSgZt8mwg2mDezozw4GJdBTeh0sy7Q7R+CJpLX
         3gTeOkfbBLrN1qHO2TAIOtLq4zDJrDGt4GJdwkDkhS5ljkJ2PKuDjgQ6nHGCfQrdoF
         nx+NTwV0vzXhcJNyMREJj4Zwx0wQxu5Y19CTd40E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTMzb-1i0eb11B9L-00SPZd; Thu, 25
 Jul 2019 12:07:12 +0200
Date:   Thu, 25 Jul 2019 12:07:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: blank lines in pre-created merge message
In-Reply-To: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de>
Message-ID: <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1909709573-1564049232=:21907"
X-Provags-ID: V03:K1:SPAlNmlRkz2w3aPC4nsC5mdJBYaOJH+BDNOi/5qu+TheTb3CJSt
 p3sbldIBUNz0XDWslJqU6DXCFdvu0mlViamuT070DxK1/VUfhgPNZxJro/7bETGmCJqf4zT
 FwWwOUQOf9LKakTy/d5P10o/1vO/T6UxeRAAMYC9eE2etQ2hRijqoc6j/yYxSnzUERfveKv
 KPLbZ13Vfqt3tp98fYTOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bj+3I3s7urM=:ltV/snwr8R6FDACGW86U1I
 enPDEnpc/VC/ex0Sd4M/eOtwW/PUFm4Ebddg/cnXesc8XnQCaAjZ23RwNj7A5xK7u3O79slIm
 wJkJru4GVsH1J9nZoauOtnOuCfhnyxcGJ2BWqlMIduLr0Mfdexk30K4SHElNUBuVf92Jcz1P/
 OvpEGnCDOe2ps5pPnyWxD+W7xWpZeGdayY1/2d8sQS6enHwnDxddg9HSD7ZVBJUanfydVZY8R
 /pc3eBa0v28KJLWB6zVc8Edga0JJX9E3df05Vqca2FGj/8JDjeiY8lZrn5xmlS2/6V6phaSQ+
 8jhCR+A/ZucilGu1H23TtdHrROZlGJ9NyC8NCzuKPTpNkGJJxvqRnD3CvC7tz4AhH4+42AceW
 yYRzDfNkGaRjvax2raUiTUd4LnTtNbiM0Lx9+jhqN2mIaRKCGOLSxxEf5r7UmsdjrkX3zoItW
 nJO2N+7+hpKK7SQ0uLHefIMV7LWiM6Z9fsb0bdQKgN8VO65arMjXunPkzN1b0PJkmZnJhiGQ7
 2aeSHP4x5CWnfL2IMuoEEpeMCZuEXNf+edQDRhQfc8Ysne07UX8PJ7MrRDDKukyOOD4TXBSAC
 vPWU4N7WUneeFmcBSJqmf8zPn3qGMYzeRAC9l1FAOLufEM+A49finDTrlEt3vkNihyX1wzaYm
 ULhe6lhOdo8U8S+bz5agUcVzDZz5vOESS+eDf0UOKG672Hv/0wWmrqwS5xtQirDt6PJkt5Je3
 ztPYrMy/MRuO5xcXlFBZq+JeWpaKmMPVGZRkdH7eyglX8ltUYIreymY3NXKhU4l9MHpJGIF9C
 c5DMzp3BlXggNBiSob9sWOD1A3MaiteKotog8ZOnR93KsF6NAKB99kjEoXT+ND0a0DCbBeUFq
 55x8u7vkL/am3LGN6ATW4B4TUhkYnFaCCeakWkiR0fORYkJ6nOR/G4dv+aMrqbadY5OaUs7T/
 ETPI15rZrHKglnEWoCvR4eRpY8HuvHnf5SguvTo/7eMd69F8IuYI0j8RmfGJYttqAa5XTbxXI
 wQtGx1X3/72DQojj6FmRuN8fQLie5Kmi7ppku08YJOSGYZ7YRfZE5YViGSFcbqvd9vpifaj3q
 IlFFc3re3LlFNHA6hc2DGq0cmEqjUJT85v0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1909709573-1564049232=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ulrich,

On Wed, 24 Jul 2019, Ulrich Windl wrote:

> I think I had tried bringing this to your attention before, but I think =
it was
> without success.
> The issue may seem purely cosmetical, while being easy to fix (is my gue=
ss):
>
> When using "git merge --no-ff --no-commit ..", the pre-created merge mes=
sage
> always contains two empty lines in between the comment lines. However if=
 there
> was a merge conflict (being resolved) an extra blank line is added after=
 the
> first line.
>
> In vi those empty lines are easy to spot, and I routinely remove them. B=
ut
> maybe it's better not to create them at the beginning. (A "normal commit=
" never
> creates any em=C3=BCpty lines in the pre-created comment)

I could imagine that
https://github.com/gitgitgadget/git/commit/b2f5171ecc2feb4192acd80f5a6b05c=
06e099e97
addresses that. Would be good if you could try; just build `pu` from
https://github.com/git/git (`make install` will install it into your
`$HOME/bin` and you can test that easily).

If not, how about giving it a try to fix it yourself? This is open
source, giving you great power to change the entire source code in your
local repository as you wish. And of course, with great power... comes
great responsibility.

> My Git version is 2.12.3, but the bug is probably quite old...

You might think that the bug is probably quite old, but what is really
old is your Git version. The current one is v2.22.0.

First order of business should be to verify that it has not been fixed
in the meantime ;-)

Ciao,
Johannes

--8323328-1909709573-1564049232=:21907--
