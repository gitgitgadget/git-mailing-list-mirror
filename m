Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A661F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdFHK11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:27:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:58877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdFHK10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:27:26 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1dQeOZ1CHc-00Tob0; Thu, 08
 Jun 2017 12:27:11 +0200
Date:   Thu, 8 Jun 2017 12:27:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Avoid problem where git_dir is set after alias
 expansion
In-Reply-To: <20170607183008.GG110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081225450.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <20170607183008.GG110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4RQ52H7RsXqDY/t5hRDgFzrAXOXymBN5z8M3TEb/YZCFAjP7VBm
 GUYcXirDAG4+DKEtYqklXvUm9sEz21VAnuYk6Rj7Fx9O8FDodZk7Ek6xh5o3TVcPVIwm69T
 Jm2fGh/aPnpkxnkFpjFEYT5x2CrM3mVEcy2NleZw80FF+1bxfcrop7IW//ndByid/+hiPZ/
 +g9TCvT5VQhpFTY5gZ5Gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:17TiQrhkRhw=:uBpdHhLaoxiQBZxIaq1+E3
 Gvt//CJYF4zuk6yjFtnWFhIuGTQpaddvWG94lwDKAkGjP3l0FM6+GeKHm/TgyzY+dRQhYUZ0S
 m68omL3jVOX8pXseoJ5i7n2do3dqC56gQPbPOTqGDT9bEGVZE5AnGKhqwZN9rbTi3PC7GrEeM
 ISyehl1elsuEXpPd/aGEJbTlnMnqcj7x+HW2EjoejAAi6dlnnipFGVIsk1f1krPR3ylc2C3NN
 gqJcOitSEKZq9eOwdiCoswU7b1ksOG4Nh6T/PtT8H+xgOJ0KnUJES2j+A74Fxp+AyUL4hk19/
 z9OZKnr1DHzpgR30vPMd8i0+Y+NwzCuvHh9CdvPvZYmHz7RAZLWz36+8mZWkkwW3J+xUtF5K1
 GFcLD+x5UOYGet1j2Q1Y7QkNnFQC67VFjI7PgZskXw6JHdMR2KAoLI2IF+sIgDrrlb+nNoSNW
 0J+UIe1nCUOvkMxJNb7s4cmDDjSD3HPL0YCR3KQrEoX+6pkUoZPWRSPCO9U4qmxEM515WtNMR
 r0pS801XtH2OvHkRv7emf5FI0hoA6q7EpFAgawZNVMjjKEQm39MX2L94h5TYkzxRvV9/VRwy3
 I+4vF4x+k5+Akj70KK3fTLoMCtui/EC2qiVy5DvgKHXeRZa/R8KwLFW/SVjxKyBWGdBd9ruj+
 A9Rrinvygh9SOEzjrtIBUCby+fDdJJ71cZawa0SqkeDdUjmCJph4GU/aPKpJ/MFmvFFJObwxc
 /yJkigbGClAUfHfew7i5J0so54oZMk/XwFv0cdA5iZXSoavgvxz8Zx3MVLQMYEurji+4bb0jo
 6JDS8y8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> Looks good, I don't have any major issues with the series, just some
> comments for clarity mostly.

Thank you for the review!

I will wait a couple of hours to see whether anybody else sees anything
that needs to be changed, before sending out v2.

> And relevant to this series, you may be interested in looking at patch
> 03/31 in my repository object series as that may have an impact on the
> early config stuff.

Thanks for the prod. I will have a specific look at this patch right after
sending this mail.

Ciao,
Dscho
