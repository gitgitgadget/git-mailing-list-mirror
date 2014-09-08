From: Junio C Hamano <junio@pobox.com>
Subject: Re: My GSoC2014 retrospective
Date: Mon, 8 Sep 2014 14:16:46 -0700
Message-ID: <CAPc5daU-1WWFWJkq=rsFU7bPJnn22QTb-ADz_ehMTAcCyJ7CyA@mail.gmail.com>
References: <vpqsik1yg1l.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:25:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR6JF-0002ly-OS
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbaIHVRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 17:17:09 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:57211 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbaIHVRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 17:17:07 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so6809027lam.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bKCDA3iCMO4CplaoxLMvuw9Kt8kbzDQGVlon/zS1GMY=;
        b=IRgrVDEWeHW6z8L5AqRbitzL2bN6VQHAniQqNzRZsdhQsloftYumM6P7K95f14iQln
         TTS3hWU3602/O3xPUUcdU7Nx58Vjq9N1r3r31VNwCAC10RMqAZUc0xvlxYRvnydS4+Ox
         QW4B1m8EXtSM3ler+84orDEMFQ7kNVLv6rxBkereygmYu2TL00P51IgvDg61qSJf6VFI
         aCzXA7hS0KOnso165kgZ5S1Ut4CM/nOGSQvnIeOUBptFpg1m2zDQa4hLWy/6+zuFxW1Q
         X6Q0aWC3xPPS7MWQBUoRgGM7UANi+d1jO55o5T1SgxZX1lRfJw5X3hNwv7c7hCVxQ9h0
         xujw==
X-Received: by 10.153.11.132 with SMTP id ei4mr23940753lad.24.1410211026201;
 Mon, 08 Sep 2014 14:17:06 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Mon, 8 Sep 2014 14:16:46 -0700 (PDT)
In-Reply-To: <vpqsik1yg1l.fsf@anie.imag.fr>
X-Google-Sender-Auth: eaO9oBUexwhvtEWrHI_5FPL3qgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256677>

Thanks for a write-up. FWIW, I also did enjoy interacting with your student.

On Mon, Sep 8, 2014 at 2:10 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> So, GSoC 2014 is over, and it's time for me for a retrospective too.
>
> As a reminder, Git participated in GSoC a number of times, but we were
> not happy enough with how it went and did not apply in 2013. This year,
> we thought we would hopefuly be better at mentoring students, and gave
> one more try. It was my first experience as a GSoC mentor, although I
> supervised students my engineering school contributing to Git as a
> school project several times.
>
> On overall, Git selected 3 students, one of them did not send anything
> to the list and failed the mid-term. Fabian worked on rebase -i
> improvements, send several versions of his patch series, but the code
> did not reach pu (yet?). I mentored Tanay, who worked on git_config
> improvements with the help of Ram. As Tanay wrote in his retrospective
> [1], there's a reasonable amount of code merged (next or pu). All the
> objectives of the project have not been reached, but I still consider it
> as a relative success. I prefer by far having this situation than having
> everything half-done and nothing merged.
>
>   [1] http://permalink.gmane.org/gmane.comp.version-control.git/256458
>
> I think the following contributed to this (I'll talk about my
> experience, don't try to see a comparison with others or any
> over-generalization):
>
> Microprojects
> -------------
>
> Microprojects were a really, really good idea. Far better than selecting
> students only based on their proposal on melange and a superficial
> discussions in the comments below the proposals. And not only for
> selection: students learnt the contents of SubmittingPatches before
> starting the project, so that was one less thing for me to teach as a
> mentor, and less opportunities for mistakes in the first iterations.
>
> On-list interaction
> -------------------
>
> According to my email archives, there are 106 threads where I sent an
> email to Tanay, 83 of which happened on-list (and 64 are followups to a
> PATCH). The off-list exchanges were essentially quick reviews of draft
> series, and short messages to give an advice.
>
> I think its very important to have this on-list interaction for many
> reasons. It's good, make sure everybody has an opportunity to give his
> or her opinion about the project soon (as a mentor, I can obviously be
> wrong, and the sooner someone notices it, the less time lost). It's good
> for the student, because GSoC is all about interacting with a community,
> not just with a mentor. And, well, it has to be good because this is
> how we usually work here.
>
> OTOH, we should probably have exchanged a few emails in private between
> GSoC mentors and admin. I wasn't really aware of what other students
> were doing except what they sent to the list, and it could have helped
> to know a bit more about how others were doing.
>
> Also, I insisted with Tanay that he should introduce himself on the
> list, and remind people that he was working as a GSoC student when he
> sent his first patch. I realized how much this was important when I
> discovered in a private conversation that Junio did not know that
> Fabian's series was sent as a GSoC project. While I don't think "I'm
> sending this patch as part of my GSoC" should be equivalent to "please,
> merge this even if the code is not good, I'm still a student after all",
> I think is helps reviewers to know about GSoC, if only to better advise
> the student.
>
> Code merged ASAP
> ----------------
>
> I think Tanay and I did a good job at getting some code merged early. We
> did bother Junio a bit with series depending on each other, but we could
> send code by relatively small series, and prioritized "finish first
> series" over "start new ones". Of course, reviews take time, so we still
> had several series in parallel, but splitting the work like this allowed
> some code to reach master early, while part of the work is still
> unfinished.
>
> We all hope that GSoC students will remain part of the community, and
> it's tempting to think that unfinished code isn't a problem because we
> will have time to finish it later, but I think it's risky. My motto for
> this kind of projects (I do the same with Ensimag students): hope that
> students will keep contributing after the end, but don't rely on it.
>
> Mentoring takes time
> --------------------
>
> I knew it (and actually, I was initially reluctant to be a mentor for
> this reason), but I did enjoy the experience and happily spent a lot of
> time and energy on it.
>
> Most series needed many iterations, and we couldn't have reached the
> quality required to get in git.git without fast and detailed reviews. I
> did my best to review the code ASAP when a series was sent, and
> fortunately the list, and Junio in particular, was very supportive.
> Thanks a lot to everybody who contributed!
>
> Still, I think it should have taken less iterations to get the final
> result. But I do not know what we could have done better for that.
>
> In the end ...
> --------------
>
> My goals with the GSoC were essentially (unordered):
>
> * Teach cool stuff to a student (for those who missed it, I'm a teacher
>   in another life ^^)
>
> * Get useful code in git.git
>
> * Attract new long-term contributors
>
> * Have fun
>
> I think each of them is satisfied. The future will tell us if the third
> one is actually reached, but Tanay's motivation was also to start
> contributing on a regalar basis, and I hope we all motivated him to do
> so!
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
