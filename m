Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7FF20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdFNSim (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:38:42 -0400
Received: from mout.web.de ([217.72.192.78]:63010 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbdFNSil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:38:41 -0400
Received: from birne12.local ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZPc-1dkTH50GEu-00yf8H; Wed, 14
 Jun 2017 20:38:35 +0200
Subject: Re: What's cooking in git.git (Jun 2017, #04; Tue, 13)
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <3304FB6C-D9A3-42FD-A047-EF97F50BE258@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <62a0b06d-fbe4-4f00-14d6-83c97ed220e1@web.de>
Date:   Wed, 14 Jun 2017 20:38:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <3304FB6C-D9A3-42FD-A047-EF97F50BE258@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mcFrGXzXIYHZHactVfALk82KK7W6ljOh5eR7aXn/+Wf5csaRfEv
 Dn83Ck5dFyfvNAgKHUyUjsIor8R+KClcJLxFkxyymJmMEjfMpQadhuhQrPxnNMOfcJCZRPk
 hC5DUTVDV9VRmmfqdqWPUqZ+Y6rVE6fjrixQ65aVL0nljKpOMnvT7Nx4qccUxTsrnXuVVbL
 yRDlp7uDRO/XtROCFUpjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vds/T2S+FOY=:pmpAcugR5nLzKhqLb0xgQP
 M+V1A+EtHlsQAMngyE7U105Tgh0DIUPVBuVHiFrQCGjPLqY7x9FMlaviHov8sIQS+Nj9vhFN1
 VR9l/kwqYv17/DEhduu0mkAzD2Eq0qs7OL8SRp+pMV/wT2k83q2UsJiBleNPTGds2R4d3GEfr
 Zvqga/Qut35WChhbWucq0zT9cDVd0xVHHH0B8eX+CUmtUTpRnPfLDB9kezQ419n1p1V5i7mRp
 cQrsb6MWPkljWoX+3MU/tpd+mTHWPBPG9oTFplRuF9+f2IRLaKchfFhpt72yGelNspixO9AHp
 PZtWyD+T92Q82lPly/nSTybxmxckZAl/N0/m38UetGyF5gAHVD60aBMFsoTelsvNUyjmg+xaA
 gkVnjsjnkjJVcRNR7+2ObI3EMh7pYY03Ll1NI551aWyJ/AhpqeBkRJX+SVR6TP5T7Gx1gmNnQ
 koGYRkYfDhrBS+GW3mCmlpwMtbaV7uO6Rx2nAalnp4SOCzncD9YXxFOQcLmd66H81hs1mj+jL
 cCacSekpFiB4Ovp1PDjRk5QQbUeAlgoXZlg62Qu19mhrrVmtbYRD0Bo071hcazamXioz20ylT
 /G4EgdURQUVra9A89ha124qWIoTUG4wgfCejLpUwaLvvd+K+cMXpW1z6664oYusXyXOlcfr5u
 9ZKCnjib8jqGQ7dhKG875RvySkx1n7IHay7d6VgufbBgvOp8o18TxFyoeZkmZPGXkPSpspQOj
 QiMVIohRBSBw5q3JsHeWljmU+4OHQXemvbutVDpduuO3LjprsKFa6o9GINcb4XgfRRTGJQBZ4
 2Or4e82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.06.17 09:42, Lars Schneider wrote:

> 
>> * ls/filter-process-delayed (2017-06-01) 5 commits
>> - convert: add "status=delayed" to filter process protocol
>> - convert: move multiple file filter error handling to separate function
>> - t0021: write "OUT" only on success
>> - t0021: make debug log file name configurable
>> - t0021: keep filter log files on comparison
>>
>> The filter-process interface learned to allow a process with long
>> latency give a "delayed" response.
>>
>> Needs review.
> 
> I wonder if anyone has a few free cycles to review this:
> http://public-inbox.org/git/20170601082203.50397-1-larsxschneider@gmail.com/

It's on my todo-list, may be this weekend or so
