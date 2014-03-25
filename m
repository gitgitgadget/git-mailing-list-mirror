From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 001/144] check-builtins.sh: use the $( ... ) construct for
 command substitution
Date: Tue, 25 Mar 2014 11:03:42 +0100
Message-ID: <CA+EOSBnzcBA433-HwmnRh4Xefh54NLg8e+bYhx5K8j9j5RvmSQ@mail.gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-2-git-send-email-gitter.spiros@gmail.com>
	<vpqa9ce7k1x.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSOCy-0000DO-1s
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 11:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbaCYKDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 06:03:44 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:56588 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaCYKDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 06:03:43 -0400
Received: by mail-vc0-f172.google.com with SMTP id la4so253800vcb.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1nmRLKqLUznSj/R3GamuRqnan3oQOCEX71cCMmXFsVM=;
        b=mhvT6Epdp3attoTSdTJC696Wp7L+pmv4JVFAzlJk+VBmgkx2wW9K7e/mWFDJPsFMGk
         45050AKKUYZeKBmWoevzbnMp44AKM+UQNo88/eVfZPWGCrb1WRUZml5+LLtWOLlUYeEQ
         xpq65roVZMLQgkLR60e1gPE1VzJcJRdfTjVupfkocN1u7ZMcR/VWtgXU7djLfrY4eAGz
         Pje5jTwXRI03bJeJTCqwRmXpzdYTvxFIJ36WV7aVcrbyTS3ftflk+X8Dj4xhU72DGJsc
         8GPKzmVL6WplZ9/72Wc0V3rBDbj9gmR1a0s6D+YSnnKVI0GnHNxRPXIKEdLcgzhORA3Q
         gnCA==
X-Received: by 10.52.251.199 with SMTP id zm7mr47152187vdc.21.1395741822793;
 Tue, 25 Mar 2014 03:03:42 -0700 (PDT)
Received: by 10.52.15.33 with HTTP; Tue, 25 Mar 2014 03:03:42 -0700 (PDT)
In-Reply-To: <vpqa9ce7k1x.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245025>

2014-03-25 9:35 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> and is supported by POSIX. However,all but the simplest uses become
>
> Missing space after comma.
>
>> complicated quickly. In particular,embedded command substitutions
>
> Ditto.
>
> (neither should block merging, but they would be worth fixing if you
> need a reroll)
>
> Did you do these 144 patches by hand, or did you use a script (e.g. perl
> substitution or so) to do it? If the later, then you should include
> explanations in your commit message.

I had used a toy sed script. No bulletproof.  Then I did a manual review.

I review the patch series, adjust the comment was added, and resend the V2.

Thanks again
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
