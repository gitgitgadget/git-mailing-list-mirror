Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9AFE1F424
	for <e@80x24.org>; Fri,  6 Apr 2018 11:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeDFLPm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 07:15:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:41325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeDFLPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 07:15:41 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX16a-1eyqt13WT6-00Vw0B; Fri, 06
 Apr 2018 13:15:35 +0200
Date:   Fri, 6 Apr 2018 13:15:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Ryan Dammrose <ryandammrose@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] push: colorize errors
In-Reply-To: <CA+P7+xp6fDbabGVKDsRFhixkWRKTuUo_A3UqbQscsBbKiOJmmA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804061313070.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de> <b2771f9d8e441b6f902924a3b4f037b3874e4191.1522968472.git.johannes.schindelin@gmx.de>
 <CA+P7+xp6fDbabGVKDsRFhixkWRKTuUo_A3UqbQscsBbKiOJmmA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B4UMY1l27l40qVq1A96SiAVxP56R3VWj9IhiPWiabyIAfChkL66
 cZJe/PYclxDBsvUTDqmiXaKkG9tcDFOQ1J3jHrGwAyQR2oCvoYdac1Yy+zBiXmX5YC36vSW
 AXE2LnGBP+obWMVovTe9+9Gpyqagc7ZksURO8373Pi5yLZAAD+aUkc2Xp+EqYvAKMfg1jKi
 x0f2gtZ1NMaWpOw654RHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZZ4lULv6EAo=:DVTshiDaVNiAotvcSibcgX
 guPHaVLFLHvKfkhk1o2OyJJWORDGE+ujdS43TOQ5D023vwZCH0lxac6d+H48AHWBIlzOtqhsH
 tVIA+OzOBSami38WK85TK0B/JTFLDKyOg86+JaEOsJz4qa9lNsmRiZstARPzs5CC5jyVDRWEG
 cOLmRWfRotzB2IMZIP7kEj70uigaSiK0SLXoQrH2+vOUfs9JsD2vowWhVrmR5p/ktKeDMVR0Q
 KN/R8pKoa+7Bv8XuQFotr1MEtbdP4XzPblMWrOKX9MzHktGXz/ox66cTcHE7q965SgHRAy4Ph
 jX/EfvkkMRQ14JpUBmRgG18UIkiqjRSl+5vR24sHvvdHxpvpvMWhvbqhExgrS+cxJbYmtyhHU
 OfmEryQTYr0kwgU8sLTew7y9/U9T1SYQMtIAq5OH29bdIk1K9bh4w55AeIZLJZ9A8pfYlB6xu
 RGZLPLN87Oy0f+BAhi/pW3HCWYIEVF/s68+V2Qc/b2NbWl5aV8wCFAdwpWSmRCaJh4523VSMJ
 rqG7SLBePptWiz7nWQOOCydQgJkR2LXmPWlmtfFYjfZNzycshyV5I1IbUcxKtT9qSqP9e1S/0
 C1GQ/pYxSo5nHChoSLenqLHljlQGI2G+JbYiEl49D8cwr0RKgbc+oIcSNVYQJvObDQv52rnWZ
 BlXUir59zRorvoF5tEtggN+Z0AHwIK/GhkNsg/xL4ZbNrdXnzNdDH/ePDAzxTs0Cmnf3bIzH6
 VETXZK93SNK9lVm0T6Mg9J0g6t0cB6zE6uzbpAY5pFiHIji+w1rNIFDJH1pnFBNetmDtsPLWz
 Ug8aU5+ePiYus7StH0HpDXhF5smNqLKZch++h+s2nEYqxkaLIck3qkn0w70gZYQ/AwZNEqz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 5 Apr 2018, Jacob Keller wrote:

> On Thu, Apr 5, 2018 at 3:48 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > From: Ryan Dammrose <ryandammrose@gmail.com>
> >
> > This is an attempt to resolve an issue I experience with people that are
> > new to Git -- especially colleagues in a team setting -- where they miss
> > that their push to a remote location failed because the failure and
> > success both return a block of white text.
> >
> > An example is if I push something to a remote repository and then a
> > colleague attempts to push to the same remote repository and the push
> > fails because it requires them to pull first, but they don't notice
> > because a success and failure both return a block of white text. They
> > then continue about their business, thinking it has been successfully
> > pushed.
> >
> > This patch colorizes the errors and hints (in red and yellow,
> > respectively) so whenever there is a failure when pushing to a remote
> > repository that fails, it is more noticeable.
> >
> > [jes: fixed a couple bugs, added the color.{advice,push,transport}
> > settings, refactored to use want_color_stderr().]
> >
> > Signed-off-by: Ryan Dammrose ryandammrose@gmail.com
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > squash! push: colorize errors
> >
> > Stop talking about localized errors
> 
> Guessing you intended to remove this part after squashing?

Hah! You caught be red-handed.

This was intended as a reminder, as you probably guessed, to remove any
mentions of "localized errors" because I had verified that there was no
localized error message; besides, I replaced the call to strstr() looking
at the error message with a call to push_had_errors() (i.e. using the
ref_status instead). So there are definitely no issues about localized
errors left.

> Didn't see anything else to comment on in the actual code.

Thank you,
Dscho
