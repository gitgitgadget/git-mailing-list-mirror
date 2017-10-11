Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E7E20372
	for <e@80x24.org>; Wed, 11 Oct 2017 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdJKKFz (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 06:05:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63887 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751816AbdJKKFy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 06:05:54 -0400
X-AuditID: 12074413-38bff70000007929-6c-59dded008c31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.86.31017.00DEDD95; Wed, 11 Oct 2017 06:05:52 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9BA5ogm010898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 06:05:51 -0400
Subject: Re: [PATCH v2 00/24] object_id part 10
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
Date:   Wed, 11 Oct 2017 12:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1GV8ezfSoOMBs8Xz9SfYLbqudDNZ
        /GjpYbZom/mDyWLz5nYWB1aP5Tf/Mnks2FTq8ax3D6PH501yASxRXDYpqTmZZalF+nYJXBmd
        a36xF3RwVjw8OIOtgXElexcjJ4eEgIlE6/9Wli5GLg4hgR1MEjO3vGOHcC4wSdztm8cMUiUs
        oC9x9/cFNhBbRMBLYv6jGawgNrNAgcTz9juMILaQgJPE7XczwaayCehKLOppZgKxeQXsJR61
        HwSrZxFQldiz7j7QTA4OUYEIiQ0b+SFKBCVOznzCAmJzCjhLrLy8iR1ivLrEn3mXmCFscYlb
        T+YzQdjyEtvfzmGewCgwC0n7LCQts5C0zELSsoCRZRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqR
        rrlebmaJXmpK6SZGSLgL72DcdVLuEKMAB6MSD6/A9TuRQqyJZcWVuYcYJTmYlER5rz+/GynE
        l5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfBa6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2
        ampBahFMVoaDQ0mCV/INUKNgUWp6akVaZk4JQpqJgxNkOA/Q8Adgw4sLEnOLM9Mh8qcYFaXE
        eT+BJARAEhmleXC9sHT0ilEc6BVhXhaQFTzAVAbX/QpoMBPQYNG0OyCDSxIRUlINjPErz+eI
        OtVPjl/7Qt4heFbw9/6fncoOrkmzJjibf3x8Rk7ix++PQg8+5q1p/jy9/NyfaXGW5m+tI1s8
        yx9+i9k3d9XV7e92/U05cPq3Ga9awJHJP958/j3dIazm5oN3ZjPM5lUau0i9+R+lI5jK6nGo
        8vO/dr+6OzzZ9l+e/pyVqfIudE7a4ytKLMUZiYZazEXFiQDskvAcIgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
> 
> The series has not been rebased on master since the last submission, but
> I can do so if that's more convenient.
> 
> This series is available from the following URL:
> https://github.com/bk2204/git.git object-id-part10

I read through the whole series medium-thoroughly and left a few
comments, but overall it looks very good and clear. Thanks so much for
working on this!

I took a stab at rebasing this patch series on top of current master
using `git-imerge`. I pushed the results to my GitHub fork [1] as branch
`object-id-part-10-rebased`. I didn't check the results very carefully,
nor whether the commit messages need adjusting, but I did verify that
each of the commits passes the test suite. Junio, it might serve as
something to compare against your conflict resolution.

Michael

[1] https://github.com/mhagger/git
