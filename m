Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5721F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeDTMXZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:23:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:47867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMXY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:23:24 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsfrR-1eOqWX4249-012DOx; Fri, 20
 Apr 2018 14:23:21 +0200
Date:   Fri, 20 Apr 2018 14:23:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Harald Nordgren <haraldnordgren@gmail.com>
cc:     git@vger.kernel.org, tiago@gitlab.com, christian.couder@gmail.com,
        sbeller@google.com
Subject: Re: [PATCH v4] bisect: create 'bisect_flags' parameter in
 find_bisection()
In-Reply-To: <20180418210535.1862-1-haraldnordgren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804201422390.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180415085841.1269-1-haraldnordgren@gmail.com> <20180418210535.1862-1-haraldnordgren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0xbPEoYbowOnTzFn6nzs4fJHSINT8T5qi21uubhx4JdDL+mYhoW
 +2wCLAMnpB1sX+IEkX8SYhka5LZV/7kpFl78z1+9UU1LjWTOstOnnTjI8roy0gh1ym2hRPz
 PGIV2nidyflT8IZIAJFkFIo0fBs9GMP/2SOinBasK0qdVaJBuxZO+UgHcUTsPmrpzsAO3h9
 RX0roGEgqocCw7zU1RMjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jC1rv9RbLj8=:tnghQSyDFxq+QnoBcI1Rly
 LgKkgyuPfju66eMfbCRMcM7WoUrgB+eAjdPE3psMSBtLyzfe+Os+t9uF0UD9ewqFJuP5mU9kS
 xXzNDj1DEsGDvtVmv7yvyESpkGYuJAZfTNTqHtXKd3ZX06RZq4HkU8iH962sfsc43PU6tQL+N
 omTo1Tc7oH0XnVtGQqoPcYwYGOraMHEXv0xP0ZvCiziG8A4sI0Ybl15yf1C4o80v/bkfy3If6
 b4faIaq5F7hexZ2gLtplQ7kM+8fB+iVfkix386TJFRKzBVLwwuwR9WXFWSJh0Cfm1llB9wSow
 RXk9TZa5jNmDxLoJjOQugVRVNcBRKlQJLlIgTspy0ZztdKFmjODXO/m98dUeLHDhGgsJwgW3F
 1IV5tolpHmbiewqKzo6O2jxxgHFZQSU5BQc60wR9RFKJsZXSok0fZh2GoUO/e/0uztatyP3DG
 K65CMLcQl/4xPQfNoLa7UQQC7ARX3C48bD6Emj1/uN8KjgQD/V9n4Uh0PJnXtU8Hl7FfqAKir
 55IJTTPfbvfna0ZZh0McsQP7ZoM/nDxIIMOSZbFSnKAxfENbNuxkTEd/vuLzZ0vQHNFsWeLzH
 fY/KZxu1V1mJS8duQR01oxtzzJ06dVA0nqSbA04wAuiksZYS1H2S/AbzMUaZ4NZPaXB8nADDT
 aSEa7KxF2bKVw32JjwWxDTMnMLPciFafryP2lRhg1N7c+7ZfL9vdNSeEGoKXADuUxv1TZVOwY
 ELldesDUro75rMKILOzqiaRxmrBNHIhmiTf4SiQdJsNCOPz3FY/AO+fMvtNHXT8UYrWUM1DpH
 zGDHM4LfpFqsfJ0/kTfSG+AuVCVGPTSEpriV2Mo/muBHJ7N4tk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

On Wed, 18 Apr 2018, Harald Nordgren wrote:

> Make it possible to implement bisecting only on first parents or on
> merge commits by passing flags to find_bisection(), instead of just
> a 'find_all' boolean.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
> 
> Notes:
>     Use unsigned type and cache flag value

This version looks good to me.

Thanks,
Johannes
