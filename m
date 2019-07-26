Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97031F462
	for <e@80x24.org>; Fri, 26 Jul 2019 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfGZOdH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 10:33:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:52967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfGZOdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 10:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564151582;
        bh=eg+tcchskz3TQhqzlEeVMxXDhZnVuQWGQboaymN0WvY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fYoQgE75zfgxq5VMt8M0vv1gTOgc+SSNsgXthyBlrQEHH+GmOj+MH2lFz9Pwz1vKI
         TPRK/6MD5EUdF0kvVTmO1vpRi6xileltcLDBvsIZZgTA08uWEugFHtqWQSdkgcp9JU
         czoEF8NobXkoBg32ob0+pjaYS0BPX4+OGrsv89+w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ygY-1hnBFo1Re2-0065gU; Fri, 26
 Jul 2019 16:33:02 +0200
Date:   Fri, 26 Jul 2019 16:33:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
In-Reply-To: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907261624130.21907@tvgsbejvaqbjf.bet>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hqi8vFDuJUn/vEiy5i7aLyGhSlXNfadActTT9VrSfxOfwSusoo1
 tmByaRxdT0CJWia4X5vsqcHETZWhU7cUbL69wK7VEF3twabzfZmtDViaPwsVjBD5e/8ynFh
 cEzVsymvmTKeR0rso+i9ofTYnlRkzb6e9kaQ54L/ytkCEgEqgrNkwjIyPDc+B0dZ1PBkUgo
 LqQMgYzZ7loKVvKKJdIjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HstfEgjtaL0=:fisHQw2Vk3hrl9SAFQeN6i
 s4vtSnZ59pDCfGax9P8uIve0OI2awSqwRYCdAv4uILKD/VbWtVhV0EOiTzRy3yt40tDrfhOzz
 u9vWoqXPIPd+Q1K+xgls9jZT/z/82W2GpGT2hA8nNv9nmtoajTFp2RBM4aNNcVMcfqUyVWOQl
 qurCXxjyTyQ0NseGkH31Oe0OsrfSxTP0Pp03XSUp1FWVmvhNo8RNmkqUTZTv0dM4m01VtOCJR
 0OP2mdRcJkA7Z4PGV7dpC7N46JG45sgTULQNh1G4v/Xs5zPs4rkgAKi7k1ytPA0kupGhLOWlR
 k87MiAKzZtMFkj5etkB+hBl6VoGCYm0etjH9VCy71pVZ+38dgN1w3yjYj84ogn+ZLjH0yxSvD
 N22qViJYfRUa++zCb2Yfr++6tdVuHeg45nOkUNGELIwpGG7zOP2ARILaVgwwN0VsIWwbdIv5o
 U3sCfPUTabpNfJ0rvDriC+o5WFPVDzDlI7Ymunokmf7B8at9MLg7VQLKKmC8aX+lWy9bW4THy
 72jRkY8MbuC8s2qk8FtzZ9z8sq6Gfb/c0nBVYcRtr6JLc+X+NTrLXN2yiSZZfu62O8qLOZqoF
 Mal209rvFSKa3JtIxW2HBDGukleqFXsuVKSvYfnUuSFHeS4ZnTruN0B2KW7vBHQnVBYt2UuPl
 n/JJota6Z5gp15iuuJzHYKeNIrW0F2xLwe/L2pn1ngArWd+vDQNG9N0hV17zgc1OA9kd1bFdP
 +2TQ9HyY+rewMil3zzwS7MyPg/dLyUf/NmTsKZLw2zv2Om25yP8ZlSK8zh6QtuT+pzXWZlt6E
 MHKm8eY1h9r9IktlIVo2QqsYmnSeXZkNl3M/lbTJ9mgSS3C6UabbwEbIsRFWxbQO/vE4bNN67
 W2naQnAGxM+D9o2WcErtuotVcQQMfRRWh2jcSofJy9lYIU+OTr1KGeKhWdfVQMzTKuliHYry/
 6T6UYlOw4VZvQonSOVqDl9RhqdD/RrjmRlnyuB9DbhioXJYRojMNfdgkKJNV/veLR0iUSFAdi
 dF+6a++VzjNp+rgNOeTAonUIa/+dn+E+Sw/rVGaSJIoqFLQ35W3uyLwqHrNUxc+Vh0J+DfWvM
 GSWHm92HyL0ZSZRZPpNrFXQQlcocL7rdjTz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jul 2019, Junio C Hamano wrote:

> The seventh batch is in; I've merged fix-up topics that has been in
> 'master' for some time (i.e. up to the third batch of this cycle)
> down to 'maint'.

Would you terribly mind also merging `js/gcc-8-and-9` into `maint`?
Otherwise, the CI build is broken after my upgrade of the Git for
Windows SDk to GCC v9.x.

Thanks,
Dscho
