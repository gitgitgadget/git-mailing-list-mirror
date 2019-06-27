Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0AC91F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0JGJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:06:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:34771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0JGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561626363;
        bh=LUCQx1PQgVbwVxknCFpCSCrFdficZwJOUD6qwrdFZCg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jz54OrharqjT89xEiJn3K/HPlDg2wudDi1zRUh0cf1l0NLKRjr0qe+svQb11y7W4i
         WiCQVSgk+lPjGu3WNSFa8jbfwPTAJ0v3Oyp74h1rnVR/SiOB1+LbQHF65Vq5aUO8ox
         qteeWNCYBNb2n5GeEVbXSW/fCu6bQ+UtQUSiBTq4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJGFi-1hjBEv22nq-002o2o; Thu, 27
 Jun 2019 11:06:03 +0200
Date:   Thu, 27 Jun 2019 11:06:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Use the right 'struct repository' instead of
 the_repository
In-Reply-To: <20190624095533.22162-7-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906271101140.44@tvgsbejvaqbjf.bet>
References: <20190624095533.22162-1-pclouds@gmail.com> <20190624095533.22162-7-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1581303841-1561626385=:44"
X-Provags-ID: V03:K1:oeClZOq9RfsQBYsqfonHu+qmELRtpGf0rouDfSXtHE5ZVTWCzPb
 4cVKGq3n8KjP/r1n9ROpkME8X44PeyqBZkuQM3UhZYSMTiJff0R4a21LxBjPrQeHDyXB03g
 wpMXxvH5zFBHi1/3u7wKhecsrmT7iQiYgqbXCgx0an1qbNRvucFw+3wR5j8VbbWZFJJVZjj
 DEu0kO0PkAN76gfjvdhqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lzztl46D2lU=:ns0L+jGFo7HIShchflZI0L
 qyQeWATH+CwwTIhsNk5M7H9QpJT3uqrDs8tjwGgDTIlvk2GmbFTqKohY8M0wNCJQzsBcNoR9m
 RNF4J5Hk3y5pvTz26p8+cameiiGCf9iptrwOGY31p7vecrtcwyJy8NYlwQtnR3dIDajbot5nR
 kk2mih5681PGn0KwKTYs+aGmxtL3WSw3c1/nfnthP2vafaP3k1DQXMEjFDLikEGbjeGTDp5cP
 WCoAWFqvL6OTdvxaRtop34bcw1laOlmfcnT9F44gi8qqQTIKOiW849pQDkacdyyXt/cdn3eGT
 aZaP1faji2MxLO+CkwTVIEmFBTl3dhSbcnD7Fh/JHcItx9efy+xNH6QKqQlKK/fMZOfWCaaHd
 m60W/KWn1VkGKdnG7QRJTZFCvsuHXBtPujYAz7v4sDSpOpzfuxquraMvOR3bk3E6sB6iIIYlf
 mhJQaIyB3QnOnkQZYWLGsdNyEuYe4gURgRUqdeMbmpP+l7/VdeY9wC7z+SPZtAGLiQDy7ow3n
 bcgOe5zTexgk25G4DbKyGdpSH53jyR38HsfH7wEeRmNFkBWAbJo68LcxsKd89OrTwBSMjHyF4
 gYrigZ20LKY6BB1oGlMGf0vC/bOTOzLh/IGC3ysbZeuO9WkCM7E7HI6jfjuU8nRVPW6Fz6EtB
 tkRK79VERo4aUkHq70tDAWTFXrhnGfCyYbpaIdZGw1Y+D4AHnADBkOjLx9polRxzXXJvFafE3
 RtxMtKwGZGloULkusUKT6wvXAmhjEn7J96OqT/8U7Rgd9fwuuX22ZgwUyOj2eIULnUVSoq0rT
 ecXdQBhJ4LlpAHGgHfA4nhRugQ0K+YvLcSs2RMG8riv7DhwLAHM0GlvO9scAbd6ETS8IXHbLc
 uw7HRbic47LnHeqp5H02yHBjolWxhreUHNckadrlx+JqOqGj9jo/5SbcwnrsOZZ9dghCqqyae
 M89g8Rt91LixI4tnRffFC4QnAvskzrlCf0IkOiYHqmkA4QytxxjiZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1581303841-1561626385=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> There are a couple of places where 'struct repository' is already passed
> around, but the_repository is still used. Use the right repo.

This patch series breaks t7814 on Linux, macOS and Windows, with GCC and
clang (read: _every_ single job in the CI except for documentation and
coccinelle).

For details, see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11536&view=
=3Dms.vss-test-web.build-test-results-tab

The first test case to break is t7814.9 basic grep tree:

=2D- snipsnap --
expecting success:
	cat >expect <<-\EOF &&
	HEAD:a:(1|2)d(3|4)
	HEAD:b/b:(3|4)
	HEAD:submodule/a:(1|2)d(3|4)
	HEAD:submodule/sub/a:(1|2)d(3|4)
	EOF

	git grep -e "(3|4)" --recurse-submodules HEAD >actual &&
	test_cmp expect actual

++ cat
++ git grep -e '(3|4)' --recurse-submodules HEAD
fatal: unable to read tree (e6d32f554b2f8e48c3b8feece1653e933facb34a)
error: last command exited with $?=3D128

--8323328-1581303841-1561626385=:44--
