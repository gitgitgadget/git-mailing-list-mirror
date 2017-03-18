Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9952095D
	for <e@80x24.org>; Sat, 18 Mar 2017 03:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdCRDaF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 23:30:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33403 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCRDaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 23:30:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id r45so11637917qte.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DWbuEJjbW1riO1pL/c8aiS26qz1TCk/v06GsXfnC5Do=;
        b=Fmvy4eG2+HWDyjqbVKZ/sJ8RVJ5YA8IGJ/6tNRb7RtkhtTn8CxuSChiUABp/gdYuwb
         ChYSrFCgxOXv/PtqqmXSF15Lozh4UVoHLl8o+G+v3zPW9Xr9svsR+/ydq8LNXRLLUKpu
         bGA8gVMPViWN6RByg8k2Pbq+DPsUpEXgU/xgFAwbP5wBYJG4F14crfuNaeKqUPFbrgwV
         1ap3ia4Rzh0gbSPGrA82qJ+haAc+y2QRVRM+vPP0x/e0sgEQ1NBHzF/hGGXnJwoLYLgW
         FnvxUQIyy+SgrPIv0BItzUdVRycvGbwvo7r56A0ebW8ZUn3XoQzKo0qGWS8dfHbyrumm
         RsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DWbuEJjbW1riO1pL/c8aiS26qz1TCk/v06GsXfnC5Do=;
        b=RcXlXeqza48kTmtFrfr4ZG/X7agXBxw9HQnl8+qH+MT9DUkD4A3eXtKeqnY96JKedd
         IzJvKpiOwllyNuKOwztc7k58lIVD+zx+2V3fWe4X4yFnqQk3P1ic+CgcFCMlHGKpMT0P
         RiQmrr8/Ut6plov1ReXZvr6niknIWIFqxRJiGkFQbi15aGsbztbXzSeYiz+0pj0He0PS
         b9TnwCNvAvAz7ViKCv3lmqJz3rIqHNpgxb/a9XHCxM++pe98QlegTXIP0968m6emDvUy
         HtwwvTgAVZqnSql9KjJk234g1y/+AKFHrV3Kcer4w739LZFjeTr2Z4oMXxqwUZorjOZF
         efMQ==
X-Gm-Message-State: AFeK/H3LD2JcsT7Cd1u966zJP1x2MacgO0U7Eu4jMBDWJc6cDYOABOVXScO0QcWXxajAY0OVoH+xUPtAKBwbUA==
X-Received: by 10.237.48.37 with SMTP id 34mr975976qte.117.1489807261996; Fri,
 17 Mar 2017 20:21:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.147.40 with HTTP; Fri, 17 Mar 2017 20:21:01 -0700 (PDT)
In-Reply-To: <1489774488-4365-1-git-send-email-yanke131415@gmail.com>
References: <1489774488-4365-1-git-send-email-yanke131415@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 18 Mar 2017 11:21:01 +0800
Message-ID: <CANYiYbFk=3KE1nu7EqpzbD7aeRpkA4xoeJ0MLX0_SZcTHFi51g@mail.gmail.com>
Subject: Re: [PATCH] gitk: Add Chinese(zh_CN) translation
To:     yanke131415@gmail.com
Cc:     paulus@ozlabs.org, Git List <git@vger.kernel.org>,
        YanKe <imyanke@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yanke,

You should send this patch to the gitk maintainer, not here.

Gitk has a separate repository, which has its own workflow according to
"Documentation/SubmittingPatches":

        Some parts of the system have dedicated maintainers with their own
        repositories.

        ...

         - gitk-git/ comes from Paul Mackerras's gitk project:

                git://ozlabs.org/~paulus/gitk


=E5=9C=A8 2017=E5=B9=B43=E6=9C=8818=E6=97=A5 =E4=B8=8A=E5=8D=882:14=EF=BC=
=8C <yanke131415@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> From: YanKe <imyanke@163.com>
>
> Signed-off-by: YanKe <imyanke@163.com>
> ---
>  po/zh_CN.po | 1367 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 1367 insertions(+)
>  create mode 100644 po/zh_CN.po
>
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> new file mode 100644
> index 0000000..17b7f89
> --- /dev/null
> +++ b/po/zh_CN.po



--=20
Jiang Xin
