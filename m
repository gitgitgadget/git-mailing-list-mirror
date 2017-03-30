Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AD41FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbdC3Hsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 03:48:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60505 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932762AbdC3Hsk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 03:48:40 -0400
X-AuditID: 1207440d-041ff70000003721-af-58dcb8541e85
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 45.A9.14113.458BCD85; Thu, 30 Mar 2017 03:48:38 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U7mYOC017706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 03:48:35 -0400
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <55790129-737e-6bec-ff9c-147c969dd584@alum.mit.edu>
Date:   Thu, 30 Mar 2017 09:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1A3bcSfCYPkVJYvHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Ml7P
        +8RScJ254tvBS2wNjN3MXYycHBICJhJNq5axdjFycQgJ7GCSWLxzEhuEc55J4uCN3SwgVcIC
        HhLP//wD6uDgEBGwlri+xgskLCRQLrH31Wp2EJtZwEbieFMvI4jNJqArsainmQnE5hWwl5i7
        biZYnEVAVWLKpOtgI0UFQiTmLHzACFEjKHFy5hOwOKeAo8S6k62MEDP1JHZc/8UKYctLbH87
        h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZI
        8PLuYPy/TuYQowAHoxIPb8Xa2xFCrIllxZW5hxglOZiURHk3z70TIcSXlJ9SmZFYnBFfVJqT
        WnyIUYKDWUmE124xUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFb
        vh2oUbAoNT21Ii0zpwQhzcTBCTKcB2j4VpAa3uKCxNzizHSI/ClGXY4bxw+8YRJiycvPS5US
        532wDahIAKQoozQPbg4s6bxiFAd6S5jXGGQUDzBhwU16BbSECWiJuM0tkCUliQgpqQbG8jyu
        mQoau7QvCYava1nc6r9ux7zTV3W5tW+nK/7fyPGg7+78GUu8864nL7+x7N+mu5M//zOe7ndR
        62J2+pzzHdfun75k9fB+xT+b+0cfxl2LCdWvu3VFMX4Cg4YC96qwb2sfpblnvP3zJfrur/ov
        RX2vi/YHLe13e6YYbjE/ZtGLfIGfSRcqCpRYijMSDbWYi4oTAaeMv+sVAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Create t/helper/test-dir-iterator.c, which prints relevant information
> about a directory tree iterated over with dir_iterator.
> 
> Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
> iterate through a whole directory tree and that post-order directory
> iteration is correctly implemented.

Please also add the compiled test program `test-dir-iterator` to
`t/helper/.gitignore`.

Michael

