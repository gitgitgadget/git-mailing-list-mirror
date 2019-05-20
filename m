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
	by dcvr.yhbt.net (Postfix) with ESMTP id 193BC1F462
	for <e@80x24.org>; Mon, 20 May 2019 17:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390270AbfETRB3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 13:01:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:39189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389270AbfETRB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 13:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558371683;
        bh=wU6sN5D6HgPDRsRQgAUVbIvhnnOBA7xXlMr4U9PAI+o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IxVjGndpMw6ztsiNoynSI1shAaer1M04UX0zHOQe2KXAJc1mIdo7HJj7cohVlDQV9
         nbC7YL6sU1SQaEz4cFtrRDZJMe4Obu08LZGmc+E6duejyIP4zaExmOjUNMc6FEBSpv
         7aXASl7be/wmktHG56BdgmivJvAcNI0H3n7N91Gk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1gk7VJ0nvG-00inDP; Mon, 20
 May 2019 19:01:23 +0200
Date:   Mon, 20 May 2019 19:01:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 0/2] nd/merge-quit updates
In-Reply-To: <20190518113043.18389-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905201857120.46@tvgsbejvaqbjf.bet>
References: <20190514091322.12427-1-pclouds@gmail.com> <20190518113043.18389-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1874229009-1558371683=:46"
X-Provags-ID: V03:K1:b/g1ZI9QY3eIlwBUawy8El0F3T5FfJU+3Gqe91vT7LRk4fNGjhi
 a9PTzuFSK1T7MC3UN+utYH8Opqtqf3+Gb/smJiawrwf7b5FX9hsAMViUL7E0bDig0cbYusE
 D0LHHsAz4N8X0xrzNMwd4n9yDkpeVGBehf7g6EyEX76YPUG93gRrItvlWHDadRoF1y8ZLxj
 N21/qMp/FUK+fguYzHv7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehNfcVluglU=:fb5T+JHayVIo/ydW2dme5P
 6aSJswEBReClnvzrkuzVKxzkoifSU96rL0l4O1BheLgxHG0v2rYPoKzdj1/YfmiHVydukSs6w
 0jSVIgj8071nFAfmrYADD0/RVleiy/y/BiyQbx6TI20PEDkAAUmj0a9Lt8ZAw1K/Kvw79Qt5B
 9zkbt4wSdmEsQs7hA5LGQMkkm0redjtxm95TwV+UicAyTFTmhwceUZtViFG0mFIfT8spHixBA
 d+FufgAgJfsPvoedZJiMTmec5bZFFSoz0Lj97zvXtD1QJcE6JFjIKfjjEEknpluQhZKGDCVxS
 5+UShKPkca2dftis9cM5zgCtjZ5yIFApFWn8grevo2Ez9wtoHgLfJ0AMSHxzvwnrFGHVru6SF
 pGHyMoeXgDGib1eRL1eVWI4w1D6gSl218F6hL7dY0201pUVL1mi8wdLf3dx9bYeWBUEUqCELi
 lRDjgKwOaPLRcgjBkHh+uds2dkVlfJlRJDGKj4tvw7OYrQ6Unji55aHjSZCuV0KKs++UOF1+f
 ewdWH/uixYpIu0AokgQIsnfAdIvAZHP/oChblly4i4LySwj0lV8ISwjascCnYBZKHvK3vyfii
 Bdro1NsS1URgZbRt8RHbIanwFSgZtnCuXzmMZu1RYjI70TY7rUstV4wcRb4w2C9OKGBnGR9sj
 UdryLJC42+dRWhdLWSaYqoZvhYuni0QWawX6KLqRvKk5OxnXkCwMn5hsCTVGGB6zP/of5sLEL
 TxL4NFg6L/g4prcrGHIhPjpglRlPbWS3FzGGCGpIGjTMWDAO5EvfPOGInsRxOI8jeHCnpPFSL
 AuH6gjaw8zwUwM0XHGiQLn30wGHRHZi1vB+iu3WKj7uimkVX6Ls8yS0vLrsDa/8kTmWhIKGTs
 SeF2zVurWisytTm4MRw1O8Y5Yl4r+MhWlU+fXepaosca/MwMjXtiZZ53gE+nfSZbCf9t7+Ao0
 L9E8jH6hTETK2zaG4hTY8K1QoTBAME6vxvuPT5jGpxUctvtQT5xPy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1874229009-1558371683=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sat, 18 May 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Another round because apparently the test case is not perfect.

Test cases are never perfect. But at least the good ones are "actionable",
i.e. when they fail, you know there is a regression, it helps you figure
out easily why it broke, and it helps you fix the regression.

Many, many test cases are bad: they break for all kinds of reasons
*except* for a regression. They break because an error message was
changed. They break because of timing issues. They break because somebody
inserted another test case. They break because a missing prereq caused a
previous test case not to run, removing a side effect on which the
breaking test case relied.

Those bad test cases are very frustrating for people who actually look at
them. I am one of those people.

And if I did not know delightful test suites that are populated with
"good" test cases, I would not point out when a "bad" one is contributed.

So: it *is* possible to have a good test suite. Let's make ours better
than it is right now.

Thanks,
Johannes

--8323328-1874229009-1558371683=:46--
