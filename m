Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B072095E
	for <e@80x24.org>; Fri, 24 Mar 2017 11:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935923AbdCXL6E (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 07:58:04 -0400
Received: from mout.web.de ([212.227.17.11]:51555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935778AbdCXL6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 07:58:02 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mPA-1bvJZv3yCK-00wYiA; Fri, 24
 Mar 2017 12:57:40 +0100
Subject: Re: [GSoC][PATCH v4] t2027: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>, christian.couder@gmail.com
References: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
 <20170324082736.10301-1-pc44800@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jdl@jdl.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <908bb2a8-033e-6cf6-e996-9f779d128fd5@web.de>
Date:   Fri, 24 Mar 2017 12:58:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170324082736.10301-1-pc44800@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LZNIAR+f0C7qbX4+TpjyMIE8C11bsb6II8jhl2VEOQt2ct+8nKW
 TYVn5xZ68H5vVhKUZ7AAixNQuA90lVQ7I2pzZvr4MWFM+QcGqh8UvGo4HHIJikuCiT5ixNP
 cLpSDqRKANR2tuD5eyOFPqIktKAS3tyMuClduDXg85etVZ+Z4ljgjuYCcg+6mZDkAwFMN2q
 BY0VgV3fF5Vd3XaoQijqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gtI0AOQzE7o=:yobrDTLGL8vFi1E7TXNMsj
 d4vaMSYtYjHS76x/oVdr5fs7lStn2v3nJbBlRNoOsHuBuVUwiFHMY8eDGVdqLXrfljTy2SHe8
 1p3bkgECTvYKhOAX08vV/dDMeuYzl3dB9hG8Dknz9arOIjVq6ydu+nZ12pTAlz+9tfjfhRVW0
 Sx1JrApkbwrr2CPpDqfuv6UTuY5RR4KIC9TKe57E9eTPmoWsQBtKvVWrsdcqOKoBSy9sO9/Wq
 KtBD9BcrSwQ8Imix+tE39IaJw1+Tc9rxrLewvje80YdoQkVS4RAXvrN3mlSNEu4YqR6h74iih
 8R55Q53UdVN+rL0tTXopBdS6wc2c7YqUTroj62H+JdVNjOa6pd75nH85wlKckkmdHv7034F32
 ewnCFkGTni9VgfIlvmYM+ID1WCPt86UMsiFg+rv1SIsNuyTJprcuuxVfYAVO9io+03uxqOFMI
 rsw+4AuslFIlwJlbNlmvi2CcwY/kdiK5CouRkHVPRJhJnH3+P4XTgglZeMH/Sif9uBbIQyVRF
 t9K1HOMiziKhcHDxS3bin0Vds8rD1O72SGPTEgiTZLrPnROdCiDjtL412ntbblshTkLIQNGZH
 pqjgdAkDv5rzJyErHoYGQi7Brn81AqZDtAH5gSdHrvBGAEtiotK6zNwzef22jT8VTIK3CPDmK
 cUS13wokm0FoXuZiVgWcgdh70vwNrTIomoebLWohE6J67eg34Qucqz+RYERXXw6rsEp+2Baes
 sJHgB2aeVMoSNppP0cm/5SZP/q2RH4hXxx8JntP1SIaNgbve/m5eHPfcxMM8CuIvNcpRSVLuZ
 sV1qvUV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 24/03/17 09:27, Prathamesh Chavan wrote:
> From: Prathamesh <pc44800@gmail.com>
Welcome to Git.
The name in the "From:" must match the name in the sign-off:
git config --global user.name "Prathamesh Chavan"

> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>

The patch looks good otherwise.
