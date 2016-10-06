Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6CF1F4F8
	for <e@80x24.org>; Thu,  6 Oct 2016 05:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbcJFFOK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 01:14:10 -0400
Received: from mout.web.de ([212.227.17.12]:63788 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbcJFFOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 01:14:09 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LeLKb-1b6JBo3PYr-00qEf2; Thu, 06 Oct 2016 07:13:57
 +0200
Subject: Re: [PATCH] run-command: fix build on cygwin (stdin is a macro)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <f9b6abf6-8305-4a32-29af-765f08fee94b@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7de3821f-5111-47ac-b7e5-20fe1216ba58@web.de>
Date:   Thu, 6 Oct 2016 07:13:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f9b6abf6-8305-4a32-29af-765f08fee94b@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2ZCGwFlftxyJPV5y0agTeP+I0fzAdXGAv0iixLMWO/hJ7tY91Rh
 Bz42pE+18yUcgrP/gsxQuzvKEVOW2Tq/BLdRBGJJnGd1E98lqjMwcBrR4e8SN2Ag9qLvQZR
 7uenbAwZPl4GYr8W4LD/nHPmOeFKS1V5EQSNAKwbXDYBuWsdZgIRcC3F8J9M2rCr+tgtgTT
 eRICEsjIjRBYV6oGOEgSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UZ9L1N5XVis=:oHJonZJtNKZLBgzAJd5+cF
 xrvD/sPnqJhqzN+bfAqOqhAtbuBn1iy29eeMMZCN/KXsK842tvmI47aRdaBV2LkEEROTcjG4g
 U6i3TskCRDonDMLr+jj46Z8d7JnkXVdmtm6s5tC+UlJwslbGigASyyv+dxeSq1SyZQgR3CkHw
 ME5LSGU5FrMWxaWocGHH6eqIiq+Al9lENaP85NEQrHXk8+MU5Z6KblYs5mix514sHgWAVUMdv
 +gALISgo4XIcAEJIc5fiaNm0bSbmf/qnfjxvZOXFxKGiGyEf+JZ1yQ+hD3nEpLTWQTXW/sGq2
 GViU3af9xfjYmlvG8XaRwH0bARtkS1O1R7w49gIHbbhLzkADsaNq1DWT0FzcAye5ew5sqToGr
 dmLHE1urP5hYGyxVF4AeGoSVZeRiWDb/o2vV/Q4+qpGgtyo7IOvgFCOMB5kou5pmEAbMPJnH0
 iCjE8AMx5jorCXJpAJjUuQGRCFfrA0dfTLZK5f6mP6+aAbaz4nAW/r1gIuoaVAJNY5P8aeAta
 2K4pK8DuDH80+u5WXDkaWuWgRbJXcVoQNvGb34qHHm+IdgSb2gd6ozHouoOpP2TnKM7YVJBxG
 OufLFJusZJ5y77vpbbxF/e5+HsCOd2/7m0reLk94rjl0j0okbWiVfoVUf6Jcl+PmBss0H4LUu
 sJJYcxGW15r/g3eegsmHFqSKv3e3EN4jFL7/pBO1rSHgGVZFZ+rl72/WlfN1RxrFR4KDMZgkN
 RQuFz30237c6VU42ZRQFDm2Vva3jAEdzpfpZE7qGkAPaSpRF9l8X00LVjIQkkJEl80hwmp7Xe
 Dhak1JY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >I am not suggesting that you apply this exact patch (stdin_ is not a good
choice

How about fd_stdin ?
