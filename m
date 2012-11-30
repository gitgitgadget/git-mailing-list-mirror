From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Thu, 29 Nov 2012 22:33:56 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1211292231520.4576@xanadu.home>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 04:34:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeHMm-00084h-JK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 04:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab2K3DeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 22:34:00 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48355 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2K3Dd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 22:33:59 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so31910qcr.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 19:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=6oG8OeQfBgdHv7/QS7UKPnQ+cxngByvTGUMlwwbT5tc=;
        b=JkmWdDJ/3Th4ri7XdqSmtQDDOAzZBoe72Q0cCXlbxvfUiTX9UXqKF8z399S9zRMqmw
         98WR7AC62/5jgcET+uBEjrVQKUDyjA2MrMdEy2A2PS9DLrXBJMwXxOcvfB/duV/lycsk
         aIz/gVCA+tET7m9tzwbQmNRtamDrbXXfcvsaA2w9jEt6H8VLGWhOmdiFpcBI+nUeFLUv
         ZeZB57K3MA6nBE3sun6l3EbfZwNAzOPvUEbvIP4mw0SymQmMzH9Q4S28dajRHp42A5kv
         Kl1FXuKOa0+MEke5TCvMn9XRLsvr+8l6adFPj+ACCup0wkiuRS1WqYdsJ6xTwMF6jsJ7
         nOmw==
Received: by 10.224.52.147 with SMTP id i19mr926620qag.61.1354246438723;
        Thu, 29 Nov 2012 19:33:58 -0800 (PST)
Received: from xanadu.home (modemcable203.213-202-24.mc.videotron.ca. [24.202.213.203])
        by mx.google.com with ESMTPS id em3sm2215379qab.12.2012.11.29.19.33.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 19:33:58 -0800 (PST)
In-Reply-To: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
X-Gm-Message-State: ALoCoQkZwsRgv7xoOhw5vPAqMaJMuZf9RnEonk1fVbdB1Az9fPHhlEsHRU3ernaaxgNHLFP1p9F5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Nov 2012, viresh kumar wrote:

> Hi Junio and others,
> 
> I have a query. git shortlog lists the patches submitted per commiter, like:
> 
> > Viresh Kumar (7):
> >       cpufreq: Improve debug prints
> >       cpufreq: return early from __cpufreq_driver_getavg()
> >       cpufreq: governors: remove redundant code
> >       cpufreq: Fix sparse warnings by updating cputime64_t to u64
> >       cpufreq: Fix sparse warning by making local function static
> >       cpufreq: Avoid calling cpufreq driver's target() routine if target_freq == policy->cur
> >       cpufreq: Make sure target freq is within limits
> 
> > viresh kumar (3):
> >       cpufreq / core: Fix typo in comment describing show_bios_limit()
> >       cpufreq / core: Fix printing of governor and driver name
> >       cpufreq: Move common part from governors to separate file, v2
> 
> I know, there was something wrong at my end and i have commited stuff
> with different cases.
> 
> I was just thinking if we can ignore case for commiter name while
> listing stuff here?
> So, that we get over any manual mistakes from commiter.

Have a look at the .mailmap file in the top directory of your repo.


Nicolas
