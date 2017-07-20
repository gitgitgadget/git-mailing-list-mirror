Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB36620387
	for <e@80x24.org>; Thu, 20 Jul 2017 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbdGTIXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 04:23:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:51582 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934380AbdGTIVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 04:21:21 -0400
Received: from [192.168.0.2] ([86.56.108.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH0SI-1dLRFM40UE-00Dlar for
 <git@vger.kernel.org>; Thu, 20 Jul 2017 10:21:19 +0200
To:     git@vger.kernel.org
From:   Marcel Partap <mpartap@gmx.net>
Subject: =?UTF-8?Q?--interactive_mode:_readline_support_=e2=8c=a8=e2=ac=86?=
Openpgp: id=2E9589E4B9A4460B66AD9B8D65C6B04A8A39FBDA;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=mpartap@gmx.net
Message-ID: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
Date:   Thu, 20 Jul 2017 10:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2iFt+Xrms9s8pJT3xLnQr/gN4ZlHlz+fovsnM7XV8MPniqGExMR
 ZoAYEiSxEnkDL9Z7meLCN1o3wGpfl63aWzH0/N9OBeQAXVg1UK5G6VJ0OYtvqCBogdUQjrL
 b/HY8n8bQfJRHzLIuAyn00JQDtYY87quxv0WDJlIdDV0YEkHx9vzC1ZX6pjIWFNS7exZSUs
 q4U/qsNnIUha4EybwlbpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R+LBd+Zvmhs=:3jh9qECqMfrXD2bnurcL7Q
 yY6cSRBbCTjlXnHMIMdL9IdvumKTr8hLgsDToslU5EAFKsFAJ8jK3ZSdaF2wCAosXyfaPQI+f
 A7XXlJ+MQgYGSRauC9Ny6c9f/knz77IfVSxBm1Bw3egAkiYokHSh0GVgFHbfV2yeflRhQaaT+
 Q0RdP+c4q+x+9Q1UEkUKhXjYL5c1gxnLxDLk1V/eN9EHdPfCejQQ0vfiGDk5INHn0tPj1ApHT
 v3Kmi+8xO/qDdsj++Ap3z9KK5tnt8YGsuaFRb0M9pVKkq8JzmnYEIR2lnrgfS8nReucbLdptS
 ffIq0QbK0k14gnGaO6sk26vQdWhintP3JujB0iU+7f/8+lgehHZU3Mb1hiW27gkLsL4aYJR8n
 2U9QSF+254/Qdug2+cZ0kqPGsnqCKFCaB4rDR0xEzEJP0410lytwKgwMNcObFjROxZerPTCEw
 2MCZxo4rhoJbA5Nqz8I0o6Uiy+dQ9U+9b42CIOJ1+NnYHW32umFz7GLLwP9+EQhjUYeg52hnt
 /xSPCLcrpWmZw/WykWxz2xBYjeHV4qREYEE7bm5MXVR6Pbs59RQ4sd7E0xxSOnfjAh3p+In7r
 GgziEZ1cOOJak23RAcMjYKgOnMbZiJHeIhaGJXpmM4HnPTA6PJ2+5sZL3UhuQarLInuiDlG7F
 x+bFtNThVxyjrsA2Lx9qLBkWK+lPHIA0rpoDKhQcGOzqKUUw0pdsYYLWSvCnCJEjNX/GHigDC
 P1ghREgLmdkA4XZHqzUtjwE1YOF2if79IQ2mzAz/PBO4u+zD355cS5FvpqmG3tKwjlvVWYVJy
 ywXpXhOsn1pdKg8WySjFI3mx+2FZcdX4Udc2aNzsQ+SMuhLkf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git devs,
wouldn't it be great to have the power of readline added to the power of git interactive commands? Yes, rlwrap will do the job, but still.
Or am I missing something obvious? Am using debian's 2.11.0-2 ...

#BestRegards/Marcel Partap
