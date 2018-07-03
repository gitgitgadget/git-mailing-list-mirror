Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC56A1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeGCLo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:44:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:44893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbeGCLo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:44:57 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnvD-1fRlPp3Uz1-00AjOf; Tue, 03
 Jul 2018 13:44:50 +0200
Date:   Tue, 3 Jul 2018 13:44:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: as/safecrlf-quiet-fix, was Re: What's cooking in git.git (Jun 2018,
 #07; Thu, 28)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807031344080.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G+J0itj4QzCAPj/9OLrA0dNMLt1kapOBgHkX7Fxsxitb7A5UMw1
 DJkNetTpKm06N4rKOTyappPVzfKGSUl5ihv3WYIqGCyr6t1ibO5ZwZTj/bLi5TuaP3d6/XY
 +XkmpIBdA57PzpsOnXkCH4mOucatkCuhjow1Dmgh5sVneS+XXBYwA92TxzYaq51gVx2TdQR
 gTc5fguoxameRaw0jQn6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X5ZcETeVwXU=:+i3cBsndOmlVKGJZTtrk3G
 02a+ZrZG4GIdVXpNAwWuop/g+l8CAxIDYdBhmlJHy3MUjLHpSIZrf21UjGK+XtEjw7RhO1T6T
 lszl2vJl2HfIqtQSkbHulA66BF15KX+UGe3Uul6hOZoJQzQMK03JKqe+1FEEO4YLgzjRpdJ9+
 mT8Xd8XZ4DNbxKBLXANY1GtWQPwt+aqSKokLBv23Fk2BzhzpDfpGKQGWA/RLz5Bv5N7hbzReg
 XS7N0nUs6tHFq5FbfPNWLEb7e6w1rZFxhGSvsIQMTjuOLUBLL//DLiLBsMMiqAZRul1Dr3mUh
 l/hr1+gtRgO1Qdvhu7SefVo8RvaGwW3ifwexGTXpa1PzZVHPncu+fy9W5VwscaHHDvHhAZA0b
 lclSAdTV30sNLjP1FBr/WOJmgRDr2US2b+7UHuqXlWwizR5PoXnui3UTYTf4l+Ic0IKWgrG8R
 msQT6QKFUPt+LA0gZhG9pipvEEc74hiSiHkXN+yPbS6bAu96/haebCXHj6eTAVu4atyU96PVT
 4CV2XyhfsRzjWNEyNx/v87Jf/hgGXckRFtrMSO7lUw+PwYK7DhOvzUkx9okjp+PP6GLhHhLZw
 +hY+SPSUI/WuOMhdRuGZHeq9hzRBKlfvXr3ogsYzUUO+mAwJSLe6qU/rHHNf7tOP1S721oEgF
 IcfaeYlCJ7dAj8ypkZX+aNWDLno+52vndqEGxBnTzbm+/mQ4lc34wJ53AB7glHIau/UxzNCiI
 +eQRbhRSOsDx4/BrMhw1odaXrBqVd5UyQYpsfJ1zy2mrLJxRvD0MjDuTXsGXdq+jVZh7Ae9bN
 +eAa1yl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> * as/safecrlf-quiet-fix (2018-06-11) 1 commit
>   (merged to 'next' on 2018-06-13 at b163674843)
>  + config.c: fix regression for core.safecrlf false
> 
>  Fix for 2.17-era regression around `core.safecrlf`.

Is this `maint` material?

Ciao,
Dscho
