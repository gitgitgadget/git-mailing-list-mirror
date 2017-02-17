Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203B020136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbdBQQ6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:58:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:56580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933900AbdBQQ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:58:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwXCt-1cJEEO2sLX-018J9o; Fri, 17
 Feb 2017 17:58:11 +0100
Date:   Fri, 17 Feb 2017 17:57:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse tests: add tests executed from a
 subdirectory
In-Reply-To: <xmqqpoipkd3l.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702171755470.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <cover.1486740772.git.johannes.schindelin@gmx.de> <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
 <xmqqpoipkd3l.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/S9yg0/pD2b8lw3deT+Q6o7ph00QJllDPX9aZbH6Do06sj/6t3j
 NC+BkL5OxkUae3t2nMADW5jAG40XwY0y1NHkhGNoKRBbUcSJ+KHfdLuuXBvdmUtRBzN2cxf
 5k8swqYfzbeO/iXYAHz6TPeRTaQAVEUtEFjw/mcUnVjnU2AA0MurmRQwytiN2CCjOvy1egL
 uIYChXskcu795PTA7E50A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9K1MVErMGBA=:K8xVxJJBjvwlpxynW5LRia
 WcKTtC7rAScCNnJyz2tmLPWuDOpzO57oci0SgndXY6A0YUm4NDsWYLMtd3QJfb5vg7LsUEmam
 FvGe5sqam6UrOW2zc3u6fLSPpBMQpC4HhHkrPRCA2YWcnayoGUI/oa8duVkVVmRhQkWgIFltL
 X/vCNfUaMiirZynpJfKDhYilyLw1b8Wij4/qCj+Qx93pvE4/TGh0j3rwkWu4QBkpn3cbPbhcD
 GFxg9iqN2UVKAJ2VAdokM0YSYwgqyPXgJCmbCY8M0f/K7bM5yWcxITmFFei8/K3Ko3BkfkY81
 PfnjYDDciV90KVCJC2VeYhSTfRZNZLXjOEbZP4142DtKwjhcKxD/uq9VNmomMGME157IW0Qqm
 a76KOpOOGMoTYqv2kihu3cmdAVqnwYsgjMpPOzORSGN/C8TQGGSX9fgKD5WXqynKHIQywI8pk
 AdCRXBC+e35Sg58vM4UWv0oHUS1SmbgpYGmNzI+w9tnjpUU0IwFBpfxpGWAYfxCmWXsxThIBd
 ck/Qb3xzjAOMYPgQ57LM7jS4ztKspnabFkoIP6e6jX81glJs7t58DMl8K1xMo3ENonJ2at7S7
 Qor5ZMY2i41U5E6cgtYBhrdZ7qsiq17bJs2iIN1DzZF5gEV5YxkiML5kOnu0F74salx/vj67l
 mZcwSyw3GlX0/houvCZW/ht9jmSwCFaDM4RWUG/NhGheByUiYSyQrqi6AHWeY9zf6R6L4820N
 5kfQpktiON2I79TG7jB8PsHs0ZpWsOvOsNmyt/DlgXpYoEBoBI5d+bZkpdQ+TSftSDCtvSayC
 Zog10LHIKnaoCUFoUA3RbW4MU43Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > index 292a0720fcc..1d6e27a09d8 100755
> > --- a/t/t1700-split-index.sh
> > +++ b/t/t1700-split-index.sh
> > @@ -200,4 +200,21 @@ EOF
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_failure 'rev-parse --shared-index-path' '
> > +	rm -rf .git &&
> > +	test_create_repo . &&
> 
> Another thing that I notice only after merging this and other topics
> to 'pu' was that this piece needs to always come at the end of the
> script because of this removal.  It would make the test more robust
> to create a test repository for this test and work inside it.

Yes, this is indeed unnecessary and even undesirable.

I waited a couple of days to give the original author a chance to fix
this. As I want a fix really badly (because I am really embarrassed of
this bug), I adjusted t1700 appropriately and will send out v3 in a
second.

Ciao,
Johannes
