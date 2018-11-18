Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB991F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeKSCCD (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 21:02:03 -0500
Received: from mout.web.de ([212.227.17.11]:48695 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSCCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 21:02:03 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJKJ-1g0a100aaZ-00TRKJ; Sun, 18
 Nov 2018 16:41:25 +0100
Date:   Sun, 18 Nov 2018 16:41:24 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cygwin Git with Windows paths
Message-ID: <20181118154124.GA21680@tor.lan>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:1LBwBk6PcCdYl2OuVekelNRpb4qf14vG+uynUQpOCdFdfvIItNI
 2HNtyRLAGkYirXlYOleItq4vHpujr/+IwK5P92hEEUnkFVCvGSbn0VDEVp9xmI4uoUvv3WE
 KQ5posv2MJ2yTlh20f9UPPkuq++CUZGgJE+ZJN8jnJbIAAstYC9QeuzHgxXXRPkTk+kWjUb
 jNetjnX/4ByyNH3BomSrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nyKvVNAu/JM=:v7d3aH8H2bHgnYjxtrcA3y
 AiW858E6vYYKaZsZHiUwrr63ejPeMdLZwcHVNdIABwUxcnI40sNHjo7KGLbpOnU/iXZ2O4p0C
 PQw5h+zGipwPei+pADkomtKslirCujUOs7/g2AmODumOqJfnMIj9TCy/5IFYd/AETlQ0KmfSM
 0fCCZiSd+OKu2fwj8HV5RLissZWkpFBQFVGTtkqym4qW4Gbcl8rBEMRRc52PykUkadP+YcMtV
 hhxB5/XvpgPYnS0gKuHzAdmTYl3KU3MI5kWSiEUPHqaT7ZVkSzOElJgwAczLV9KDGaW/eEwQD
 eJJi+Crau3lOmaQsA/e0QbYjZ1MVjUH1bYDfIIz+BQbThRVU0DuP8n4Q3cp/J5KW8UK/jF/mH
 gDxnvuV+nYgfK1VMRsd436VUAMMOrr+YJq741z5aYBP1QoMuPuUGysV8diZJdFYwfGdGXAeYW
 sfn062rlxrVwhzPZjFC+guj5RJSJ/OCuy9CYj+YB/vDCPIJTbJFusKM5MAX1/TZDBdqBTl5AL
 753MrQUOpI69W749bgIdi1JdcOjQgG1E/vV8R7pt4uHHxd9AuCefN2n8UlIJHkKSnG2RGKtJ7
 2IQjX4XjP/SZZKkQF9LvIqNJNbZrNTy+tRTxYU3A3Obkl3pGTlGawSmE3v0NQQJYjGjtjbYsc
 VmOncmCa3qS11VIYNWhDQzjklwR88rNW2aY3mPay8Nu9QOpmU1v+c/Wk9NrdwmBeoqKtp9UfP
 bbNg2HZa7GCH+v0hwVuP/wP64dds9UYm9Rjd3MESsHJbcWMV6ji6CRgpGFOVs3eRLWEzD21Y5
 WwR8mskNL0MFF0n9iTpawzGrgdMFGNtiqC0qzlTBd9Efrxq9A64gKs4JAQlHk586vLK47P+dA
 FCYVEHNKvtDB91jTLEMYLcPeHpMR0gWwUk3Br4yS4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 07:21:58AM -0800, Steven Penny wrote:
> Cygwin programs can handle Unix form paths:
> 
>    $ ls /var
>    cache  lib  log  run  tmp
> 
> and also Windows form paths:
> 
>    $ ls 'C:\cygwin64\var'
>    cache  lib  log  run  tmp
> 
> However current Cygwin Git cannot:
> 
>    $ git clone git://github.com/benhoyt/goawk 'C:\cygwin64\tmp\goawk'
>    Cloning into 'C:\cygwin64\tmp\goawk'...
>    fatal: Invalid path '/home/Steven/C:\cygwin64\tmp\goawk': No such file or
>    directory
> 
> It seems the problem is that Git thinks the Windows form path is relative
> because it does not start with "/". A Git Bisect reveals this:
> 
> 05b458c104708141d2fad211d79703b3b99cc5a8 is the first bad commit
> commit 05b458c104708141d2fad211d79703b3b99cc5a8
> Author: Brandon Williams <bmwill@google.com>
> Date:   Mon Dec 12 10:16:52 2016 -0800
> 
>    real_path: resolve symlinks by hand
> 
>    The current implementation of real_path uses chdir() in order to resolve
>    symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
>    process as a whole and not just an individual thread.  Instead perform
>    the symlink resolution by hand so that the calls to chdir() can be
>    removed, making real_path one step closer to being reentrant.
> 
>    Signed-off-by: Brandon Williams <bmwill@google.com>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> This causes problems for any non-Cygwin tools that might call Git:
> 
> http://github.com/golang/go/issues/23155
> 

Thanks for the report
It seams as if "C:" is not recognized as an absolute path under
cygwin.
May be it should ?

Does the following help ? (fully untested)


diff --git a/compat/cygwin.h b/compat/cygwin.h
index 8e52de4644..12814e1edb 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -1,2 +1,4 @@
 int cygwin_offset_1st_component(const char *path);
 #define offset_1st_component cygwin_offset_1st_component
+#define has_dos_drive_prefix(path) \
+       (isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
