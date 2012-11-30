From: David Aguilar <davvid@gmail.com>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Thu, 29 Nov 2012 19:24:26 -0800
Message-ID: <CAJDDKr7yr2JSutcEy1mz-SfMq8ZdNzR3+s++ooenn5+wD-LDAw@mail.gmail.com>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 04:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeHJW-0004YD-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 04:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab2K3Daj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 22:30:39 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:46126 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2K3Dai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 22:30:38 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2012 22:30:38 EST
Received: by mail-vc0-f179.google.com with SMTP id p1so10675892vcq.10
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 19:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4QOrr3zHexjjgazgjBpAYmfUPAFj8YB1eJBmp+iYxvs=;
        b=dDmp/iuZY2XiyqSjEfF93pLk/+l0g4QEyTok8bhW+Nptli/5bklSAPl/z7ajuo+q7Y
         wuFEwIWw9cryTjZDTwbXJ0MWFi0tEnnysXeax4M0eXfTRRh11+hHyZQfdbQh4LHJhfTH
         JoXZt6ylJhGW/GekLPLOuvWd+FpRbLrKoYSJOoGprgm6KT0wwHPwsLUcal3LQHOcnsUu
         Br4bv0sMOsKkhro4rkq4+kQqyeqsEwB34skbQb6XH1uJIvenshJr+ArtOWvCPLrU63BC
         3UzuBkNhONtDrK9ertSs7hUczGlDxsIdkYrNxLJE+p3WrkJ6ocYQWUVSS/IoFuvyRPgH
         C+fQ==
Received: by 10.220.148.134 with SMTP id p6mr33304461vcv.3.1354245866120; Thu,
 29 Nov 2012 19:24:26 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Thu, 29 Nov 2012 19:24:26 -0800 (PST)
In-Reply-To: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2012 at 6:09 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> Hi Junio and others,
>
> I have a query. git shortlog lists the patches submitted per commiter, like:
>
>> Viresh Kumar (7):
>>       cpufreq: Improve debug prints
>>       cpufreq: return early from __cpufreq_driver_getavg()
>>       cpufreq: governors: remove redundant code
>>       cpufreq: Fix sparse warnings by updating cputime64_t to u64
>>       cpufreq: Fix sparse warning by making local function static
>>       cpufreq: Avoid calling cpufreq driver's target() routine if target_freq == policy->cur
>>       cpufreq: Make sure target freq is within limits
>
>> viresh kumar (3):
>>       cpufreq / core: Fix typo in comment describing show_bios_limit()
>>       cpufreq / core: Fix printing of governor and driver name
>>       cpufreq: Move common part from governors to separate file, v2
>
> I know, there was something wrong at my end and i have commited stuff
> with different cases.
>
> I was just thinking if we can ignore case for commiter name while
> listing stuff here?
> So, that we get over any manual mistakes from commiter.

There's a feature that does exactly this.

http://www.kernel.org/pub/software/scm/git/docs/git-shortlog.html

See the section called "Mapping Authors".
It discusses the .mailmap file.
-- 
David
