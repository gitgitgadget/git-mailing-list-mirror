Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E160202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdJZRMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:12:30 -0400
Received: from mout.web.de ([212.227.17.11]:63803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbdJZRM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:12:29 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3jwL-1dHS673WUL-00rDgV; Thu, 26
 Oct 2017 19:12:18 +0200
Subject: Re: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
 <20171025184912.21657-2-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3f656948-273f-e01d-ad52-e460059571da@web.de>
Date:   Thu, 26 Oct 2017 19:12:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171025184912.21657-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:XYw1YZx1xZttGzSmB3epZ5wHqUDCsu0Ai/A+vLflkkzzxlrdkSX
 dANGFUxaf3Brhdm3tK+tK+n+MyOiPyPdxPAxWL9vq/jVm2bz46aZseW31drchxPsIYVkhDn
 4x/W+Z3D4PH6I0grhvZY6Q2HVEvU4j/16MT77dzimoAr5+qJrYcxtsjfccD/Xqv64ki0sOy
 iIepUJI6kC+9JjLo2hDbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ioe31QQov0E=:SYxy9VhXJjzfaQRAAsC0Lo
 9asJ4nymG6Q0Rvj0NGDobQQhRDu/nPXgK/67Ma8LRwYW2p0KPRnUqJ/YxtOP+PbElT8oJvtji
 RUiycsH85nOWM4BD8kKo/xR8H51zoN23Iq/aLI2UbbgHgSxSBG5G/Ad5R6zRJCaYPcN5URgZi
 F0p9/ihB10gUvD8ep6xYTlUiNcO3mWrs92K18hFuGMlLOJBEDhKyCRpK5mIqKSe/Rxtc0CKLj
 0q5LnPYMneJF6zL2QYMIgQ6IRqSVDFvrXP3zjPM3MHVFmrblUykvzWUmIo/0ZBwOT9x+9GT/4
 Pw9DGPAH4x9pk+Yl+0AkDJCh1qe5iph5JTWDqUb6ACL79CfTxfFMyc5O1fdas8j7uz1g3aKRT
 ca1+QpSi5mIEKbIFdmgkL9dAuqBzWnh1wj4dGLwFDZP1mUWH8EX6JYzZ5KHPdQXfpizf+DfXH
 bfsriGk/KCpebrVjELiGihIrBQ6O5U7XsLMaV1UGW+tZXkdl71XBrPqm5AN7lnT8aVB9JfzlJ
 H+G39cpxXPiDDG4mPHMKL3LkQtwbSMwCxW0rvKF2RQv9BWyDc2xYZKcgkCH+lg/7edNlGwsqw
 X2W7SwHX7IrGx89tfIa9mvJwcdu8SG95vnge7ChnFy01Q3g2zHKQmDP8cqx9IUfL3wZshiqJc
 KpgIDLDw2GyJ+TOcW33cY4pICrP/GTzZ1ZM+kL9fZ1WdNLTFCOBHx/nNae7IV4/nQyo2mvxKp
 svjj7bJJ7xZXU1Em8pPX0JIYJikAAReWEdFRBe85KtNOyTt8OzWx+9g9unFO8dO4yl30a9XCM
 R+lYG4MaD/TGD2KrlH4Zgrkz1Ljv03iGdtqjRcj1acyUugKyJE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.2017 um 20:49 schrieb Stefan Beller:
> +/*
> + * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
> + * Returns 1 if the strings are deemed equal, 0 otherwise.
> + * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
> + * are treated for the comparision.
> + */
> +extern int xdiff_compare_lines(const char *l1, long s1,
> +			       const char *l2, long s2, long flags);

With the added comment it's OK here.

Still, I find the tendency in libxdiff to use the shortest possible
variable names to be hard on the eyes.  That math-like notation may have
its place in that external library, but I think we should be careful
lest it spreads.

René
