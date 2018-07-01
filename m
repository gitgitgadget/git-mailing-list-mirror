Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391471F516
	for <e@80x24.org>; Sun,  1 Jul 2018 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964780AbeGAQVr (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 12:21:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:60765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933311AbeGAQVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 12:21:42 -0400
Received: from [192.168.178.24] ([77.188.73.37]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2LZc-1gRLcX0pnQ-00s6oD for
 <git@vger.kernel.org>; Sun, 01 Jul 2018 18:21:41 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: Feature request : "git fsck" should show the percentage of
 completeness in step "Checking connectivity:"
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3d6b38a8-7dbe-0633-5c54-603161ee3fd4@gmx.de>
Date:   Sun, 1 Jul 2018 18:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jdGlFw/G8BZLc/kgapN+3i5y4TbTwGwCV7fBkxUUUR1wUfDFKM9
 R9mVbBlhLAOvHmiIUsv6syoumL3s2xL1J+/XBsBpoOJ52/hoPN8KbA0DyfYpf+tOOhsEBP9
 3x8PAqo2nMVtc/dOa4QWdcZrSR4lqEE3/PmMBtp11XGFJ39bMBqryY0MXuQft80i3mB8YgF
 zhZVmQ76gsdlSMFJtGpZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ktrpnRihTsE=:rTvtKX0pjUxOQyaRQiNHwl
 qstAkHyjwV8K/HAzzn5WyuTyajVIBFkaBFZ9ooYFbYS5X2VdK+k+Ri+DMrx8Clu2oJreUoIqR
 0SfA+1niQE+oHg/0TfJg5pgaw887iPur7RmRkLcDaAccWcKoX4GVTbt/TsYflw2H4QFO1YKuP
 NiEzcSEbCdiVzfG/trK6fP03YJu2lg6zAihc7GEAeFEY68KOUvKC9RZqxxc+Mc8PPuJR7FhsT
 1Mh3Ij176FjiN0K9clm7MYX29MPwxBv4dcPcupCGK0Z300ZZK3M53lcPnTwzfbay00ngLDbGw
 R3Atm6aY5LCDaIP7ea3+BPW2+Lim9P8+MS0ELHaqJEvluwOavofk13CODSP0c/SNQ4oxXKn/e
 3WnlVfMdrzGoQkyUvkd+g4QSPYaHKNGa/6r4xZQ32Pjsqg57gx4YcvK1y8/baj8oqX3GfGX6V
 HVq1tQay0fDTbb/RAfdsmijbOrb+KS5txDt7xfSQV2Nm4npyEQ2vVyXwjD1US+32fMeCu37A5
 uDcT62C7kjkxoDL4p7KTZ6W91Qzo1Bdxsg6IsU8VyBN1xAmfNCvvs23yMdpENhQAaUwIvcTj8
 lL3pevj+skcoRze6Mo9K+eyCOSaOIrxn77L8cujwdi6PdfZZYHiVgTuqRFHizD47O/yN+8pLG
 0yfWSsdKA5c58Tyl84WTkNqpeHUDsQHbhWPXQJCmVdj7YOb4EOdtadVEdwFYQkSKXaGqgKvyC
 LFm/iXXnPcWCP6LKdTISoTYvJLsUPk02gbvdIejnqtLaF8FVAhmP93qb6dXKdyjEHrwB8s6ob
 NYy+JYz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

as "git fsck" does it already for "Checking objects:"

Is this a valid feature request?

-- 
Toralf
PGP C4EACDDE 0076E94E
