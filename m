Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62651F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbcHRQ0q (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 12:26:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:56648 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbcHRQ0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 12:26:22 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M7Hao-1bDdW72kXm-00x0K0; Thu, 18 Aug 2016 17:15:09
 +0200
Date:	Thu, 18 Aug 2016 17:15:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Olaf Hering <olaf@aepfle.de>
cc:	git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
In-Reply-To: <20160818144421.GA9062@aepfle.de>
Message-ID: <alpine.DEB.2.20.1608181713440.4924@virtualbox>
References: <20160818144421.GA9062@aepfle.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W/SGyO+kMXfu0h7IerHPJ52k+uSQRRb6uuWh/v2+WZt6Ex4znlF
 X0g3EGzO2LOPnTsKhONyewzpdar08HrSLNl4U/T0tE3d4VVRK9AcEEipTQjmzh0NDiBLc/q
 8RTmy8pb8qP9ozwzmYmPL42LJiUWib0y6erzWqyj+1pn6hsk/z4FMQZGKYno7ztu7sRFsgv
 4cHhdvYYCteJUMbIaNFgQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:towSddcp9uM=:zUkEGe7PuPZvEqND5q11SX
 WF5n9xmG6b8GlywQsFfJ8VgU1Zv9xDdV8f4xXeP20glNAC0ng0Q3VDs2PzMQ9j4bc9M5/MICg
 TTtHKww7vpDDYOmkQtDfw+wpFavVxe2d7FUlmuEn+zd9Yeexq8s3HtJw55mzQVo5q+aeCCz4v
 rsG76rVrWBeUa5ZRuPL55rJ4yVD0N2K2/4nJ9WObQpRJysdVNkPGoLDpe9lG3QSL3++TPiCMt
 yHP7c717rVGYQFkJpTsi4vNVeTqwSQdd5mVsW1yaC73oidFRx8d10tcYCXfAcu76DbMW13O2G
 6YxPrU2+cQCvmhROkJkAcuW2MBBuasozqOaeT0fPBr7Zbqp/X3sZJtJpPoV1qOygPdSuM88/r
 scTx1ZNXx4cWbV4CKzzDSqv9+WgDFbEkcQ24MycV1bty7qrmxaTRBI3xHnBzybJF1XTxs2F9i
 z/G93hGGHtjNaow7nCkA61k9rZjMXMDMkixkcgrKRrmpSeHNvRycdHDKKx2iBmXK+NvwyNqBX
 Hptm5CJL7U5GjT0e2v+ngBZJ7o6s0rpJg9X3HZcrM3YAsWN+Y3owAw4+d/AzTsXtijSAKwcD2
 uiHT+oGNFywJcdIPUsI4TrTFR00deavVC0pK3hIsCOfbeyhDYldLELfuW6BxkE/4NPKyDG3L3
 AsMTMqWtu/Fgnfdgsghk72jyfOjve+TbvIl+kO/VIB1zjBkgrhCTSGoITM1atvpqHX/WuITmQ
 qncnFtnSYDJYKQjUbBxSqnqtILnA2s0AeT/pbmUY5H1djBCXd9rauCRG9USN8ILGBj7CBxDuD
 ACmH0yU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Olaf,

On Thu, 18 Aug 2016, Olaf Hering wrote:

> This command used to create a diff which can be consumed by patch. But
> at least with 2.9.3 it just gives a rename output:
> 
>  git format-patch \
>         --no-signature \
>         --stdout \
>         --break-rewrites \
>         --keep-subject \
>  95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d
> 
> 
> What must be done now to get a usable patch?

Maybe --no-renames? BTW this behavior was not introduced in 2.9.3, but in
2.9.0:

https://github.com/git/git/blob/v2.9.0/Documentation/RelNotes/2.9.0.txt#L7-L9

Ciao,
Johannes
