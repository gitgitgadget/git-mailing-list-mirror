Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAD01FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdJ3Qhv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:37:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:60991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdJ3Qhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:37:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXIGf-1dcyo23B1Z-00WE1T; Mon, 30
 Oct 2017 17:37:48 +0100
Date:   Mon, 30 Oct 2017 17:37:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.15.0
In-Reply-To: <20171030112936.15420-1-johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.21.1.1710301734280.6482@virtualbox>
References: <20171030112936.15420-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tCOHufD0sGSmARIo0fXbusoB28x5rdRkMNsxX+oK42NIm/dB1tO
 rU2hDg5jkNG2+QyKQGG9hUMox0hztdwUVZqm4eFcx6bL+QNAdBEQlxxAKLWHiYBPNXusENE
 r1cUEUjF5qN+1xZ5z03dfm7JEC2dqdhDadYyDPfI5RTVFazjnb/S71YcMwbJ69DetUVnFQv
 dDphSQ69r928hFwOW6QTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QodV1/Ypy50=:nXltOjIKVyDG3fGi3k2FrQ
 UYcTL05gPZZnj/1c6qr+Db7Ngixw9lgZfpjPIAciVra7LDeYbYN9Ldpho47ICah2idp6agOwW
 i4mqm7txgdhR2nZnkmGHNi+qpk5KHRV0fJIo35oQRrKjOv+rO3AiScOX3p+qn708mkQe1FnkH
 SJf+W1ba5uXiZzUf7QQkTGo+Oei+/occkc4m+NhNxdzojzxBdOakf8jjKH4bfiPYg+b5+i5wB
 tGI+3SathfTQYefjMxNStK0h8OlpKUHgJjQJPDfHekP17hyH7jq4iwNF830NijqWjQGYV4IiU
 stq9t855qptX0D6/UTKbWplpWIoDSwJ3c2X0u+TEpDvKKJXLxP/+Ji9fj4+C6uedq3Gma0enj
 tKWKYUOfdqO4CSOtHVbNyqzGCGg7JYipxKv4WmLG+3T+XfHTanoOimrBmlZLVO6oMbp8AxCgG
 NhiEIJZak4P+IwCGM9wbhS3wsRsd7rFKwcIZ+wjGYwM7emW0pmmXEt5FK2B5bvoQSvCm1PiJ0
 5iglgf7cFtWtT6q66AP4Pu7aSGaGmLhSgVuP67WeVGKErt1C0ADtshTDO6P/m2e7sVINi3T0n
 OO0fjXZ2U6caduVKXPi48q4U86NROMZRPtvsdmUl5psj9AtPF6kKTKE14qRhkEstOcALBorDg
 yJxDeg07KQnJddt41ge5f5luxUGx2qwLH3wx/zsvT/BjkAC/J9ufQQ7tL5DlagQVuEZbIpnw+
 FSnEtCAeoXTxuU0KuVwJWPZGyu8TEx94zWnateCdaFlR9FX/hQxMFsnfYPB1QD6FxSCVRTwHh
 C5M0pSKBQ7H2RRDvEU7gACwZ0lgdA+DyZvERpJFvd0G+6hGcQn2ddeyx3zKi7WYgfjq5lGt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Mon, 30 Oct 2017, Johannes Schindelin wrote:

> It is my pleasure to announce that Git for Windows 2.15.0 is available from:
> 
> 	https://git-for-windows.github.io/

By the way, to everybody who tested the RC2: thank you so much. You caught
three bugs. Three bugs that did not enter Git for Windows v2.15.0.

Unfortunately, there is a bug in how I prepared those pre-releases, and
therefore you will be asked whether you want to "downgrade" to v2.15.0. I
hope to get to that bug well in time before the next round of release
candidates is due (or that a contributor beats me to it).

Ciao,
Johannes
