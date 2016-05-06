From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 6 May 2016 21:46:18 +0530
Message-ID: <CAFZEwPPkBcdupLktJ=ystnx_1y7Mv+U436Jn9JBUCrvkt+t8tQ@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<CACBZZX5ssO2EiuxR7wotGowMaPhtioaJVSDpQDUwUkv1rLJJWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiQS-0000sZ-J0
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171AbcEFQQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 12:16:21 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34633 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbcEFQQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:16:20 -0400
Received: by mail-yw0-f193.google.com with SMTP id i22so17394879ywc.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=F+5C3/mAJHlIe2VOPIHMmXn2eRHfSNEbJRcHT849AcM=;
        b=xK7l5qePaBoezqIwaaakdzTUox547rvzLg2flxRYHTPVJYuTJXcoW5Bv1Xrbn/r/bb
         EXJrA4xWo/2jiO8/MSf6uKydqWfaK+Q8QWd1KkF2Wfx4YK88R9il15z4J+A3iPfPKjn4
         IJoRl59KWeg9hq13ye9DBBX2K70Tul2P1yWaPGzmEI9yb0p113O/dmkjt7FsXWH0Wv0l
         ++JubX2xg/CnwyeNdjr8N51SF9VJYKf9XESMHvBTaBpoLTGXUIPYRC7UY3/WH9HFSRs2
         1wPGmO+vx/Efkjh4KvJ1hl+JGcvzvX4bw5auRIoGDSpyETJ2jpQN0Ivs6ZKBZ32RB+gb
         t6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=F+5C3/mAJHlIe2VOPIHMmXn2eRHfSNEbJRcHT849AcM=;
        b=mE3b2656SDe1q9YS4m4rXWHCtH72ct2+63Kso+BxBAiH9M6NSAZnw0wKdRrK6nvSX+
         RvxNzDHfc8PfFVjFkMu2/ODNio6j5z0bmf4TDXKnlStiaNvD4rJRsf8ZqGd624K0CitD
         4SUGHnA531R8OqkUszqyWGA7jeaVbTceraTtWW6f1sKCy//5+elQi29XNfWJzHvsKCfh
         tosEUuWmTV7oSHkoaseKMgK8zC3I/0mKI3vhBANRT9zBXH4nvX9LFdZQqa9hbfKxZNXK
         dSi12kUtPSPzAp7ZE4gQyfeu9/6O3G/JyLAxY8faHIvSopZlbr2vzpQ5Z95ps/carStC
         En7Q==
X-Gm-Message-State: AOPr4FUU7SR15cwQaJXmsuI2DdtSMmojYNEpCv6E9IV0Y59dVLvLWne+1fRvMj/xPhtneOT83he/rNYMAYyUPA==
X-Received: by 10.13.198.5 with SMTP id i5mr14374205ywd.263.1462551378726;
 Fri, 06 May 2016 09:16:18 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 6 May 2016 09:16:18 -0700 (PDT)
In-Reply-To: <CACBZZX5ssO2EiuxR7wotGowMaPhtioaJVSDpQDUwUkv1rLJJWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293826>

[+cc:git@vger.kernel.org] Because its an interesting fact to be shared
which isn't covered elsewhere.

On Fri, May 6, 2016 at 2:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Sending this privately since it's probably covered elsewhere. With
> this, if I set the option will "reword" in git rebase -i show me the
> patch?
>
> If so: awesome.

Yes, git rebase -i will show the diff in 'reword' if commit.verbose is
set to true or a value greater than 0.

I dug further in git-rebase--interactive.sh
I could find appearances of "git commit --amend" but I was unable to
find appearances of "COMMIT_EDITMSG". If COMMIT_EDITMSG was coming
into picture, the commit.verbose could not affect it. And that is not
the case.

I guess this would be a desirable trait for most of the consumers of
commit.verbose (like =C3=86var) so there would not be a need to suppres=
s.

Regards,
Pranit Bauva
