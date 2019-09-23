Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D8D1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfIWTfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:35:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:55557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfIWTfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569267324;
        bh=1U5VJhCZEOqJmPgD2c1VEpmnUY2O8zqLEuKWhn05kx0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=adRQznZlYog1SdKN8bGybrbWWCy0/9CJ2hDOI202QjWGfRDyB5L3d5I/V4+9Eaq47
         ROPm9qoNM4dkCUCmkXM6KnoENhNJ4hjnXRNRQQPcpBP+A2XuTurSV6Dzzj/HZr3os2
         88XrHfXcxzkzV0QBMFJxZAsdnBsOOZBj9fWGJr3Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1hgh841Z4W-00h3H1; Mon, 23
 Sep 2019 21:35:24 +0200
Date:   Mon, 23 Sep 2019 21:35:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: git-gui contributions, was Re: What's cooking in git.git (Sep 2019,
 #02; Wed, 18)
In-Reply-To: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909232132570.15067@tvgsbejvaqbjf.bet>
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SdwOZiAV3SjEt40vDVJDSK3SbefhsRupWnY9kFKrsM4qVXxc1y4
 m9rcj5wx92h4fadVYZCe1klDukglUR0BiLwV6kjWVnkbZieJS0xXLV5pWNA7gxwfhsgWHsU
 rRkRektSd3Vn1KpuGjIDWoxrTVA6cgALiGEysMU7OiozZnYHqDnmk+Vr7yBGbniYyMpXRVX
 bR/4lTP6Z7l74kJR+T9Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I1E/lgdew48=:RauLkFlfi8bZO4QfK9+bjV
 4q1CJnbD6w3VVmGrk4XTb4T5ntFpAivwWJU8bOIfgQvdgAcxF4BRmKui7VkLx56Y7VvyzqZmk
 RH7dG20riyP1ZvryoaIp0DQmBGcWfDXqxVtqd0ZtZkwJgRdswWoEVlFIJaYu3prS4bp6knsKL
 7BstQ3yU7QcQM6xbW37iUl+BkIUuGkyH50knSZWK6BjR9uaceNUqINOJoeYIwHRimLcHTADKw
 1X+J9MtXVjI4lSZw7o0qD8O1GNwp4E3FveSdZdtIzNB/ObI5dR3/lF1hGmAUjKzs7YEyIXBz1
 hb88/Ot56GBVX5gE44CpHU4BJq+Y9KjrbM8r42yZpRZV7gSmCdPRAd4ccP1hUBTKDpkrmW68b
 FVBLl+O9+hqmMnDm2NESmAcyIzeT/cjypIJzEmKUPJ9Sfa75fzGaALPAPqMuNhAKlteYnstP8
 xDGJYQ5JSSWfFhDx4o3Jhqr5/8il0eSOYXTmzL0BMHvhXyXSzR5Q/0+mlxkti0cKmrYqMrtnl
 SxJmVTQg6Y2m/QrNqxB4wiIh70Otf7abVZs9ZNsMmIcW5Tn7EX5ZeUdXMF3PHId3QjDgbknX5
 vJgi24rY1aA7lnmQ6vc3JxazhjaV9lSFq5+FHAH1EmXmFXd90TXy9ZFHVN14eWkVFFavsi6Po
 V3egWmhiiBl46sfDmWtq9FExR5Aehox0FXqDCqboJZhNyNVurP2N5V9qVqR4ZOGocJIKKDM7x
 YFVxdwtAUaWNm16L0Az+G0/ex1YR3ZtA51MqEqal+b55mwvkHSdJC5xJsrlYhnNcb2WQDcTyd
 Lfcl/75t3Jj5awRcRAHu8dRNhf9sDNJBuid7uAc/qBtUQz2oYUR/V0JDFxTbuF0QP4G4HAjzS
 +17zYN5o4nFa4B6vvqs8FhMaWeic4Al9A3FRnpJYfGpecM7XTYAHhUeA3BzbntLcXdOk/TKD5
 O9WSOvFfseRTEnd7Z+IfQa2L1GUb5X9HSgfAdhdjG7CMv81pprQhI0zOy++nNz0uGzbu43TCa
 sE3YYJ9y8LJZLAmh8IbVNI+aRibnKquhdf8XRAPNJtF8Yl0d9D4wjmV42eaqGuFDs97UQrPew
 1x65/uc+ek4zcvLvA6GtGRgzhvIi9TZcDUd0V7zcukOvDyc/efz3vg3yrFMY/EBwNmOqxhKAv
 agvMHW+1m9gw96aSH+6aGrFBMiX1avyDjh0rHBV/ToZBCgnB4p4zj4FTiwQab6x9f4HSHMZV/
 dYPvw/x91+PqAKTitlDPIR5CSr5GhukLasN3x2j1zjfukb9IRpXW9HoKDYAw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 18 Sep 2019, Junio C Hamano wrote:

> We have a new maintainer for git-gui now.  Thanks Pratyush for
> volunteering.

Excellent!

I opened PRs at https://github.com/prati0100/git-gui/pulls. Pratyush, do
you accept contributions in this form, or should I do anything
differently?

Ciao,
Johannes
