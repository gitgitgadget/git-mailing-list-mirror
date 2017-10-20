Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0781FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbdJTKlE (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 06:41:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17644 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbdJTKlC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 06:41:02 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171020104101epoutp0277fa0779b3b76017965b524540d86c6b~vQSzYhpdh0676806768epoutp02m;
        Fri, 20 Oct 2017 10:41:01 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171020104100epcas2p47a69a3b62fbae900df855b8b0fb437f9~vQSzRbMy02975929759epcas2p4K;
        Fri, 20 Oct 2017 10:41:00 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.3E.04232.CB2D9E95; Fri, 20 Oct 2017 19:41:00 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171020104100epcas2p4adc7b99b7edbf00d1f3bdebf265f2807~vQSy8gm7q1934119341epcas2p41;
        Fri, 20 Oct 2017 10:41:00 +0000 (GMT)
X-AuditID: b6c32a45-d23ff70000001088-20-59e9d2bc6db5
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 24.44.06856.CB2D9E95; Fri, 20 Oct
        2017 19:41:00 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY400GOHAZTMZB0@mmp2.samsung.com>; Fri, 20 Oct 2017 19:41:00 +0900 (KST)
Subject: Re: [PATCH v2] commit: check result of resolve_ref_unsafe
To:     Jeff King <peff@peff.net>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <19dc9ff5-54f3-290a-2dc8-c0be8e4047eb@samsung.com>
Date:   Fri, 20 Oct 2017 13:40:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXbv7u5Gy+u0PChlzIIS1Cyrm4RWKN0PRvVNK9KZFxU3HZuK
        GuRLKmtqCobFBFPMJLXy/S2zmJbla74t08xsttKwULNJL5bbVfDb75zzP+d5/odDYpJWviMZ
        GR3LqqJlcikhwhs79h12axuaDdr/LO0I/cD0jkdrR7J4dErOCEbXTYwjOm2gl0f3NuRi9ELh
        S5zOujmP6JX0bIwuaG8WHBcxLbpJAWPKaUPM4JAL8719lGBu1FcgZql2JzNhasTPCs6LjoWx
        8sh4VuXhEyKKGO3WI2WqOKGnzESkoEciLRKSQHmBOX2Rr0UiUkI1I5humkdcYEbw+Xo+saEa
        Nk8LuEI1gpK0PzwumEIw8+GNwKKyo07C3bFRa4c9tQPMHTXWURg1hqBntMAqIih3GPiVZ2Ub
        yhWGV4owC4spH1gq0fEsjFN7oGHRYOVtVCB0dZQjTmMLK/nvcQsLKT/onSy1zsEobzCtZvA5
        doAXU28Rx85QVzWPWT4B1DUB1BR3rvvxg2+mj3yO7WCuq17AsROYKmoQx8mQoZkhuGYNgiVd
        2brIF+q1TQT3wlbQdPxdy5NreTFoMiWchIHBKgPG8QmoTO1b33AqD1bvT+B5yFm3yZBukwnd
        JhO6TSaKEV6BtrNKtSKcVR9QerqrZQp1XHS4++UYRS2yXpSrfzO63R+gRxSJpFvEgf1fgiR8
        Wbw6UaFHQGJSe7Hn09kgiThMlpjEqmKCVXFyVq1HTiQudRAnNxoCJVS4LJaNYlklq9qo8kih
        YwrSXii84hIVcegf8p4qy+u7mNt9pmj8lrds7+K9x6n4VOun6dDOzGXb0p8edUphw6vJjB/y
        fJPHpaTdxq7gkF02sy3yUMY3YUYkPP27epl/KnlO4VYl939dnV15tXXFiy8xBqQcbfa700cs
        fEVGZ+PBhwnlS9Q5Ay/kiT5+9vlinhRXR8g8XTGVWvYfNIAh3U0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t9jQd09l15GGtyeI2+x9tkdJouuK91M
        Fg29V5gtNt++xWjRdP4Mk8WZrf3MFh9nn2Cx6J7yltHiR0sPs8W0fTvYHbg8ds66y+7xrHcP
        o8fFS8oe7/ddZfPo27KK0ePzJjmP28+2sQSwR3HZpKTmZJalFunbJXBlXD11iLGgkbfi9NJn
        bA2M67m6GDk5JARMJC5/f8jexcjFISSwjlHibf88VgjnIaPEzDs3WUGqhAWcJJbcuMoGYosI
        yEp8P7yREaSIWeAWo8SC6X+hOpqZJF5cWQXWwSagJ3H+1wR2EJtfQEvi8o95zCA2r4CdxOeF
        s5hAbBYBVYmtn66B2aICERLPm9+zQtQISvyYfI8FxOYUcJE4c3cx2BxmATOJLy8Ps0LY4hLH
        7t9khLDlJTavecs8gVFwFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GKjAqO81HK94sTc4tK8
        dL3k/NxNjMCY2nZYq38H4+Ml8YcYBTgYlXh4I869iBRiTSwrrsw9xCjBwawkwmu4/2WkEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6pBkb+ya9/SVx2frGs
        fN2/oI69DmYxbwMvGKYoOzBEu6zi+bLoHPeGQxcD1zYXSWfX+Rb0/dhsNY1nTiBjptw+m1XG
        ik/3BvD8KbY4wvDvRncR7/+FLpK659pebOve1XWnMmDnud5A/XVF/68c4FaOn3Nj+rn40/lp
        PXe8FLTDqzMLJ6fYxCx57KHEUpyRaKjFXFScCACvWBiGpQIAAA==
X-CMS-MailID: 20171020104100epcas2p4adc7b99b7edbf00d1f3bdebf265f2807
X-Msg-Generator: CA
X-Sender-IP: 182.195.42.143
X-Local-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIb?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG0xlYWRpbmcgRW5naW5lZXI=?=
X-Global-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIbU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtMZWFkaW5nIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0NJU0hRG0MxMEdEMDFHRDAxMDE1Nw==?=
CMS-TYPE: 102P
X-CMS-RootMailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-RootMTR: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
        <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
        <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


19.10.2017 20:44, Jeff King wrote:
> On Thu, Oct 19, 2017 at 12:36:50PM +0300, Andrey Okoshkin wrote:
> 
> Thanks, this looks good to me. One other possible minor improvement:
> 
>>   	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
>> +	if (!head)
>> +		die(_("unable to resolve HEAD after creating commit"));
> 
> Should we use die_errno() here to report the value of errno? I think
> resolve_ref_unsafe() should set it consistently (even an internal
> problem, like an illegally-formatted refname, yields EINVAL).
Thanks, sounds relevant.
Also as an alternative solution it's possible to use warning_errno 
(instead of die_errno) and continue with 'head' set to something like
'unreadable|bad HEAD'.

> I grepped the code base looking for other instances of the same problem,
> and found four of them. Patches to follow.
> 
> Unlike this one, I ended up quietly returning an error in most cases.
> The individual commit messages discuss the reasoning for each case, but
> I do wonder if we ought to simply die() in each case out of an abundance
> of caution (either the repo has a broken symref, or some weird
> filesystem error occurred, but either way it may be best not to
> continue). I dunno.
> 
> These are all independent, so can be applied in any order or combination
> with respect to each other and to your patch.
> 
>    [1/4]: test-ref-store: avoid passing NULL to printf
>    [2/4]: remote: handle broken symrefs
>    [3/4]: log: handle broken HEAD in decoration check
>    [4/4]: worktree: handle broken symrefs in find_shared_symref()
Good changes, it's better to apply.

-- 
Best regards,
Andrey
