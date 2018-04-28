Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41FE1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 12:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759914AbeD1Mae (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 08:30:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:38989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759886AbeD1Mad (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 08:30:33 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1ew6V53LTB-00LHmJ; Sat, 28
 Apr 2018 14:30:26 +0200
Date:   Sat, 28 Apr 2018 14:30:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@talktalk.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH 2/2] unpack_trees_options: free messages when done
In-Reply-To: <20180428113257.25425-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804281428070.79@tvgsbejvaqbjf.bet>
References: <20180424162939.20956-1-newren@gmail.com> <20180428113257.25425-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1264115101-1524918627=:79"
X-Provags-ID: V03:K1:PIX60n+rVTAmxUYdSxOlS7BdrzDFCsdsJBSP/YQja+JHvXK1zC2
 hd1hk6m1n2qIkmfqE8hm8VyzKH9LVdwMderR4BRT35IaK/Yepi2gQ/sBdd7P72zyG4itGCv
 lcIQ8T9o4JzTu4aXFUHxqOP7uEGpYEQB8ZPG15LTRIT9xgYrQhzo9gUStmxlTlab0hnanKh
 aomYx7OJ7xyQCVacEx97A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cghbiR12Ci0=:Q0DsMxk3hLk7WoI7g9Stdp
 Vo9aRx1WcBZMcaaL2OSCuXDhvNEDn5rpmnQbGNBDkIhwUje46b0H9fvTa7UyweNsQ9zbkJrRK
 9IUCm7IGrW/qlC4GYqsU8oDTMqPDFyiIq+3GH3wSoSVEvO1i8yylV6zka4Lxn3S043RUw5hzD
 GIGcGIULuAdqCCfK3K5ldnZsXUYUJtL2+thfBY5iwlscCHTO8Mjv4VehTWIUNQM/L5tOgxWR1
 68yYQhx5gaPd8fjh1e5FGwYEEXtEzmotzRMG4xeMMGX4Yio1ABOxSwLLi9v38wN75B+hbchr+
 /4LdEPetpgkiLBEXTSkf3qGdoWodjqE2rZQVdwtbhlubOedzdHQZw/ARwmvihDtefu1NyS5kP
 NSSp8cQ3XZceQ/aBZ4ec5zx1KrJBQ6ozIaTeMFaAvnyd+qvQHg3TK0Fh9MsJoyYwqhoVJ5g5F
 VdK/UV6EhOQH93dh9b8OH8f+VhX6ymuCkuEyjQlct7Y46mvKP6VM7FsXcdYzRhtiXY4UBZPHp
 1M6u8TLv5Tv3zsilmld53EDbGjCmpnWg8IdirUpdlpguSLtT7GnF1ASnoZ21QSSbuR902uAEd
 inYv3I9NMd0AZtFqFOGY7VP+DYTeNoUx0oGcXQEQ8/eCR0s/f+e1K8TRYYT8PTsNYrt0R5ztc
 5BOVWkB2969haArGN/FYpq5GcYPMOuDgjOsIS0hwAry/igXbLLfSZmZHydTW160KN69VPJlXe
 ZaHARlelB5jZshggyf20wwfC0Kd3GO7qf4ZMktXmNc4XBvj7Zs5+ZaZVO05smSDsPBVnSqOmr
 ljYyy/2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1264115101-1524918627=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Sat, 28 Apr 2018, Martin =C3=85gren wrote:

> -->8--
> Subject: merge-recursive: provide pair of `unpack_trees_{start,finish}()`
>=20
> Rename `git_merge_trees()` to `unpack_trees_start()` and extract the
> call to `discard_index()` into a new function `unpack_trees_finish()`.
> As a result, these are called early resp. late in `merge_trees()`,
> making the resource handling clearer. The next commit will expand on
> that, teaching `..._finish()` to free more memory. (So rather than
> moving the TODO-comment, just drop it, since it will be addressed soon
> enough.)
>=20
> Also call `..._finish()` when `merge_trees()` returns early.

Looks good! It is missing a Signed-off-by: line, and you probably want to
start a new thread that also includes the "next commit", but other than
that it is pretty nice and ready for contributing, methinks.

Ciao,
Dscho
--8323328-1264115101-1524918627=:79--
