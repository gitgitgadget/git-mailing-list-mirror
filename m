From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/5] mh: worktree-related doc fixes
Date: Thu, 23 Jul 2015 20:10:26 -0400
Message-ID: <CAPig+cRLZiLSrMDiPp9ZJ1RKELSEKqVc0K2h4CvnvXNk5t7aBw@mail.gmail.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
	<55AD146D.3080509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 24 02:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIQZM-0005dQ-1L
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 02:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbbGXAK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 20:10:28 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36415 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbGXAK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 20:10:26 -0400
Received: by ykay190 with SMTP id y190so7248000yka.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yCip7wAQhCCSrWbFkpjsE6JlXA8DvajR3Si1nX0Yxbo=;
        b=gzwK3vMHNfJL/+zREPR3Cw/fmGyBLqHWghA/U8qx4d/+1RONgvXvAOJhJJv3PZLAn+
         VIBVTCzi9GV09i5W+y7LblCLk+yfiG2xKDlFODgjOmmKqjGkECkhR2hCr4kvApJLLm+1
         9/vA39+SA2ftS9RVGTpDEiZhhS+VXjRI+htXtSfMhpuAGIVzPUoaI4NvpWzbQ4gX4aVQ
         ZfauMpWOFbS7k560y/Th5nH3rzIZGm1Q9otL+KvkcQ7tBRBPT7Pe6UxeOQfRSd2sxO2Z
         0MxYQma9bxPbckngJfuSbfGtf7R6IWM7YtXWcycri5eFglVxTZIh4dBKO4desawuGv1+
         Nx7g==
X-Received: by 10.129.76.140 with SMTP id z134mr12200738ywa.17.1437696626379;
 Thu, 23 Jul 2015 17:10:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 23 Jul 2015 17:10:26 -0700 (PDT)
In-Reply-To: <55AD146D.3080509@alum.mit.edu>
X-Google-Sender-Auth: 9jO5NxEAgjiWratTEFt8HK7jLvM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274532>

On Mon, Jul 20, 2015 at 11:31 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 07/19/2015 10:29 PM, Eric Sunshine wrote:
>> This re-roll of Michael Haggerty's worktree-related documentation
>> tweaks[1] takes my review comments into account and adds one new patch.
>
> Thanks for separating the wheat from the chaff. I'm still traveling,
> which I'll claim as an excuse for my poor responsiveness.
>
> All of your changes look good.
>
> I was wondering one thing: is there a value like "never" or "false" to
> which "gc.worktreepruneexpire" can be set to turn off pruning entirely?
> If so, it might be nice to mention it in the config manpage. Similarly
> for the other expiration grace time settings.
> But it's definitely not a blocker.

I browsed the code for the various "expire" settings, and it appears
that they all accept and respect "now" and "never", as well, so I'll
put together a patch as suggested.
