From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:47:27 +0530
Message-ID: <CALkWK0n5ASBvS_swZ3fj11Utt0XKPgpk-V--=gYVaWVi=O2N2A@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com> <CAMP44s2SaKe7F-3H=b3ZBgDPDT+TrVPUBLrXg0XDY7n5ppdS0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVp5y-000116-EO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab3DZUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:18:10 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34221 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab3DZUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:18:08 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so5233768iec.8
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=p/LDt/4f0r58FC1r9wK62Qjhc2lDGPjLLYWKeHZ73qE=;
        b=O4mUFl+K12I4Gg2N/LvqX7XO0UFOumJ2u/uAQh17AEt6vENK/mLL6JfZTZY5/fMFVa
         aNCJKdXVc35fk+f4aNIaTbS5WVJ4evND2eQ5VdizR66FEcybB/sWdFoX/Ff6NzzhpcF7
         PJbQ8pNL8F9c9i4EenGb4iSjQWJjjG462gvjKw1sgvC1P7vodMaMxf5iDQ7NVeKxfB0L
         LJqxGR3wjUvV+79gSc/qiyveppGtqv04lkldpuEMOLVXMR9KAW8pC65YgP84ljZJNcta
         MOhawQSM8Akw9j9Fjt/S2/aYfUK2dseNJPJUzJ2URTUFLy6ybaFL2a2hbkGr1T2ErUHt
         jxpQ==
X-Received: by 10.50.66.197 with SMTP id h5mr2716251igt.63.1367007488224; Fri,
 26 Apr 2013 13:18:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 13:17:27 -0700 (PDT)
In-Reply-To: <CAMP44s2SaKe7F-3H=b3ZBgDPDT+TrVPUBLrXg0XDY7n5ppdS0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222573>

Felipe Contreras wrote:
> The importance of users changes all the time. The 15 year old kid in
> Sao Paulo might not be important today, but he might be the single
> most important contributor ten years from now. Hell, he might even
> replace Junio as the maintainer.

Yes, they do.  Did I say that they don't change?

> Where did I twist anything? You can see Linus talk himself:
> http://www.youtube.com/watch?v=kzKzUBLEzwk

Yes, I watched the talk when you posted the link last time.  And yes,
I learnt something.

> Should we willingly and knowingly neglect some git user-base? No, why
> would you want them to fork? In a way, git's UI has been so bad, that
> some kind-of-forks have happened, that tells us something; the UI
> needs some love, fortunately none of those forks worked, which tells
> us something too; it's not too atrocious.

No, we should never neglect.  I believe in including everyone.  In
fact I take it to an extreme: on many instances, I have pointed out
what I want specifically, and asked for a configuration option if it's
not necessarily a sane default.  Git is a toolkit, and should be
loaded with features that even a few users want.

> That's not to say we shouldn't fix the UI, we should, in a way that
> everyone's happy, which is hard, but we will do it, eventually.

On this, I think the way forward is complete-implicit'ness via
configuration variables.  I recently wrote remote.pushdefault to
simply 'git push', and proposed 'git push +ref1 ref2 ref3' to
automatically push to the correct pushdefaults (but that proposal was
rejected).
