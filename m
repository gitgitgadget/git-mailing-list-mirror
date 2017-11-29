Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C84720A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbdK2Vfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:35:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:62213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752645AbdK2Vft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:35:49 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlE86-1erqwY3fzq-00b39I; Wed, 29
 Nov 2017 22:35:44 +0100
Date:   Wed, 29 Nov 2017 22:35:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the
 rebase--helper
In-Reply-To: <6b4e8352-0583-11c2-43ac-ec4ab33cc554@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711292234140.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-4-liambeguin@gmail.com> <alpine.DEB.2.21.1.1711272241590.6482@virtualbox> <6b4e8352-0583-11c2-43ac-ec4ab33cc554@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nfpzfQ4mL3sySQGy9tbjKJ5aga2DglOHZJKF0sfFzCXa9MC0dBl
 zLx+cwQJ8aYo73FSwotyQ+9MQLQMdKa8qI4yA21Hkrr3nAyS3QiJQ/cgL+qYTpIL0DFjM3I
 RpBIMWxuDna+d9ewhtMKaSFbEcJfNKxKEZl/3MnUBgutd4888pRKi52/dEhWwYT15accd4Z
 HCk1W9OkvHhV3o3n3bY2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EBhD0hX8Tus=:62U+c7CZF7P+4BaJk5q4FT
 AN+8gocK9KkJDyOVIgeGh0XWT+CV0H8+oCoSrVqMfyq0y4IVcgyFHvzmOphMFOsx9mvjcdibJ
 Tuk8yrhjZaxfyFnsvxIBYQwaPXWTI9/hJtMWqikOKfM46rLl2ZWWF9AfgSmtLklEACvjhLEnn
 uqBssySmbNMHimUCqsKWV147ZXe0ivJgUfxXJ2N9oc6zl48/TRhWz4NVEER51fSbCTToY3Mqg
 sBUP8IAjY3yuwMRoE7rjKuMKa4gBYpB7/8fdF8ygfIc7eCnKlMXpbLZqNYlpGx88LU81a5lrr
 cOedgaBLTIFojpWHxaTAmSTRHk9E5FLyitzus2IWdGW78VFyWcKFi8NHIAY9Xz/DbX569I++R
 Uas0eyrIo94hJTfjvnbx50Qcw0ac9t1S8jNp3rbcjhrVqDGq13v3E4qqS9IcZKf8iWassppN+
 GRCVeXVA3Yhcf0SDU1ZJJUYEYgOq1FwIC6HS7cA89apUzq1ZvXLPdElkvNinjyMSnnxaqbTFk
 L65E/zsQmU9qegGvWCYUdrghXP0GT9hkkGGh8/pwsjHotKKngsXO8NFqQ3YMfFq3skaiWg/MD
 qMrICvIAJwpPykZuorWUlSWRH/0S/t8ijaIdQxEa1yroLbulr5RVj742z46Y0Fw2g7RnPz9ze
 +V5fXobwzvWF4NKQ4RkpYiAsznERLfaxB2dObKGA7CuIGNnmCqZ+Ips/wY/S4xTlKomHeyWsd
 twmaXebfko1eLNMdBrGVu1XhHdmQtSjotrJp1Vbo90tjNHZP90tqK9XxqdzPihpGwBF3nE6LB
 87Ca5zIVPpwf1p/dxgRShd9p9xtqdbMNez/A7usLfAt4mgU9wU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 28 Nov 2017, liam Beguin wrote:

> I just realized we could maybe add exec instructions only after pick
> commands if we do add-exec-commands before rearrange-squash.

That won't work, because the squash/fixup commands are pick commands
before rearrange-squash. So you'd add one unwanted exec per
squash/fixup...

Ciao,
Dscho
