From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 12:22:10 -0500
Message-ID: <535e8e4253196_45651483310b3@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:15:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer18-0003SK-Es
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbaD1TMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:12:12 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:54153 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbaD1TMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:12:07 -0400
Received: by mail-oa0-f42.google.com with SMTP id i7so86814oag.29
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=z3tUUlr1FPsXMITOmLOZi6PJa3nZgpGQ1u/bdO7tOMs=;
        b=QIee3npUGVbjxxowBP7R/6d62hk+1nXtoYiheUacLyL52u08uheYDAtasIhBvWKMsA
         RcV3dFcWCaKaK9RTYwPx8RUfnlLHHPna0xUnu/2cIPT3b1guc1qsxD9X5fpxmYIZGv9O
         jOTPRP5P9XZ024KFuceGrh4GCxKuTJnNENnyJZHwkB3oNtTsu/pFKZGLmo0g1z+cQpYd
         ikEVFs87jole1fVj70qmeJ+xJ0tvFlEUWwXA9F+UKnp1ExEOhS2RQl1kWthO3Trt/Ov8
         LB1Arnp0AB1pGkqp1Wliu/+aDcWVWkMUoJPmZ7zQ5M3oBveS1eHrXnteNtSY4dLiwPCQ
         GyDQ==
X-Received: by 10.182.38.199 with SMTP id i7mr2302861obk.68.1398706365942;
        Mon, 28 Apr 2014 10:32:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm38039897obm.2.2014.04.28.10.32.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 10:32:44 -0700 (PDT)
In-Reply-To: <87bnvl6bdg.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247391>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Jeremy Morton wrote:
> >> 
> >> Sounds like the default behaviour of "git pull" might not be ideal if
> >> it easily causes these problems.
> >
> > It's not idea. Virtually everyone agrees with that, even Linus
> > Torvalds, and we have the patches to fix it, but it's not going to
> > change.
> >
> > The Git project doesn't welcome change.
> 
> I can think of a few other things that "the Git project" or actually
> pretty much everybody doesn't welcome.
> 
> It becomes easier to actually change things when communicating in a less
> abrasive and destructive manner.

That would make sense if I was the only one with the itch. But I wasn't the
only one, so anybody could take the patches and send them in a less abrasive
maner.

In fact I have been contacted a couple of times privately suggesting me to use
a softer tone in order to get my patches applied, in every time I issue a
challenge. You send the patches, and you follow up the discussion in whatever
tone you see fit, if they get in, I'll accept I'm wrong and use softer tone in
the future. The fact of the matter is that the tone doesn't matter, the patches
don't get in because change is not welcome. Period.

> But it hasn't, and such a change is no longer in a useful time frame for
> a 2.0 release.

I sent the last version of the series in Octoboer 2013, there was more than
enough time to merge them, or somebody else with more political traction to
pick and finish whatever changes where needed (none).

> Unless one wants to push back the 2.0 release considerably for this alone.

Why does it need to be pushed back? Have you looked at the patches? If so, what
is the risk that there will be any problem with them?

> I mean, I just sped up git-blame for serious use cases by a factor of 3 or so
> at least, and there will be _no_ API changes and user-visible consequences
> with that change.

I bet this could get into 2.0, but the big patch has to be split into smaller
patches in order for them to be reviewed properly, and maybe merge a few of
them at a time.

> If the thing has been important enough to get into 2.0, it has been
> important enough to push for it _timely_ so that it had a chance at
> considerable testing exposure.

Really? What important changes does 2.0 have? There's literally nothing of
interest to most users, maybe push.default = simple, but that's it.

-- 
Felipe Contreras
