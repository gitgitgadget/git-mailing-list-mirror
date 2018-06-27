Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62E31F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965312AbeF0Rik (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:38:40 -0400
Received: from mout.web.de ([212.227.17.12]:36021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbeF0Rij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:38:39 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUFGo-1fgRcv3YSg-00QzdW; Wed, 27
 Jun 2018 19:38:35 +0200
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
To:     Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <b0039999-fe6f-eee3-5cc6-4ca638dddf79@web.de>
Date:   Wed, 27 Jun 2018 19:38:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PTaXuejWNLaI+4sUyw994LyOpqmb5e90B8wfzYTP56Eb/d6ViPv
 fwkEQUgBRC1YmdUgnEfQ10BG4UqHmRwcrg3aDlWvdFGO8637AQ3y9iIWaUpAAXVpQ+xEaEg
 stKwKGcylQoatjz1rgunWvFJ1Tj6zyzh7ABTv70f14mmM7NJ3NwW1ZBdagVSa+0WEYMuUP/
 eUPmaOPE8OrTO9KOaV5kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UlpmKAg+VC8=:blXmyUUatyWIo+S38jjjPq
 8LhS1iJQoQtBXX62UuSJD8d9mzNWCnBxlEdetkFDgUfccf/4mddV4zh4CNqn8KifnSfw85jnk
 sztBeASvaTdupAQhL+vsqcRHA2e6PUwUBCcLd28QnjMFtAa/i5tk/w7X+XmIfCDFKPUG4Mxt4
 MEpxiOelCJgeKHZgzGcNi9kKa++sf3uJPNqmkOBCPruRlJiBYjXDFvt/t+lboojbNoHov5P9g
 xzrWdg9R4mHPpKOOOV/CbNnqNFR19u1pcaLhwuokUrg+D2l9QaikzutdJQ6pMMaGXHyuvbskF
 xoa/Zj87Wy7UcOTQnObzGLt63o6O2QFQHHzaYuJNxQSoN95Ep7mqgfxueZSqNVCtd0YRUTWpj
 8u3++wYuBo5cggH2oZWQVtB2zWGDlQ+JL/M/Lug3Ucx/Wo61+spD0MQb7aks1u2cnZI0UfWV/
 XadcL1atMjAMnt9DOlVxP5o9lsIcwhkYM1Z945tnIHb7WY4uyIY6CuvweQwp6Me93SqPDw8dP
 PLtiOwkb/nHDzoAEMINyDwrUvIQO0uIvG1p8L5+B8SRVD7cn93ULxtJlFBmmlCXQL6gYJ7504
 GsdmGV7CJfQ1LCzimRaoSDX6fRMRhnGyDquQku3JHIhghhDCp6O4mnAzxu/gT3TMVmZ7cKnfp
 hYwCV20aCbpmjF84musWGmHobYo+RQ/IKhdJYI2x401s0A0EEbJP2mjmYw672adUgCcew76wV
 1frAVil2PLQU14BIEeorvxvJENOWVQPbHPWH3scb9f0UOcnS7KnZSdfo3cAyati92LGEvCm1+
 O0ExvBG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.06.18 09:54, Steve Groeger wrote:
> Hi, 
> 
> Sorry for incomplete post earlier. Here is the full post:
> 
> 
> In the latest version of git a new attribute has been added, working-tree-encoding. The release notes states: 
> 
> 'The new "working-tree-encoding" attribute can ask Git to convert the
>    contents to the specified encoding when checking out to the working
>    tree (and the other way around when checking in).'
>  We have been using this attribute on our z/OS systems using a version of git from Rocket software to convert files to EBCDIC for quite a while now. On other platforms (Linux, AIX etc) git ignored this attribute and therefore left the files in ASCII.
> 
> We have common code that is supposed to be usable across different platforms and hence different file encodings. With the full support of the working-tree-encoding in the latest version of git on all platforms, how do we have files converted to different encodings on different platforms?
> I could not find anything that would allow us to say 'if platform = z/OS then encoding=EBCDIC else encoding=ASCII'.   Is there a way this can be done?
>  
>  
>   
>  
> Thanks
>  Steve Groeger
[]

Did you consider to put a gitattributes file on machine level ?

https://git-scm.com/docs/gitattributes

[snipped the other places where to put gitattributes]
...
Attributes for all users on a system should be placed in the $(prefix)/etc/gitattributes file.
















>  Java Runtimes Development
>  IBM Hursley
>  IBM United Kingdom Ltd
>  Tel: (44) 1962 816911 Mobex: 279990 Mobile: 07718 517 129
>  Fax (44) 1962 816800
>  Lotus Notes: Steve Groeger/UK/IBM
>  Internet: groeges@uk.ibm.com  
>    
>  
> Unless stated otherwise above:
>  IBM United Kingdom Limited - Registered in England and Wales with number 741598.
>  Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU      
> Unless stated otherwise above:
> IBM United Kingdom Limited - Registered in England and Wales with number 741598. 
> Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU
> 

