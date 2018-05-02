Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DD921841
	for <e@80x24.org>; Wed,  2 May 2018 06:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEBGzz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 02:55:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:52389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeEBGzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 02:55:54 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1f9Log0SJc-00DDYh; Wed, 02
 May 2018 08:55:46 +0200
Date:   Wed, 2 May 2018 08:55:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <Ben.Peart@microsoft.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "sbeller@google.com" <sbeller@google.com>
Subject: Re: [PATCH v2] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
In-Reply-To: <20180501124603.21896-1-benpeart@microsoft.com>
Message-ID: <nycvar.QRO.7.76.6.1805020854550.73@tvgsbejvaqbjf.bet>
References: <20180430142555.23260-1-benpeart@microsoft.com> <20180501124603.21896-1-benpeart@microsoft.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P9fK6+NeKGj/admv+ncC87cyiiYBQcapN5lXG4gKoDGMsFLK7FJ
 41CsJ8rAnO+4dgklAP6SyQXPg/Kh4yYdy4QQA1lttMZBnifPoxl1Gi8kbq8OR7F880pT2BP
 UySwRSvgPYrrp7AGLlH+vKV7W3FnsPeTwEeNa5sk1RQgzsm2MquL4cLmUJmDJ8yzMOKPwSg
 lDapouVEpPUY2N5WG8yRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fqpZlM3rYio=:glhVEEi9kLh584X01lcHnu
 xkFS7quZVynyPwJwGNtIClsO+RJxoLWmje//UwGkhlJHQW2hEKSlWiBVdM1HZFkL5Z0R2NGJQ
 hZPXvzoPiEh7V9+cKLf002Eapt4HWTPzaum3hOjoZ4QhTNZIBrag4jmQLWOiVVIsP4kIbX+/K
 3AzRWDI/Z5eo9RnsEtCGXrxF2Cbb5zjBYsjzVjhrlgESm6sg2DuEzvq5wdMz4SPhfZzxLgGSf
 VAQQ/7E13EJ04WbVbnZoTbq+VeqEJCpcs1f+224d2seLL7NuXP/waL2JcsVeFtYFIBqhIuzJQ
 y2kzlI4eWEUyS79gtKEVDpybE3Uf5phc4eEpUUM1JSMiRvoNlMc5xfLUaZhpqnFJh53/Z1uy0
 vA7bQXbMhrrCX01VO2SuiZih6RDLt5xuxgfPiz4UfY7kuT+Kv94plFY4aCRLFciXm/vnH8Bxx
 x/uqrzGudyHMYWn7sTDC+xKeVx2OzCxevnEP4GKjbeVwW7+2Y6hRA771d9xD7sXTfRats277N
 rImTK58mO8l2SRGeydMjgf8fc2HQdfOcp9vIv+rb6PH6b+mwZYmmjOSpu1m5bg+TEeqSBrrCw
 FJATz1mFG03kBNaY3WfGoBjMSF5sLk0vAhPzNDu9aXUjcn2gsjvQq6x3LGEvPjs6Arh8o6oO6
 wlu7TGR+46udtyR7Y49gTXEVkqR4zPk0pBkxhJP4wl8erTa9lVhZm4xDGAxUdZ06gOtr0uhq6
 MgvroZvK9lUuBq7T/iRRJ2XP7LZTtJtCkWhK/TaJwYLkp3gggL35z1ZrqIOQA3mz5oCc8JrY2
 z9bKxDp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Tue, 1 May 2018, Ben Peart wrote:

> Take advantage of the recent addition of support for lazy loading functions[1]
> on Windows to simplify the loading of NtSetSystemInformation.
> 
> [1] db2f7c48cb (Win32: simplify loading of DLL functions, 2017-09-25)
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---

Thank you for your diligence. I read over the code, and it is still good,
so you can add an Acked-by: or Reviewed-by: (or Junio can).

Thanks,
Johannes
