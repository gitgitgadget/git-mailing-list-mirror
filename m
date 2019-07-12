Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7571F461
	for <e@80x24.org>; Fri, 12 Jul 2019 10:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfGLKBd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 06:01:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:56217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGLKBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 06:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562925692;
        bh=CjiItl6odKgE39+j8EC5kCn78CiSkF742d4vI/PVrk4=;
        h=X-UI-Sender-Class:Subject:From:To:In-Reply-To:References:Date;
        b=W8SHuZd0Z+ec7ODNCTjKZe/I/809YAsMqNKcY1zWQS+T08Tk/jWCKAu++5Nfq5Dfd
         eb26O5vFbNK02/zoe7x0Sucjkq494wWq3lFsptx8bn/VUA7PdBq7II3rQSMXjDSYl6
         xbWzHgrVwgNVjEvonTyaMPJVw0rplZ59N9p5ByLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([94.79.149.170]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC8iq-1hd6vT3YqO-008rwk; Fri, 12
 Jul 2019 12:01:31 +0200
Message-ID: <edb1cc8f69e59015033604530513ff58f0bf8256.camel@gmx.net>
Subject: Re: git p4 sync: "str expected, not %s"
From:   "Massimo B." <massimo.b@gmx.net>
To:     Andrey <ahippo@yandex.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <17077551562900174@sas1-9134aa144859.qloud-c.yandex.net>
References: <34d6121da46f35e4b81d38169b1b86ca123cef37.camel@gmx.net>
         <17077551562900174@sas1-9134aa144859.qloud-c.yandex.net>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 12 Jul 2019 12:01:26 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.30.5 
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HtcPal31RvLFcjGABmtPuEtgT28giYGKYElecIxLU+RFb2Apt36
 OEEh0t6D5nZykM74fyA2FOGdkC80WnuWYR0oXhF8s0KnMYhKD74WmeonoO4px1jS4G7/0QF
 gP7Xmo9fcup/yCUny4ebacBPd1LAHpgr9j8JHh4ADar7/ZSNLZIin9XVaXtl285srYwpp+m
 4yV8rvuPlWZkjyWezovAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OojqQn/VbOQ=:Stj7JZ8y0KE8+QsuVk7Q/Z
 2Oz24bauVLnzPPWn/Cqqd8gYo3mBQx5zsHvwLxWJnJhUh9onat4RYx2MVItNiG94y6Poq4GeI
 MASVHy7TEJlTPTvfDEdACi5KUEAH1+F8U1dEO7hKtVMiygF3iLc38lLTG6VbiX7utBdYkGypc
 kOSbqe5J3ijX4hyMZeJqBYiaPG1u6jM/nTj2OcdjM46jtpL5Mf3dR1P52KQgAzh6iQH2zYf6Y
 CLTCbJmHHGJLl0AMxin6pq+7wcY3CYD5x4EwPZNhJ82Tf3t8xJdKlLDxEj/rvWnD/SoVDr5LR
 LRIg97NR9Sk7yYKNstGVEX3yAX2RXNPs7pqbM8JYe5dsmM/NWAu6ZNAz5PFIOmmgV1IgxVw6k
 km8FNCziN7n/0iCIxQk5FcPupDpHoa755gRDpW3BuuvabjGNx9h2yVNQKV7qC6NRDvY0FfhRF
 S9SMiwzxeczlsnNJMbIsWXyLaqvphDQbeYXAhZK6J1CLPrn25dr/1937z41vbHFrGb3ylFK1T
 ExykHl43NZI69L5H7Ku9e4EKogJXQ60QDiLnY87WbYF/9Li0lSOU/PEGZvW2VMvv/w4Gv9wc+
 CZaDTk86nq2+GuOv9QDW3IH/rZR7NeSKkMGq8/G+tgZfYCPsvXy6NRzlUtJpemsxUHXfer9Xf
 aVbRWdSNgLVLfUvBC0TuJT5CiWL2jezoXSuCizHAWZgjLDBDUfCwe+JBF29nz1RxvPLFow1vc
 ecMD4k9eWepJIv35VtQkYM3+JLo5tC2FZjE7jOOjfbeTqBDLLWcAXNx+/pAaVuNSZyTELcl2M
 oDf/mZJrzVb9APBBiPWVxHdJwlMcGq+hLc5t+I3NJNI7LOs94kuBBA2E0tfQFc5QnjK9w9mDR
 t6E9rygtpp0aIOjRBxKvwqOLUXahIsa4eldKAeaY2Gs6jmBTLStid5oyq1ZKMlvdFBLis3FJF
 VR4B48hAqhnQGfLtWYPmS5G9dfUHbzppMdykQ4r4tDWgzS3Qpif7ujqQbAXYlr9ZQBPUpOGa1
 bxUffowdTVWWTzR8R13s1UYsiKaeFWQ/m0Jv+5amSE04SJiVoeNQqCmcQh0ZYkLg+nr39Zlm0
 29aAZVBkLJ7j6qcdDvQneroH/QCGZXbVugC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2019-07-11 at 22:56 -0400, Andrey wrote:

> Strangely, I don't see any changes that could have broken it between 2.20.1
> and 2.22.0.

> Are you sure your git repository is not "bare", i.e. there's .git
> subdirectory?
> Looks like, it doesn't think that "MM6.test/.git" is a valid git repository
> while it would normally be.

I forgot to say, yes it is a bare repo, was created like this:
# git p4 clone --bare //MM6.test@all --verbose

> Anyway, could you, please, try the patch below to see if it helps?

I did, but this fails now like this:

fatal: cannot locate git repository at b'.'

Best regards,
Massimo

