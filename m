From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 07:05:58 -0500
Message-ID: <CAMP44s2Vc0b-DBnExFCwfZX2a5om5z_NasBFZNTRfuPte75hXg@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
	<CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
	<CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
	<CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
	<CALkWK0nOp_w1LXnN9SoAS9zvhwb5W37csx42KKau5aYCqdwTkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 14:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USnbL-0002E4-27
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 14:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967182Ab3DRMGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 08:06:01 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36808 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966969Ab3DRMGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 08:06:00 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so2423087lab.23
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9XntVoHAq487nZTFxBULHFs0O3T3kiHjLXSPWQYhISI=;
        b=yJXEW9pQj41pgZMsr2AEi0rX/Hf3ycx7ht6Dp/TlPNv+HOmyTRAni5Jr8rCMmrPk2+
         UnoYvm1JKE6tt6jA0lEVSX9yGBJZty0NM+ZpYsYdnW9sy2o4kJkY3E3f+l0Xr6He0T78
         078vd5jq2bu+rPKiEFahVdlmekvMb1VfpXRrzEoicUj0hYULKvJx+R8e18oqckVQ/Xo7
         fjltoKVaffFaAXpgfOJVAA8/3JJZoHKpiH+s24ZBsTiTzxKM/2DlTuKuUNgDrl4Rymuf
         Zl0A28nEOhkCkcou8xzA5nMh6AkvTgMB31fhRYZbHLOXFzrqzcKydRYXg7e0G5sgARNv
         Wkvw==
X-Received: by 10.152.120.6 with SMTP id ky6mr5691349lab.19.1366286758697;
 Thu, 18 Apr 2013 05:05:58 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 05:05:58 -0700 (PDT)
In-Reply-To: <CALkWK0nOp_w1LXnN9SoAS9zvhwb5W37csx42KKau5aYCqdwTkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221654>

On Thu, Apr 18, 2013 at 6:31 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Since you disagreed with the rest, I'll only respond to this part:
>
> Felipe Contreras wrote:
>> But I won't bother trying to convince you that no project is more
>> important than its users (in the words of Linus Torvalds), because
>> most people don't see the big picture.
>
> I didn't say otherwise.  What I'm saying is: my personal incentive to
> write code does not prioritize the supposed benefit of some unknown
> "user" somewhere on the planet above everything else.  My personal
> incentive prioritizes me, and my immediate circle (ie. the git
> community).  The benefit propagates outwards to extended circles until
> it reaches the people I care least about: incidental end-users.

If the people that matter most are given the worst prioritization, it
means the prioritization is wrong.

> That's how people are connected: how can I care about distant unknown
> people I'm not connected to?

It's called empathy.

> The people in the outermost circles
> benefit the least, because they didn't get a say in the development.
> All they can do is write a rant about it on their blog, and hope that
> it gets fixed someday.

To the detriment of the project.

> You just ditched us, the inner circle of people who care about your
> work the most, and are instead trying to convince us that we're
> hurting some unknown hypothetical "users" by not merging your code
> immediately.

The users are real, the developers that will look retroatcively to the
commit message of this patch are not.

> If you think these users are more important to you than we are, then
> why are you posting your code on this mailing list?

What other way is there for this code to reach the users?

> Start your own
> project that's focused on satisfying these users.

Start a new project so I can include a patch that hasn't made it yet
into the "what's cooking" in one week? That's ridiculous.

> It doesn't even
> need to be open source or have a community of reviewers, because all
> you care about are users.

Who said *all* that matters are the users? And even if somebody did,
ultimately a closed source proprietary software doesn't benefit the
users, so either way it has to be open and active to benefit the
users.

-- 
Felipe Contreras
