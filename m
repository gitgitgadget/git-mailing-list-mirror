Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE50B1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 12:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbdBKMsk (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 07:48:40 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:47679 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbdBKMsj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 07:48:39 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id cX6SciDhdgKstcX6ScIZ5S; Sat, 11 Feb 2017 12:48:37 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=5rxgeBVgAAAA:8
 a=xtxXYLxNAAAA:8 a=NEAV23lmAAAA:8 a=ybZZDoGAAAAA:8 a=FP58Ms26AAAA:8
 a=BCjA09oAAAAA:8 a=pGLkceISAAAA:8 a=Ch1mgUGq4P4hDzM_ebsA:9 a=wPNLvfGTeEIA:10
 a=ezPG0ZpnnpEA:10 a=PwKx63F5tFurRwaNxrlG:22 a=xts0dhWdiJbonKbuqhAr:22
 a=Bn2pgwyD2vrAyMmN8A2t:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6LVbBl2NLSWPyIBDCKCu:22
 a=jYKBPJSq9nmHKCndOPe9:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <B8156313FCCD473C988E790F7ABEC224@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "GitList" <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Alexey Astakhov" <asstv7@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>
References: <20170122195301.1784-1-philipoakley@iee.org>
Subject: Re: [PATCH v3 0/4] git gui: allow for a long recentrepo list
Date:   Sat, 11 Feb 2017 12:48:37 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCgXoP21fQ/FXhKJ+JX4qZHkpqWrYnaieH+Me6IvyT/lGBAi0jTdPVQXt+EsF0+/wrPvkZdjeXok5tDnNC3eh6tJEVqxXK5QznEjD0S2MEUI2VJvy1If
 fy1jvAC7sgOA6yUlrhdaprBHLX/ul3bNm+g5crEbTXOl0o/HjitcFo1eqBPc87Lh+9hFijNR4TfO/uB+bvqAb2vDWGZt81UY17JY849dbD3/SgOruvrzKKjl
 /PQWVDhHlEnf2SFtTl9MC9ynqaKdA6mclw4Vmd9RXfPBAZTrZyW6Ac2OccIbPkT014YDy3ERUxDXRYWVlt1wp/X21Efhh2M4PTO9aQ/P5CI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping

Any comments anyone?
(https://public-inbox.org/git/20170122195301.1784-1-philipoakley@iee.org/)

I understand that the Git-for-Windows team is planning to include this in 
their next release, so additional eyes are welcomed.

Philip

From: "Philip Oakley" <philipoakley@iee.org> date: Sunday, January 22, 2017 
7:52 PM
> Way back in December 2015 I made a couple of attempts to patch up
> the git-gui's recentrepo list in the face of duplicate entries in
> the .gitconfig
>
> The series end at 
> http://public-inbox.org/git/9731888BD4C348F5BFC82FA96D978034@PhilipOakley/
>
> A similar problem was reported recently on the Git for Windows list
> https://github.com/git-for-windows/git/issues/1014 were a full
> recentrepo list also stopped the gui working.
>
> This series applies to Pat Thoyt's upstream Github repo as a merge
> ready Pull Request https://github.com/patthoyts/git-gui/pull/10.
> Hence if applied here it should be into the sub-tree git/git-gui.
>
> I believe I've covered the points raised by Junio in the last review
> and allowed for cases where the recentrepo list is now longer than the
> maximum (which can be configured, both up and down).
>
> I've cc'd just the cover letter to those involved previously, rather
> than the series to avoid spamming.
>
> There are various other low hanging fruit that the eager could look at
> which are detailed at the end of the GfW/issues/104 referenced above.
>
> Philip Oakley (4):
>  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
>  git gui: cope with duplicates in _get_recentrepo
>  git gui: de-dup selected repo from recentrepo history
>  git gui: allow for a long recentrepo list
>
> lib/choose_repository.tcl | 17 ++++++++++-------
> 1 file changed, 10 insertions(+), 7 deletions(-)
>
> -- 
> 2.9.0.windows.1.323.g0305acf
> ---
> cc: Junio C Hamano <gitster@pobox.com>
> cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
> cc: Eric Sunshine <sunshine@sunshineco.com>,
> cc: Alexey Astakhov <asstv7@gmail.com>
> cc: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> 

