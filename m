From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: Re: Reference to a commit inside a commit message
Date: Wed, 30 Apr 2014 20:29:38 +0200
Message-ID: <CAKOJyXduybjMEvkw6e2LijTa553mEPqe2_ELfVy_QZ5kc=RrRg@mail.gmail.com>
References: <20140428183552.GA9709@workstation.Belkin>
	<20140429034128.GD11979@sigill.intra.peff.net>
	<535f5b6a41ff6_45e485b3087b@nysa.notmuch>
	<CAKOJyXfHKwRXA==M2TaPNT-ZwLPF8YQeEoBoxbe-s6Q+UQgL0Q@mail.gmail.com>
	<CAP8UFD1q2zdJZVkJVsNtGfN35LFmuK5txd91nTak5kGmvvKdWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:29:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZGL-0002cI-6k
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759034AbaD3S3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:29:40 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:61824 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaD3S3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:29:39 -0400
Received: by mail-vc0-f182.google.com with SMTP id lf12so2798289vcb.27
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8FkSW3jnj2RiSfbFvjrz70ddepsw+vM+0p/aVrilLr8=;
        b=GmtF3ME/hvf4/uVzW93K90yWh8dPnnXZpR2WhtCvdrFetem79rpArGOq69FYHDvzJh
         KtD6V8nsbTeyclJOyRMSCFpAwrtn6ZXzZjwDV/cDY0nM/JHnJr1FezoEGt5WSnx/5AxU
         CLUBfyrBuKKDbmBBs38DLfSDD5ZWplE/0cPf9ll2sYnVVTKlInJPlEji4PoNgEMavXBc
         5VdwuUhYZDjam764GioVtdaLrV2XofiIochBADyWnehmAzp32l+GRD1MdDRPqtkqwA2w
         TteOeJADbcEI4eqRb4QkYJpaHp5R8z5X77yJU0HE4p0ltNvqASmpieKb6cNwSCUY0G/G
         thqw==
X-Received: by 10.58.211.69 with SMTP id na5mr2586177vec.30.1398882578799;
 Wed, 30 Apr 2014 11:29:38 -0700 (PDT)
Received: by 10.220.177.198 with HTTP; Wed, 30 Apr 2014 11:29:38 -0700 (PDT)
In-Reply-To: <CAP8UFD1q2zdJZVkJVsNtGfN35LFmuK5txd91nTak5kGmvvKdWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247753>

> You should use the latest version of the patch series (v11), because the
> blank line is now automatically added.

Yes interpret-trailers add the blank line, but when call `git commit
-m "$MSG" -e` it isn't displayed.
I think this happens due to the default value of 'cleanup' option of
git-commit that is 'strip' (in my case) when the message is edited.
I can't use neither 'verbatim' nor 'whitespace' otherwise all the
comments will be displayed.

> And using ':' instead of '=' after "see-also" would be more standard.

Thanks I've updated my script and now I'm using the latest interpret-trailers.

NaN
