Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EDD20323
	for <e@80x24.org>; Mon, 20 Mar 2017 05:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdCTFhK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 01:37:10 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45400 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750717AbdCTFhK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 01:37:10 -0400
X-AuditID: 1207440d-029ff70000003721-29-58cf6a816bf3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F0.F8.14113.18A6FC85; Mon, 20 Mar 2017 01:37:08 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2K5b2BM011399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 01:37:03 -0400
Subject: Re: [PATCH v6 00/27] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9f6d9544-a869-3d89-4025-345fac1ac70c@alum.mit.edu>
Date:   Mon, 20 Mar 2017 06:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqNuSdT7C4PJpZouuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZfzctY6pYAJbxfaJv5gbGN+zdDFyckgImEjs3LKFrYuR
        i0NIYAeTxMSTc6CcC0wSv1bsYAWpEhZwlvh34icTiC0ikCaxePJ7ZhBbSCBZ4srr+SwgDcwC
        NxglLk38CFbEJqArsainGczmFbCXePJsBmMXIwcHi4CqxPcF2iBhUYEQiTkLHzBClAhKnJz5
        hAWkhFPAXGLlIiuQMLOAusSfeZeYIWx5ieats5knMPLPQtIxC0nZLCRlCxiZVzHKJeaU5urm
        JmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhDrvDsb/62QOMQpwMCrx8N64dC5CiDWxrLgy
        9xCjJAeTkiivps/5CCG+pPyUyozE4oz4otKc1OJDjBIczEoivDsSgHK8KYmVValF+TApaQ4W
        JXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneRxlAjYJFqempFWmZOSUIaSYOTpDhPEDDGTNB
        hhcXJOYWZ6ZD5E8x6nLcOH7gDZMQS15+XqqUOK8MSJEASFFGaR7cHFiKesUoDvSWMO8vkHU8
        wPQGN+kV0BImoCXLbpwBWVKSiJCSamDsXzTlztO2wFfPf4VYKcivYLr8zLdietpiyasK5htY
        j5Wvjfn8Li/Ntojv/+uLmccVvD6Jvg40c3+TznZznvjJbcLn33EmNy7/PmeZRIBxdF7mUjcL
        bybhT/wrT53ete7FnIxnGjn3ffdeXPBCwV0mxdzVL6esLazPY8PTK1OWCTznkSnm9O1QYinO
        SDTUYi4qTgQAdSoqiSwDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> v6 should address all Micheal's comments in v5, except a few that I
> replied back. The interdiff looks a bit messy due to some new
> refactoring (05/27) in files_rename_ref(), but it makes the final
> output easier to read.
> 
> 03/27 and 27/27 are also new patches that are not really necessary but
> nice to have.
> 
> The series is rebased on latest master and does not depend on any
> other topics, since they all have graduated to master.

Thanks for the new version of this patch series. I left a few optional
comments, but nothing serious. With or without the suggested changes, I
think it's ready to go. Thanks for working on this!

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

