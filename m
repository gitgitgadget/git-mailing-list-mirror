From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 16:00:32 -0500
Message-ID: <CAMP44s3F2npFuXDS-wpAP+TqHiGBPJfFYK4LohTg_Z4Ta4yoeQ@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
	<CAMP44s2SaKe7F-3H=b3ZBgDPDT+TrVPUBLrXg0XDY7n5ppdS0Q@mail.gmail.com>
	<CALkWK0n5ASBvS_swZ3fj11Utt0XKPgpk-V--=gYVaWVi=O2N2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 23:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpl1-0001Mh-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab3DZVAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:00:35 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:51068 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3DZVAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:00:34 -0400
Received: by mail-lb0-f169.google.com with SMTP id p10so256578lbi.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iaEK8F+Vh9PZAOlO7TRVUiSJ8sA5TPX+uTjlY3B0hOk=;
        b=TW8FEJmX+CDMOlXs1XiHEvyjClKf2HX0pylqCxcCco5G86e2CVf5zEswHOZUmz0H/U
         r4Zn3tGv7O2E7brwfxpM4lHQkoXfk7ZUm2bAKjd0daZ7a7btD3U0V0hBfK015/TKSfja
         4p6seaJOQhwZIOUniGPN8yUd3IPkGxiaDixEfryxHLyFaedupfntZAKk0So213I+P4Y3
         7WV6y4wDrJMr6dEEZOni6K6hfuVw6MOn5bw9yIBBaxl9O+mAFKu/gh6DbpxalSfRdRJR
         +8kTwmAylosGXvz4IjipWgktqBmevOvs4DEpwgmjXW6aWeMlMsIEkIPxh99T6J+9LNXu
         lmLw==
X-Received: by 10.112.22.198 with SMTP id g6mr18649089lbf.135.1367010032663;
 Fri, 26 Apr 2013 14:00:32 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 14:00:32 -0700 (PDT)
In-Reply-To: <CALkWK0n5ASBvS_swZ3fj11Utt0XKPgpk-V--=gYVaWVi=O2N2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222580>

On Fri, Apr 26, 2013 at 3:17 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> The importance of users changes all the time. The 15 year old kid in
>> Sao Paulo might not be important today, but he might be the single
>> most important contributor ten years from now. Hell, he might even
>> replace Junio as the maintainer.
>
> Yes, they do.  Did I say that they don't change?

But you implied we shouldn't care about Thiago (our hypothetical
future overlord), because he is among the users we should't care for
(right now).

>> Should we willingly and knowingly neglect some git user-base? No, why
>> would you want them to fork? In a way, git's UI has been so bad, that
>> some kind-of-forks have happened, that tells us something; the UI
>> needs some love, fortunately none of those forks worked, which tells
>> us something too; it's not too atrocious.
>
> No, we should never neglect.  I believe in including everyone.  In
> fact I take it to an extreme: on many instances, I have pointed out
> what I want specifically, and asked for a configuration option if it's
> not necessarily a sane default.  Git is a toolkit, and should be
> loaded with features that even a few users want.
>
>> That's not to say we shouldn't fix the UI, we should, in a way that
>> everyone's happy, which is hard, but we will do it, eventually.
>
> On this, I think the way forward is complete-implicit'ness via
> configuration variables.  I recently wrote remote.pushdefault to
> simply 'git push', and proposed 'git push +ref1 ref2 ref3' to
> automatically push to the correct pushdefaults (but that proposal was
> rejected).

Indeed, I learned about that, and I tried to use it, but I think
there's a lot that is missing, and I don't know myself what would be
ideal. I'm starting to think that a branch should have two upstreams;
one that is used for rebasing, and another that is used for pushing.
But I'm not sure.

Eventually, I would like to do 'git push' and I would push different
branches to different repositories in different destination branches
in a way that requires multiple commands right now 'git push github
fc/remote-old/hg:fc/remote/hg', 'git push --prune backup
refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*'. And to figure
things out I'm also helping; I added the --prune option to push, and I
added color to visualize upstream branches in 'git branch'.

But I don't think any of those are as important as having a proper
'git stage' command, and getting rid of --cached and --index, which
will be a huge effort, but would pay even bigger dividends. Step by
step.

Cheers.

-- 
Felipe Contreras
