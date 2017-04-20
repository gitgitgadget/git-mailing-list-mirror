Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071B0207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941993AbdDTKt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:49:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:56110 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbdDTKt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:49:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6SE3-1c4VOe0HIx-00yOqV; Thu, 20
 Apr 2017 12:49:51 +0200
Date:   Thu, 20 Apr 2017 12:49:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 02/11] t0061: run_command executes scripts without a
 #! line
In-Reply-To: <20170419231327.49895-3-bmwill@google.com>
Message-ID: <alpine.DEB.2.20.1704201248290.3480@virtualbox>
References: <20170418231805.61835-1-bmwill@google.com> <20170419231327.49895-1-bmwill@google.com> <20170419231327.49895-3-bmwill@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:egd+lAj/9n1AT5PgNOPhVPVrAzE6+HmBKQ3/oULKMRUus3hlXfr
 DlpGcvtR1QZ6I3K+eLePr8EACEr4MKsUzOlM+GmiB0yKHHCwCklzNviVgKO2aUR63yYh5g/
 HxdRstmrXFCjr/Y39TE5FZaVn6YHzeFbG4qwfxrdOY1ELUw7f8sGkn1yYyApRNikY9++/U1
 nr7XjG3LdjzfGNWlj3fQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eh9tH1xbYZk=:9if2sTcE8dsJGRNJknX2T9
 PrcoyOQB0Y1Tq3sQkWWH5cupDLuqMv0scYNV13Gz5tGToWEgxVE1c+sR5yPbDU2BqUVl17BC/
 E01CKVs8F2Rkbt9iXnYplU5Hhcf3bg9aKMqvlOm5lxvc6F5Xl5lxnn1Ypw5h388zesmnzcSn/
 TyVN1Y/Dt/zLGEJC+e9QUo95+k/IcDg9NIyfARQUyN0AhWN52AyWOQKm3gACJnVL4qhMDH6me
 Rce3LtwIiAIKMcrd5YaciV3PoyiJfKP6Ia0JL5LMpmTKjxKG4slboQksQV8WnsD5nffJK4rAP
 zmZe1H4bFmN8TXSIjQ8qgv3DnwVC+egRFJZJ5UyvSDXklRUiy+losTfI2kc9aUjfIBzkBQlTQ
 wqOiTGlUg+q+G7lNdV9L77NNKrAL8CYpk+da6y4pIjKzNwTJPdJ1oD+8sQSkQbV4h5c4XNcQV
 mdnsDb5Ox86SbaxIAE+chyOKWh5YkzPc0i32nGrzjzk1ofg2zCIpACPCl+mklcOFLZwzbL/sj
 eTT/kk5P257PD7C//OIv4ZBwrDVpxlfnvFkHdXSHR/8sbQKL0oC7OUfyS16Z/wxVzUJXZPYH4
 o89y9H0zq1UOaLSrU0dUqOm+oivF2GseooG2U/U3DiM2jgUagOpSYM/BoEvHEmb0rxOwbdXbB
 cXu1ReuVCJquweNSU25YHfliOc+xEeLYDxERBlaaxbOiFTIpAzNGr/9dsCjv6Lv2T/37hK7Gs
 TaOkseQSaIDaBA+3CWDfXhfDeiS3HdN3E42ZmdyeZCeuRrKWJsY0Q/pUzDVH2TbRefms3I8Zh
 zxg5lPZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 19 Apr 2017, Brandon Williams wrote:

> Add a test to 't0061-run-command.sh' to ensure that run_command can
> continue to execute scripts which don't include a '#!' line.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Please add something like this to the commit message lest future readers
wonder where that !MINGW comes from:

	On Windows, shell scripts are not natively executable. Git has a
	workaround to execute them, looking for the shebang line. Shell
	scripts without a shebang line will simply not execute on Windows.
	Therefore, disable the new test on Windows.

Thanks,
Dscho
