Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71F41F597
	for <e@80x24.org>; Thu, 26 Jul 2018 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeGZROe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:14:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:58461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731987AbeGZROd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:14:33 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8qOm-1fqN5024sO-00CE2A; Thu, 26
 Jul 2018 17:57:02 +0200
Date:   Thu, 26 Jul 2018 17:57:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andrei Rybak <rybak.a.v@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
In-Reply-To: <b8c65df5-d150-1bc6-1858-c2c042ae4bb2@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807261755500.10478@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <b8c65df5-d150-1bc6-1858-c2c042ae4bb2@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1NBff0hJXwenHxz0mPtwl6Szg3ibJXT0YNTcU8TIDIQ59GdqcGV
 SjepJ+4DUCLAuNU/woPVEI4qC5cOWSe8uv30lk0fkKMm3NnJOIq2kaauMVNtRSv1o8+BtTG
 rsHGRb8QHIThnHALzXF0XccnbcwrplCoAqcqKm3KyqPn9fQSgddANkOJbV82ORcuAaZRZx7
 WDun5b77R3VZl6PtX+5kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nmeN1wbMTz4=:z58luLh1S5eixY0EY7ZNSA
 AplTBWg9BkrV+1uMMxyAp2/Ro1jb3wuCCu1Tmk/htcQrFzlDY/oT2AOw4PkYRhQnV8UTJ0Mtw
 16g85wYbpIFcXwlqb4rj2Bsza9sP/1i7djZ82cgJ4MYzZ/kdAp/arYb2Xck6Tb8nR1DTm0ZH4
 nOYFvWEaMQXmQHfoj8/MXVCTN9eJHrL1kJ2pKu4OixtFbuZwcNk6B0ggirsgSFSByG0qrVQR0
 0Tztd9d34gh+gsPC1z2MZ2SFqze4ajcazMn7XB+Ci8Ve3FBJ5j91w0ACTglzoKgCDhYNDEi63
 1x45u43iBisbYxxMtIZEm4c2od5ULuYzpYsdJGp1NoILxSp7tuZF71VGhaxu8vlpkp+PGaqLY
 Iqo2wrBzMV54X0eNo+ohdexYrOu3K/6cN8dDf5DB38+OETuWiJgDcI+tBzItI5OcFDD/AYP25
 j8VqKkqzlkTu8pzmc0KPMsJdioMa2B44aXl3xKJGZCus1ztJ3pEOyPg3NBDaQIFiSA5XMUZTW
 RoeYKIm0hjxvekLhIDSK+FOHR2EkYkBuZqsQkZEpqVNznnWNW1gOl81B+PlD55+EpkRKv9Ld6
 z4+IDMWX/v53c0crmRAcoK9Im8+u7btTBgxVqQ+2E4PhGc5VZgAF8fkKTmQxW0M++LrC0v5jg
 /ll2SbmTQ/krDustAXpxaNwfh4xy3ez0SpQ99FVsuZU297FWANOtL4tIQcas+40T3/aBhZ59Q
 9kmNeTx1O+vvBrlIihBmEYOIhddYEcEA7tNskricNArN/xzVcbCR3sHj0jzMY2uKhVBs0d3s4
 4lHHXaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,

On Thu, 26 Jul 2018, Andrei Rybak wrote:

> On 2018-05-30 10:03, Eric Sunshine wrote:
> > Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
> > git-branch-diff[1] which computes differences between two versions of a
> > patch series. Such a diff can be a useful aid for reviewers when
> > inserted into a cover letter. However, doing so requires manual
> > generation (invoking git-branch-diff) and copy/pasting the result into
> > the cover letter.
> > 
> > This series fully automates the process by adding a --range-diff option
> > to git-format-patch. 
> 
> [...]
> 
> > 
> > Eric Sunshine (5):
> >   format-patch: allow additional generated content in
> >     make_cover_letter()
> >   format-patch: add --range-diff option to embed diff in cover letter
> >   format-patch: extend --range-diff to accept revision range
> >   format-patch: teach --range-diff to respect -v/--reroll-count
> >   format-patch: add --creation-weight tweak for --range-diff
> > 
> >  Documentation/git-format-patch.txt |  18 +++++
> >  builtin/log.c                      | 119 ++++++++++++++++++++++++-----
> >  t/t7910-branch-diff.sh             |  16 ++++
> >  3 files changed, 132 insertions(+), 21 deletions(-)
> 
> Would it make sense to mention new option in the cover letter section of
> Documentation/SubmittingPatches?

I would be hesitant to add it there already. Let's prove first that these
options are really as useful as we hope they are.

It might turn out that in many cases, the range-diff is just stupidly
unreadable, for example. Personally, I already miss the color coding when
looking at range-diffs sent via mails.

Ciao,
Johannes
