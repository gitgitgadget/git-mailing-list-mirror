Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B31202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756129AbdJQEtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:49:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52787 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755828AbdJQEtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:49:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id k4so1228313wmc.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 21:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bCGgX53VIbf/qchryyK4BpDbbb2xU9hhNLKT3HYkzco=;
        b=poJ5kzhe4SS78v6cLEOuQGxUqpnR06q9Dn39GERYSRRGcm+wCxC7ixrgDME0rCgU1H
         scVcGb3oR1WNmNI1Tr8psIDQTNHpzB+8oYB4wWKg0Xp16cbFhq3bbDRKsj8YUZb17pVa
         u9FwwsVrvxZJq3fXBtCPzYeeCPyhls+cy6fXy+OnoXFKAuvkEEmg/wErrqvBgCJq6M8S
         O2R/rPXYSFrPRF15txoWHp4s8v4SEnTuUgOey0cbPvqJTcH63AmCdw68iOHKO9sJAkr4
         Ses5m3/c2unGpc7FVNKbnLUm46Y+O9GmTJWcUUfleZO7v4b952gt0IvHU7cDZrvs14Cg
         8C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bCGgX53VIbf/qchryyK4BpDbbb2xU9hhNLKT3HYkzco=;
        b=TvOJzNSkf3tegD6fL505DjWUoEVj9k8HVUiViQ4qMJ/aDU+TAITXCZh/Cg/nV5WvUe
         CEjR7CNijDMMLhTUzgGC+Rkqah/C0rd0dQugBUVL47m9lhSh0P9+cAEPMdOds2LbmHJi
         yC49rlzUy8uzVDbF+ex6RNiaJ1kRiEZ3s6Jc9TWF8LajqOZ2GWKR8wBfskbmnrqgGYtP
         vTWx+5z874bdl3laRCK8ICTHQwvDDKEZSrgENUMU6wSDrwOKKMag87Pwj0g03JBo6CTQ
         QDuX3vIzXN1c/2CnH3gp6zRaonm6JQu8qYVLxEaZy2xywhwauTtTzof21Y0JsrsjAoq9
         PN2g==
X-Gm-Message-State: AMCzsaVFHusreIMN6/i6bzaXN0p0TGSw+MgvPIAih1ikFlXAkYEBQMSm
        Ydsk4hkD0zfbHXkTYlHM+O0=
X-Google-Smtp-Source: ABhQp+SNzMbazoExSgmjk4yICSAWRgOJQqi4uAq07c84SLpPXMcOMT5LHmjdhsNXdDDBFv1iu82LSA==
X-Received: by 10.28.152.76 with SMTP id a73mr2145594wme.127.1508215779079;
        Mon, 16 Oct 2017 21:49:39 -0700 (PDT)
Received: from [10.32.249.197] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id c4sm4856901wre.57.2017.10.16.21.49.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 21:49:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git for Windows 2.14.2(3)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CACbrTHcwjGLudp7WQta2bs_kitquj562rLqo8LAmRF5+d_RE=Q@mail.gmail.com>
Date:   Tue, 17 Oct 2017 06:49:39 +0200
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <92D3AAC1-1775-4BF0-9DD6-810819C01AE8@gmail.com>
References: <20171012225339.2808-1-johannes.schindelin@gmx.de> <CACbrTHfnph8Cp9G7LrspPa4s-E2ATHWkLqj7WDPFSiLXzOSz7g@mail.gmail.com> <alpine.DEB.2.21.1.1710151710340.40514@virtualbox> <alpine.DEB.2.21.1.1710161254430.40514@virtualbox> <CACbrTHcwjGLudp7WQta2bs_kitquj562rLqo8LAmRF5+d_RE=Q@mail.gmail.com>
To:     Steve Hoelzer <shoelzer@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Oct 2017, at 20:59, Steve Hoelzer <shoelzer@gmail.com> wrote:
> 
> Johannes,
> 
> On Mon, Oct 16, 2017 at 5:57 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Steve,
>> 
>> On Sun, 15 Oct 2017, Johannes Schindelin wrote:
>> 
>>> On Fri, 13 Oct 2017, Steve Hoelzer wrote:
>>> 
>>>> On Thu, Oct 12, 2017 at 5:53 PM, Johannes Schindelin
>>>> <johannes.schindelin@gmx.de> wrote:
>>>>> 
>>>>> It is my pleasure to announce that Git for Windows 2.14.2(3) is
>>>>> available from:
>>>>> 
>>>>>        https://git-for-windows.github.io/
>>>>> 
>>>>> Changes since Git for Windows v2.14.2(2) (October 5th 2017)
>>>>> 
>>>>> New Features
>>>>> 
>>>>>  * Comes with Git LFS v2.3.3.
>>>> 
>>>> I just ran "git update" and afterward "git version" reported
>>>> 2.14.2(3), but "git lfs version" still said 2.3.2.
>>>> 
>>>> I also uninstalled/reinstalled Git for Windows and LFS is still 2.3.2.
>>> 
>>> Ah bummer. I forgot to actually update it in the VM where I build the
>>> releases :-(
>>> 
>>> Will work on it tomorrow.
>> 
>> I'll actually use this opportunity to revamp a part of Git for Windows'
>> release engineering process to try to prevent similar things from
>> happening in the future.
>> 
>> Also, cURL v7.56.1 is slated to be released in exactly one week, and I
>> have some important installer work to do this week, so I'll just defer the
>> new Git for Windows version tentatively to Monday, 23rd.
>> 
>> Git LFS users can always install Git LFS v2.3.3 specifically in the
>> meantime, or use Git for Windows' snapshot versions
>> (https://wingit.blob.core.windows.net/files/index.html).
> 
> Sounds like a good plan.
> 
> I think I have successfully updated to LFS 2.3.3 by copying the new
> git-lfs.exe into C:\Program Files\Git\mingw64\bin. Is that right way
> to do it?

That's how I do it and that's how the Git LFS installer will (hopefully)
do it in the future, too: https://github.com/git-lfs/git-lfs/issues/2587

- Lars

