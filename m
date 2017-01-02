Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B156205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbdABSOm (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:14:42 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55226 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933382AbdABSOP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 13:14:15 -0500
X-AuditID: 1207440d-8cfff700000009ba-4e-586a986ef668
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.F2.02490.E689A685; Mon,  2 Jan 2017 13:14:06 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02IE3IU007235
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 13:14:04 -0500
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
 <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley>
 <CA+P7+xqxSpV4yOjE+Lv0kw19Kq6UAbcN_-7O3U_EeBoT7AOtfw@mail.gmail.com>
 <20170102041947.5jzx6og5fcpv7oso@sigill.intra.peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ab92dc60-c623-0f6f-868b-b74b1d6dbd2e@alum.mit.edu>
Date:   Mon, 2 Jan 2017 19:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170102041947.5jzx6og5fcpv7oso@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1M2bkRVhsPqGhkXXlW4mi4beK8wW
        uxf3M1ssefia2eJHSw+zRedUWQc2j52z7rJ7LF+6jtGjq/0Im8ez3j2MHhcvKXt83iQXwBbF
        ZZOSmpNZllqkb5fAlfHn93GWgufcFRunLWZsYFzL2cXIySEhYCJx9vsnli5GLg4hgcuMEpuO
        HWaCcM4wSTx/co4NpEpYwE9iz+pHzF2MHBwiAi4SPc9KIGrmMEs0NU1nBalhFljFKDFhljCI
        zSagK7Gop5kJxOYVsJdY8KmXEcRmEVCRePz1Pli9qECIxOU5R9kgagQlTs58wgJicwLNv9Dw
        hQ1iprrEn3mXmCFseYntb+cwT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7M
        y0st0jXSy80s0UtNKd3ECAlu3h2M/9fJHGIU4GBU4uHtiMqKEGJNLCuuzD3EKMnBpCTK+7QO
        KMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd9JkoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJ
        anZqakFqEUxWhoNDSYKXazpQo2BRanpqRVpmTglCmomDE2Q4D9DwlGkgw4sLEnOLM9Mh8qcY
        FaXEeVVBEgIgiYzSPLheWPJ5xSgO9IowbxTICh5g4oLrfgU0mAlo8Ne4dJDBJYkIKakGRq1v
        6e3Pj/3I+nvt/jHGvVWHGFid5t1Ji+lx3rPNe9KvdZLTLV4G+ZlEV6uyH1PvnV8z4+xc3yj9
        6idLjmhoCh83yvwy7e6K2TNfTA/cV7XjX6npBG8G/+OBotXFETuK2Kbv3lrtcKRjmta2pa8q
        bh/P0xHublz2mX35uayKtddaX3E+vPfZ67kSS3FGoqEWc1FxIgBH4w3IGQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02/2017 05:19 AM, Jeff King wrote:
> On Sun, Jan 01, 2017 at 12:36:11PM -0800, Jacob Keller wrote:
> 
>> But how likely is it to end up with differing binaries running on the
>> exact same repository concurrently? Basically, I am trying to see
>> whether or not we could accidentally end up causing problems by trying
>> to race with other git processes that haven't yet been made safe
>> against race? Is the worst case only that some git operation would
>> fail and you would have to retry?
> 
> Yes, I think that is the worst case.
> 
> A more likely scenario might be something like a server accepting pushes
> or other ref updates from both JGit and regular git (or maybe libgit2
> and regular git).
> 
> IMHO it's not really worth worrying about too much. Certain esoteric
> setups might have a slightly higher chance of a pretty obscure race
> condition happening on a very busy repository. I hate to say "eh, ship
> it, we'll see if anybody complains". But I'd be surprised to get a
> single report about this.

I agree. I think these races would mostly affect busy hosting sites and
result in failed updates rather than corruption. And the races can
already occur whenever the user runs `git pack-refs`. By contrast, the
failure to delete empty directories is more likely to affect normal users.

That being said, if Junio wants to merge all but the last two patches in
one release, then merge the last two a release or two later, I have no
objections.

Michael

