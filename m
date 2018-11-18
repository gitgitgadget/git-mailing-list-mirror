Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00741F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKSEts (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 23:49:48 -0500
Received: from mout.web.de ([212.227.15.3]:41771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbeKSEts (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 23:49:48 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MS29q-1g0p3l1WnK-00TBoF; Sun, 18
 Nov 2018 19:28:47 +0100
Date:   Sun, 18 Nov 2018 19:28:47 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cygwin Git with Windows paths
Message-ID: <20181118182847.GA31405@tor.lan>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan>
 <CAAXzdLXmJ1YKiTF17b=ZfkM3HtJCNkvVMQNU=riW8R42VLid_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXzdLXmJ1YKiTF17b=ZfkM3HtJCNkvVMQNU=riW8R42VLid_Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:JgmaJvbbh3dGq1bSTcxDnXawx/Cp84rgMRPE1Mmle0t/gNnAp+T
 9gtLw7yeqgTqgqpPBq2N74cFjp5LcWWYUEVtlFMdD8/LrUNzC0VQm1XUtZSiIy+3FdRgxOG
 aWwdjZdMHm9HtQcx7ka7iYEh5mq73UCvXUImVn+87fqK9TcRgPYwf/GcKwKxKlh9RmSFKFF
 EDzjL299nPmxZTGKVSsAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SVfCINMcrJU=:lmRDsWTZq/v70xS/xSygw9
 kwRFzkE8TPEmwG6aVRQ0DeR+4OeLA7eCd478tVQ3amV/DS+qBNjPdEtomvBnabBstJ8mkio3f
 27NfuGVcMtLzDTdn4u0fcACd8x/9yG05aj6khSwyLIgef9+w8HnnK02Iv+eUqfhCeSimkle0B
 RfD037gbYUS0B4qF0TXgZnCp9W2gtGY0qXsvip0yckCnl+2BjUhbLxfTJwm7KM5A3lNRyTbn9
 KigBjBsGYiB69to5xft0HHsRbvvwdkHYdIDc/d325KLgy8OPo1PvjvsRhBrgn/5LIwGva37Pq
 ZfghYeYa9pNQl6izfDDAyfV7a1UhYYqBt5dRfxiAxEJLH85tGRKA3lIgCpoPSoZaRrpBUORxI
 4OGDfOhZF06GcDOqSnMV3JXAJbHe/7zh7Ihllcm3AXBy0EhjLzJl20nfN2CqFWFq3KIkyiL6m
 U7WdfdnPfFC2B7WJNCNE7vRrUFLG+f+isPXrh3DU58w8wljIqjcEpUNoMdEWoLMUrKnHIM7d8
 nLgDYdX5oftA646c2nXi95QugIOZ0ILU3EVLS5OUMu7gdfH/XNttJ7xS4EWory5xinlSsaXJQ
 RhNzmxEKrM382jzw6mSPi7NVLOvujL6+NEJ6igXEECDAX+cZcNdj8EGFQOgDvfOUe8f39qKfM
 y1S1vD6F0PGw4LOJWn2I1JxpO1IwL1u3EZrHuJdyjOsaFtadtyr1HyprL9a85XwxYJHJOZkWx
 VamrtiD2/WTKuUMKaRO+0Id3rqRWijgRrQvynXHVYQFCH1y8NfmvUr26Or7Fo/l6Dfd9jTBam
 EbUJQwgEZBHkxBsVii/Q2MngBCmeBkJvp2iSR18kkmpo3NdhwiNKSobpuXZY3V7QchIgVm8hO
 IN1SKX12ylqazt61fm8zGunHOy4boEFJD0hPbatvk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 11:34:04AM -0600, Steven Penny wrote:
> On Sun, Nov 18, 2018 at 11:15 AM Torsten Bögershausen wrote:
> > But it may be that we need to pull in more stuff, similar to mingw,
> > to get the C: stuff working, see
> > "skip_dos_drive_prefix"
> >
> > And it may even be that we need a special handling for the "\" to be treated
> > as "/".
> >
> > If you implement "skip_dos_drive_prefix" similar to mingw,
> > (rename mingw into cygwin) does
> >
> > git clone <source> C:/my/dir/
> > work ?
> 
> I added this to "compat/cygwin.h":
> 
>     #define has_dos_drive_prefix(path) \
>       (isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
>     int mingw_skip_dos_drive_prefix(char **path);
>     #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
> 
> and added this to "compat/cygwin.c":
> 
>     int mingw_skip_dos_drive_prefix(char **path) {
>       int ret = has_dos_drive_prefix(*path);
>       *path += ret;
>       return ret;
>     }
> 
> but still, these dont work:
> 
>     git clone <source> C:/my/dir
>     git clone <source> 'C:\my\dir'

Thanks for testing.
It looks as if there is more work to be done then just a simple patch.

My last question for today:
Does 

git clone <source> '/cgdrive/c/my/dir'

work ?

