Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF551F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbfHHU4i (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:56:38 -0400
Received: from mout.web.de ([212.227.17.11]:55129 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHU4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565297792;
        bh=+dU8Fb/VxaRa5tnojeZjCwD1DO4yoeVD2NLHO0QkYq0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UsEMfonMYXScKiF076KdxDdFLwW/1dK+hhVoz60yPuSVyooAyIwkX3lIFq0OqNVtB
         2hzsh6qZau+dXYSwa+YjuhlZK+COKTHXBLHp4/hIvdeGoDvwhhttJ2JhCSeLbQmgYH
         k8W4LsThpXdNrXlEg5IkJIekpdHHLzEFO6ayIDDU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCnT-1hkeHH3Fst-00UYYw; Thu, 08
 Aug 2019 22:56:32 +0200
Date:   Thu, 8 Aug 2019 22:56:31 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190808205631.e2647kxq74thotjb@tb-raspi4>
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:MDYz3Sro4B9EowovX9X0Syj7QtNsSWSiOvbx3ofkA6QAdLZh+iG
 uEYhv+X7nvFe8KGxR/3fRyKVoqUJYoEBeeUvF6dvcCNNhzdvW9EYeJ42jcteKX2RpgNrQu2
 TipLs0BXo+ssppth6cN83mGeWu49WZP/R8czSUvyD4PQFyDP4W49AN5EGASorWb93geVAQq
 MIpNGzPsqYSngJ+RgwIOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Fx9ZsvHNKc=:a/Gh4qWJvHNmtVd1oUF+I0
 YYfx9s8DdX30+9un77c4Nz3zZ9CDOeLj7SeYWcnfRXzg7SpwXu6f5QGsE7/lC/aqUCEirNSPf
 a3TH0Q5RFbvywKuSJ/tbXDs1XMwNPH6kI37zi8SfGHSe8gd0SD+Wz7RsegwC3hL/JXOkNjpIG
 tYK3k8R6vAzjSQufhZ7B9FKg4DhGmnA4YvGLppGt80w+sJ4GxOVNMC3ZtjkMRFmmr926shvrl
 BO9UthpxNlRTdTEHUZY7ahSZb8hnSAHCI8ibFNkK+xULleT42WxbHu9b0apf/8gir78SaVcHb
 Wuj8rxn9NxWmCLHNDAPAmoBbLakGUzFclAWnOsFOsQlkYMVVkRhIwscTVDRFcNkej4uCOQy32
 M3vHlcrJdVjWNYF93X5CNDrVhG5uEfySAyL8Eriq7G46Lxl44QwPYNMCfQjBK+KR8tRImD6ze
 Z0WC+LZkpppxuAXSiRcuamv/1wjw3Z0RHThyy+QpwP0lESzmjaxC0DcRr6LRYHrvyw4Yf53t3
 Tu4IhoafAmaG5L09H1BI0PyhzrhMTRYubXhHL50jgdEVd7arTWc2Lfg5yRsAMNXEkJxKburOF
 GoCL6ukXOMONmAlDKSYLjOQe+NiGWxl5L1yLU+j17udtXGRHvklsR4JRU7vERPYpsnhDEt075
 SK1fQjmrgOOvrBMWDxO26YS6jD3Jo8udiJBbA/eA1Vtdw2YpxQBd6fFc7AcbcyOVSij1hBcmG
 594HeXnJPCk+B4F6/Jfjn8bb60hQ8KXXJRwq4DmRg5EMfe7qubEuG89qd3+JPgT6PM7Mh/5f7
 xakklGwy4xiv1+WnNolCCj7eBA/WK9O+2sSeuqZ110aTufm7W7HrONKnlWWcESz5jbRM09ijS
 /90uZaICCFsyVUYFDUnM/XhvERBP3FLZXz+N7H4lf7USXXESPfNvbXT6Y6VK6FNIkqDmFHhew
 7aOd+ibRPzjBnJ+YNUmK/dYqLlXNh2/XMisCk9rkgTUS8eCzP4BA9ll5UmC4rnnBV0Iy7pdYh
 PUMAvemgWiv80ZDzpiHFbnzO59RzRCp5VdjGemOlF8afFjYTkzJVmGs4jquIfV+mN2u90sR+e
 ABr66243rJhvkhHODKi494dz5NIXWsToNz6yAvuxVIgW4ohVYJ9kxAjAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 01:08:22PM +0000, Yagnatinsky, Mark wrote:
> I hope this is the right mailing list, hope someone will redirect me if not...

Yes, you are at the right place, wellcome to the Git community.

> The git documentation (git help config) for core.autocrlf doesn't mention that false is a valid option; it only mentions true and input.

This is somewhat common to all config settings:
WHen a new feature is introduced, Git treats "config not defined" as false.
This allows later Git versions to behave like older versions,
when the config is not set.
In that sense "not set" means the same as "false", and is the opposite to "true".
(At least for core.autocrlf).

Later the third value "input" was introduced.

> Further, the docs for "input" are misleading, in that they lead the reader to assume it behaves like "false".
>
We can agree on that.

> Would probably be nice if this were fixed :)

Yes, do I read this as "I will send a patch" ?
That would be nice.

> Mark.
