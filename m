Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E0C1FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761688AbcLSL37 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:29:59 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43094 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755034AbcLSL35 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 06:29:57 -0500
X-AuditID: 12074413-465ff70000000a33-fe-5857c4a698f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B5.72.02611.6A4C7585; Mon, 19 Dec 2016 06:29:42 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJBTeGW028225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 06:29:41 -0500
Subject: Re: [PATCH 0/5] git check-ref-format --stdin --report-errors
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu>
Date:   Mon, 19 Dec 2016 12:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqLvsSHiEwc5F+hZdV7qZLFa3LGJx
        YPL4dmoTs8fnTXIBTFFcNimpOZllqUX6dglcGWvnvmQqeMtTsfbeV+YGxh6uLkZODgkBE4kZ
        zb1sXYxcHEIClxklvq44wwzhXGCSOHThImMXIweHsICrxNuWMpAGEQE3ibOfGplAbCEBF4nu
        3hdsIDabgK7Eop5msDivgL3ExpkrwGwWAVWJ1t2bwGxRgRCJy3OOskHUCEqcnPmEBcTmBBp/
        8vk9ZhCbWUBPYsf1X6wQtrzE9rdzmCcw8s1C0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybr
        Ficn5uWlFuma6+VmluilppRuYoSEnfAOxl0n5Q4xCnAwKvHwFrwPixBiTSwrrsw9xCjJwaQk
        yjtlbUiEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHevEPhEUK8KYmVValF+TApaQ4WJXFetSXq
        fkIC6YklqdmpqQWpRTBZGQ4OJQle7sNAjYJFqempFWmZOSUIaSYOTpDhPEDDHUBqeIsLEnOL
        M9Mh8qcYFaXEeXeAbBUASWSU5sH1wtLCK0ZxoFeEeb1A2nmAKQWu+xXQYCagwQu7wQaXJCKk
        pBoY1blOrSv8YnrRLsf+4OzLTaeUzlhw+F75cc/2197vdpVm38+Evzm1rezlgmXHtWIEmua/
        X2VvUy+f81zw3pZZzh/WLpn0+Wim1jSx1bKO12o6+32XcCY+O/jry/7ezG3h57Y9Ou1l9rPj
        ydS8QL4Dre57HOyUP08VOhnquH2m+uWstdLTfhct3KbEUpyRaKjFXFScCACN1TIA5gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> I wanted to be able to syntax check lots of proposed refs quickly
> (please don't ask why - it's complicated!)
> 
> So I added a --stdin option to git-check-ref-format.  Also it has
> --report-errors now too so you can get some kind of useful error
> message if it complains.
> 
> It's still not really a good batch mode but it's good enough for my
> use case.  To improve it would involve a new command line option to
> offer a suitable stdout output format.
> 
> There are three small refactoring patches and the two patches with new
> options and corresponding docs.
> 
> Thanks for your attention.
> 
> FYI I am not likely to need this again in the near future: it's a
> one-off use case.  So my effort for rework is probably limited.  I
> thought I'd share what I'd done in what I hope is a useful form,
> anyway.

Thanks for your patches. I left some comments about the individual patches.

I don't know whether this feature will be popular, but it's not a lot of
code to add it, so it would be OK with me.

Especially given that the output is not especially machine-readable, it
might be more consistent with other commands to call the new feature
`--verbose` rather than `--report-errors`.

If it is thought likely that scripts will want to leave a pipe open to
this command and feed it one query at a time, then it would be helpful
to flush stdout after each reference's result is written. If the
opposite use case is common (mass processing of refnames), we could
always add a `--buffer` option like the one that `git cat-file --batch` has.

Michael

