Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9521F462
	for <e@80x24.org>; Mon, 10 Jun 2019 18:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfFJSqo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 14:46:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:48573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 14:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560192401;
        bh=OxgNe0uUHUtI13gcEuNXLKyB0kmziJYRdBY3xPMnNLg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VGo8jnz4zDfM4tG3fjqRJw4gGSkQzSb0GkiZTYIN8d2L29NWmV3ZK+vNoFqashI5d
         xYnPiyVf/xK80udtlSbqD1Y9H1EluRmGJO3wBU/dF1RToEGD3rEKXaRot7Y5dRmFcd
         BDZs1LxP6f20l+yW67CKIp9EuvD0sMmbbd9+g8Bw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.215.76.8] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqzEB-1gwPnG0kSJ-00egsc; Mon, 10
 Jun 2019 20:46:41 +0200
Date:   Mon, 10 Jun 2019 20:46:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     git <git@vger.kernel.org>
Subject: Re: rebase / am separation problem
In-Reply-To: <20190610170718.2f9fe177@naga.suse.cz>
Message-ID: <nycvar.QRO.7.76.6.1906102046110.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <20190610170718.2f9fe177@naga.suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-585299116-1560192416=:789"
X-Provags-ID: V03:K1:3re9hULJjHzm4Xb4AwprgchNm2/zvjVrKrezycfhUiwcz1uDm41
 44h5qsUEo6lh/W39IZ2mzz0Bc1XrBF7dS6RcGsCl14SfNoCQ1AAo/5yklx0i6opi/QGHgDq
 UXf8pP3cjiTRZMNw+pXIM0DIvNHJnFH/AqJWZIPRU2o5kJGlaGysCQB+MD/GQXaJhtguAfD
 GdKRVT0wxS/AV6yHo/OiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oWYuv5f/130=:yOS7NV3aNwFTWgd/iv+a03
 OTjZVNC2AnH39qRbJmqllEiCTHjMky8gciYmd9Xqy9bxOiw2BdcUcqkzVPq/lV2DR+gbXWfs7
 tzVNjMEbrJ5NEdmVgE06vIQamwoIyU9/fHFSSq/saFbT3dsXvXMXlI4C+CK+rgFUwp07Ylfj9
 BT6fySzgOLCm/e8WpekQqxbdjuR0x88TcXe39NPshMZDwvlpT3CqWwMWRomo2eM9lX1Kn/fAw
 8azmvZcJmEWfsIXNDZkYHrzdZXQz4yhpO71/LoJn/Mns5dL2nqq+QJYKr6gvDQayAsJ3P9L+0
 4rIr2j7oWngHWxxTClEowcx+vfJ59YQZNcJXPi5/MCM91If+al9Z4WCajjisRKpI+rsf/LzLd
 8rIku+SwMQua8w1M8fN95ZNDNxbEwyN1HgsqBTtWN3S88kska2/IMF+z/6F+8UAefMEbBDD6A
 8LtrAgbbZEI6g8l1hPGgAi8daXjjMtoDO2ikDToEInGmg5WQHK3cxYOguHUgSnFNKL6FzRENa
 M09jO44Qm6+sPn7zHyFa8Eug21pS7dgphLXTYA73ZUcIvQYuSoqMxSuudpYn6QB+eIxc1KpC5
 kdEbzjUcEADGm0jyOmVBWeCDjYXyAySH+ThADZIfjd0V7tKJVGgOq7bqxNr552boYl5iwPEeY
 LRKz1Qty1RodmZVgFoneH35B2SRLhn/zOwF6X66YvJBpHCUVAf2UleooinvHZ6sgXNlIMobkf
 RemOoMN+6gtZl47kA5r3QF4S69io2sZmZ+biE/IOggGCJEpqZ09b00xFFNX6icSjPWl8qdUr/
 jvEpG9fnFIxARCS+sTEhmXKQiC9No2/svdtICRvOG6CYFdD+yOulyRWahdxoe9wpzoEbkP27p
 M6IRgdvFiFE+fJBRCPnZByfPg0gaVY5SU32pEG+XUDeRNJXLyCosFW628xF34j506iHYaSzus
 Hmcf2tDHonLUi7dvfbYunIqTLQZxZjM9cgeXu/sy/kFg2qAnc/O9y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-585299116-1560192416=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michal

On Mon, 10 Jun 2019, Michal Such=C3=A1nek wrote:

> I am using git 2.20.1 and just observed this behavior:

Have you tested this with v2.21.0 (which is over three months old by now),
or even v2.22.0?

Ciao,
Johannes

--8323329-585299116-1560192416=:789--
