From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 05/11] ref-filter: add parse_opt_merge_filter()
Date: Tue, 16 Jun 2015 22:00:20 +0530
Message-ID: <CAOLa=ZS_gY-MuGJ86TFpHhMXNYJ1gHWQWyfv71gDCVm1sMXZNw@mail.gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com> <1434464457-10749-5-git-send-email-karthik.188@gmail.com>
 <vpqmvzz7hjq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4tlI-0008LC-Is
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbbFPQaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:30:52 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34298 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbFPQau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:30:50 -0400
Received: by oigx81 with SMTP id x81so15321915oig.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hGi+0ckQw1h5KEgT7Hmlsks6XKsb/av3BclS11FOvfw=;
        b=TvZ4cbiTuDPX6ZeDb5CNlLd/z/ASwMyl0+xQfXEiaT95lHBkSq6V8zgeRvw+HmuyJ/
         yFFiIRjQukfNGINRyDXpf4bBy91VYfadJ18/zwgiDyvLkko7CJO7A+MQ9RPLrVcUeVK9
         7oeI802OBBUGXidwAT0pLIRReQOGkIZJlsKoNub3y2NbfGxq4kUy0xyeycbH4MdVT9qZ
         UIXACUoNzhRH+M9GAy/vwv0abUJybsgz+dx8pcyRTCbhTQNZVkJyrGrifL1EDubh2K1l
         qr2Akt+DP60YVJ6Yy7HM4UdEDhe9y+yy9fKKaHzJHJngulq6UlHj6id1ISOk/bjnkBdJ
         5hqQ==
X-Received: by 10.202.73.198 with SMTP id w189mr927766oia.102.1434472250395;
 Tue, 16 Jun 2015 09:30:50 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 16 Jun 2015 09:30:20 -0700 (PDT)
In-Reply-To: <vpqmvzz7hjq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271776>

On Tue, Jun 16, 2015 at 9:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is copied from 'builtin/branch.c' which will eventually be removed
>> when we port 'branch.c' to use ref-filter APIs.
>
> Earlier in the series you took code from tag.c.
>
> I think you should focus on either merge or tag, get a ref-filter-based
> replacement that passes the tests for it, and then consider the other.
> The fact that the test pass for a rewritten command is important to
> check the correctness of the these patches.
>
> I'm not asking you to remove commits from this series though. Just
> impatient to see one command fully replaced (actually, I see that you
> have more commits than you sent in your branch, so I guess it will come
> soon on the list) :-).
>

The idea is to currently get ref-filter to support all options and port it over
to for-each-ref which would be the first command to completely use ref-filter.

And like you said, the challenge is to then ensure tag.c and branch.c to use
ref-filter and make them pass all tests.

If you see my branch on Github, I have been pushing patches to port tag.c to
use ref-filter. I just finish porting tag.c to use ref-filter. Now to
include missing
options in it, then I'll push the series to the list. (Must be quite a
co-incidence
cause I just pushed a patch for tag.c to completely use ref-filter )

Like you mentioned tag.c and branch.c both have their own setup for which
small changes need to be made in ref-filter. So taking one step at a time, I'll
finish up with tag.c and end it with branch.c

-- 
Regards,
Karthik Nayak
