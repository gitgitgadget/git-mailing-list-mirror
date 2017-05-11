Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7C52018D
	for <e@80x24.org>; Thu, 11 May 2017 13:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbdEKNKR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:10:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:60073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdEKNKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:10:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTwYX-1dZNHG1nJB-00QmYN; Thu, 11
 May 2017 15:09:55 +0200
Date:   Thu, 11 May 2017 15:09:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
In-Reply-To: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705111509120.146734@virtualbox>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yN6TT0d8HGo5ahAtMx+qzNiwBFkXq4v/jQoXQ4Ol4YtMo6oFU8l
 6MN6YhMEvrgplarGjIbGoxKRfnyjBvXz9mLBnsEjVOAadJBkgspZZDbMxuvEwkRzaaUYkvu
 0D6HlnDTtxeAInWkqbgi2euA+rOB71CSlDHTFm/TCgYgSuUDvy+Us9ieFrNxnvRoqoWnYc7
 dXZCaiPSxZlVazxJYD5ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6R2wB/AgpZg=:txUhodOEPcKCo3gRaQEp81
 6XmqwvIFfQZn1MKMaZZl/tHQA2Dz1kn6vQMBYNleC1Om+MLDMpzyn0zhHNyGMlqsqTxJoh0Om
 wzRXWgaSG36J0GxpnwwbJCkq9s6ylN83pbpAmhOpKbRAl/nqxmY1Beof8BDJGXZ2Ezr9iBLIW
 WrN5Ib6fAFBagQKyrl0diX0ZQ4Vk8b28tdqSfjWpqUADTl7yvkObXXXyuI84BJdlvXFoOzGwd
 fDMWiAfTCVpIrLkBmZLdn8YUJMrHCxmmSZGZNkzWFiT9QA3TnOJjxrcm0B8MblS4KD4NOfHtI
 2L3AflVYJTzUQ0NyCSPpRppJBkvdvuFWRmYRDJPWKx+/mMPVuJoBErInb8Mz+Cl8hfVYcd6wW
 efof5Z1H0CH3r+Gr2+740vj5MXPjipupeFIHJl+rmZ17ZbOU7EU6Vhq7xOCIfbBTwVgFKJxz0
 8VkyvAjFPFUmCD8tOvvd4UdtrHHpY/mh84pb2zGKpDTZDhzOER+cElnJUEccJ9oxyN8/2s9s6
 cWDerENNR6pGiBQ65z4uf+7i80PxQRKicinFkwAdc4cij2bO2m2+nAaze7HFqaepKKth1zBy+
 83ibRei5Ezipy+mWo8dZMxy2WNp7mLK2lO/261tkMqKZEN2n5TyHmHfjhN5wSdqsfwLYyCYj4
 BITfFdf41fIH/Y+8o+xCmJegbPBzPYEkYBJSBic98KH5+1D7iMb5QFVrOBfyajSZjJ9DPFLLn
 oxaZi3nOdx452OFEauts6HGLPoOlT3yISNS7J2FFq4s/JOfaEbolxanyXgmYWbKmm9oEK4gc1
 UK+8s2K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[making sure Lars reads this]

On Wed, 10 May 2017, Junio C Hamano wrote:

> * ls/filter-process-delayed (2017-03-06) 1 commit
>  - convert: add "status=delayed" to filter process protocol
> 
>  What's the status of this one???
>  cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>

Ciao,
Dscho
