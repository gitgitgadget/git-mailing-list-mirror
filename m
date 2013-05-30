From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Thu, 30 May 2013 15:26:18 +0530
Message-ID: <CALkWK0nnFjTASAMA5pZa2=epK9HwSYY7U_S8SKOoiMAf-NovTA@mail.gmail.com>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <87bo7slrz1.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 11:57:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhzbV-00030J-S2
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 11:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968052Ab3E3J5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 05:57:01 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65372 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967560Ab3E3J5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 05:57:00 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc10so29237bkc.0
        for <git@vger.kernel.org>; Thu, 30 May 2013 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VDIOYBh4KAPIaff74kfGTYut49yAcAUDQq+Ps3NPKvc=;
        b=PVlnT2DWGYtPp5cIV07zRPPV0p2Pavdok9niyYDSqayl/Hognhnp3edix8xOA2LqIJ
         0iK7l9mIekumBo4wKcxUtcmtJ1MmitkRIegqjvZXi6PBkVXxXrRTRXYVq7iAFktrk4rk
         9hXEAtne972FY2nanRNUJWcgPB3RElbIJnSxymQIDXggeSUCk9ekPsXsnGbMGeJna9lc
         ryZ188vPv09UldH6jLVfA2tTg32Z3Xq6g1T6VJcoLCQM9Zh2vKdjy3PMGJAov+JBzHoc
         5C0mFXLHh6ZgeRvKOlPOdbCzOg8ODq12Lp9RpWm1rP2pHMTvulH5+fBz33SLWvMWTvDf
         50rw==
X-Received: by 10.204.109.200 with SMTP id k8mr1592210bkp.82.1369907818722;
 Thu, 30 May 2013 02:56:58 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 02:56:18 -0700 (PDT)
In-Reply-To: <87bo7slrz1.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225951>

Thomas Rast wrote:
> diff --git i/sha1_name.c w/sha1_name.c
> index 5ea16ff..a07558d 100644
> --- i/sha1_name.c
> +++ w/sha1_name.c
> @@ -538,7 +538,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>                                         "back to %s.", len, str,
>                                         show_date(co_time, co_tz, DATE_RFC2822));
>                         else {
> -                               free(real_ref);
>                                 die("Log for '%.*s' only has %d entries.",
>                                     len, str, co_cnt);
>                         }

Ah, good catch.  Thanks.

Sorry I didn't notice this while writing the patch.
