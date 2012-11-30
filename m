From: viresh kumar <viresh.kumar@linaro.org>
Subject: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 07:39:03 +0530
Message-ID: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:16:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeG9A-0007bH-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 03:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2K3CPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 21:15:53 -0500
Received: from mail-vb0-f52.google.com ([209.85.212.52]:50912 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab2K3CPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 21:15:52 -0500
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2012 21:15:52 EST
Received: by mail-vb0-f52.google.com with SMTP id ez10so12370452vbb.11
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=Qp5LZAI/X1LE26MdCiyK68UjLGXViucS3vWl/MpYqwM=;
        b=cFHQG5sE/toiT+DC9ldRi74M3OFTfSvDjvgnSRak/qaxmNcx1WJRUisbeqEsXLblFp
         IoefHR3YfrG+Amlk0+Mo/KRPQ/v5683J+Bix1tL+XV28IDieHTpvtU9m8vsNEFqqxP/i
         GG7dxfUgwsSssQ4VVOZUtElfF5stxtjym4Vk9s5yjkc/ePUsqDkNJHrdFIQlf/aFz86/
         KQgsBt0ZOf203ja8NhC3j2lR9YTnRmMLbhImH+OO1CxXzwRP0R0kppbX9uEW4QEXJJNd
         7uQ/hCcVtR/GVkRYxscFOnWJFTBj/GfOeaocDas7Lry9cDtep25q6OaVgj+KuNBDmJwD
         fhQg==
Received: by 10.220.107.146 with SMTP id b18mr33261382vcp.48.1354241343477;
 Thu, 29 Nov 2012 18:09:03 -0800 (PST)
Received: by 10.221.7.4 with HTTP; Thu, 29 Nov 2012 18:09:03 -0800 (PST)
X-Google-Sender-Auth: _EMhkL4r0ZPOaMRcw2o_KqnkyGk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210898>

Hi Junio and others,

I have a query. git shortlog lists the patches submitted per commiter, like:

> Viresh Kumar (7):
>       cpufreq: Improve debug prints
>       cpufreq: return early from __cpufreq_driver_getavg()
>       cpufreq: governors: remove redundant code
>       cpufreq: Fix sparse warnings by updating cputime64_t to u64
>       cpufreq: Fix sparse warning by making local function static
>       cpufreq: Avoid calling cpufreq driver's target() routine if target_freq == policy->cur
>       cpufreq: Make sure target freq is within limits

> viresh kumar (3):
>       cpufreq / core: Fix typo in comment describing show_bios_limit()
>       cpufreq / core: Fix printing of governor and driver name
>       cpufreq: Move common part from governors to separate file, v2

I know, there was something wrong at my end and i have commited stuff
with different cases.

I was just thinking if we can ignore case for commiter name while
listing stuff here?
So, that we get over any manual mistakes from commiter.

--
viresh
