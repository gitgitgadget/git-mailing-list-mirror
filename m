Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2120207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 04:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034946AbdDZELQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 00:11:16 -0400
Received: from mout.web.de ([212.227.15.14]:54474 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034583AbdDZELO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 00:11:14 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfidG-1dsWY927FC-00pOVZ; Wed, 26
 Apr 2017 06:11:11 +0200
Subject: Re: t0025 flaky on OSX
To:     Lars Schneider <larsxschneider@gmail.com>
References: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com>
 <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de>
 <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
 <7D9AE52B-6A2D-408B-855E-3988514AAC45@gmail.com>
Cc:     eyvind.bernhardsen@gmail.com,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <72445da2-04eb-5d51-42f6-7e7fce4d4843@web.de>
Date:   Wed, 26 Apr 2017 06:12:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7D9AE52B-6A2D-408B-855E-3988514AAC45@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QbGlw0Ofku6+Eswo+06hic10Iop1SG1634H2ugpr3+2RIz75O9n
 DeaujTSJ2wDP033qJzYQcUh+H8qV5kBskuyDxTpWR26vl+oMatt/Q6ngElLVGUeLp2XLyiv
 mVGGZsHv8NS9no3p1jwNvKHiykqEsNANJ2ptQwIng4yiVQHMvwERDP50ymAwK9rB2JA/lHa
 ZEL6bY9vFbOIGpA/w+uTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UFGDnKU2fpw=:xIiO0aYilLkJJH/NkWzY/F
 ujtQbhwsdv0Lz1VQ2biAo/9tTcv8/Nu52TwtCMR7tbnYuDoClTJZ0y38tsjQwDT7fDInJS/zy
 Q+uWwdJiGDv+kfzkgyV25DoIztSmZK6kUraJ81ko2l9eGWv2BSbGEZbxFq6T5Uxv1ItRyx1A9
 kse+AfW+qmziM//8J2fhMEn16N6gtSAAjLHsAJyHGcv8H4KTC+4V/5Up8rfdw8Z/H75Hl1Ybm
 170K8DhzDKI6URVDjQv1NkJP8zM8HbE1jGz+CqcDyR19RxBpUxXdegnfUAkJtnsLvYpuA8wpq
 1BhPFQVTGv3/FwT7FYdb08wosi0Ndf6PaATu9s9dMDWldkLkwZb4aLXRI0qy4zVegjlyVzuMA
 qfYx5sKhXUDnnckuFEySJ0Wm2JqeaDX+aOyLPwtPsLYFVNQnp0wciphB5dBLRGy9YXM2QzXk8
 cPJ0TnDwmCBm0P0yfted8Mdo8r1dADYaO0kj7QXox/Z2ZSx9WfDpcPIV2LM+JtcjNG10h2ai6
 9mv7SEz4J2L4kz3wwdgAd1/0XZ/mQd92h+GDTdM8SB+wkFDdfGInZBte/mW6nijLM7Zuy+J6Y
 XyMynNkCB7fZmZlUVT5BQ8a+sBx9hDBhvHJG1HEOSH58hxvCicqV+PSQaQbHnWjxXRwTh2PfM
 j/W+s57E7seyD64pHH3VPCS/KFxsUJTY3qbImUByAibfEzwUiyaXapQm1ZQmQHDUVEf/vnK4A
 evTbs8UjS+BAEGnqa8v/Qgr9Km9U+RlXeG/0IN0pmAKNH4IKwvYzvp5Wn24IHzYzpGdHpfmyF
 A2/4Jdi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>>
>> So all in all it seams as if there is a very old race condition here,
>> which we "never" have seen yet.
>> Moving the file to a different inode number fixes the test case,
>> Git doesn't treat it as unchanged any more.
>
> Thanks a lot for investigating this! Would you mind posting the
> fix as patch?

That's ongoing.
TC #3 and #4 are fixable, but #5 resists to be cured so far.
I think we need a touch and sleep or so, more the next days (or weeks)
