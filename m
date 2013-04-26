From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 13:48:14 -0500
Message-ID: <CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
	<CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
	<CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnh1-0001QO-0m
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab3DZSsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:48:17 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40128 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3DZSsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:48:16 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so3519025lbi.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VYMDIhT1y0mF48D3zOFZGIQcjkqDpDPT+z3mqWtdHGU=;
        b=MHUGHq8zxUBtRAR2ppBXeZyqr7scy4ESaDtKtus0SPsJfsyoVW0EE2cjNMMQlErp8M
         MMnnuK0EBtVEB4+FeIFg8X8y6l1Jdkgl3jwTTRuFDBVK4YKjMLd5I/asoXPNPP35N1g0
         Ph59dpQ7+8CS2B8m4pCxLvqHWA/N3v+Y6Qfr/NBvMktu4bWV+ttMVwsLF94uiohyCShD
         fjoyAmEQ2eqgYhEsbRtLspOCgiObugX1hofutrmFzHM0vh2Owyg1LodqRBKczairZslC
         PGJPU8E3DoMM+jg5AWw1ROez/kQXsur7PeNoPIs0XiOCPsAdLKm32J0d8NJOigW6JDor
         N76w==
X-Received: by 10.152.3.137 with SMTP id c9mr23096094lac.5.1367002094644; Fri,
 26 Apr 2013 11:48:14 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 11:48:14 -0700 (PDT)
In-Reply-To: <CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222552>

On Fri, Apr 26, 2013 at 7:19 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Any sensible reviewer would be context aware, notice that this
>> is a contrib patch, and focus on behavioral changes, notice the
>> mistake I made, and point that *one* of the changes was changing the
>> behavior, at which point I would agree and reroll either without that
>> change, or with the change in a separate commit (which I don't want to
>> do right now). The maintainer (you), wouldn't even have to reply at
>> all.
>
> Personally, I think it is the job of the submitter to provide a really
> helpful commit message and widen his review audience.  If I'm hitting
> the git mailing list with my patches, I try to make sure that nearly
> everyone on the list can understand what I've done and potentially
> review it.  Why else would I want to hit their inboxes with my
> patches?

If you don't understand the reasoning and history behind remote-bzr,
you might be doing a disservice to everyone by commenting at all.

Bazaar is a dead project, and there are *real* users suffering as we
speak, bound to eternal SCM torment by evil dictators and political
non-speak. Even the worst of remote-bzr patches are a thousand times
better than what you see in bzr code itself.

To give you some perspective, one commit broke a branch in the emacs
project, and ever since then people are not able to clone that branch.
This bug has been known for years, and nobody fixes it. Every time
anybody tries to clone that branch, they need a special sequence of
commands.

They *need* something like remote-bzr to escape the horrendities of
bzr, and all you are doing complaining about a sneaked fix is a
disservice to everyone. Yes, doing such a thing on git.c would not be
particularly great, but wouldn't be horrific either, fortunately we
are not doing that!

Answer me, do you use bzr? No? Do you use remote-bzr? No? Then how in
hell could you possibly have any contextual information to make even a
guess as to what would be the impact of sneaking such a small fix? You
can't.

But why are we even speaking about this nonsense? This patch has been
dropped. You want to review something, go review PATCH v2 1/9. Stop
arguing about stubbornness and hypotheticals, when there's actual code
to review.

What is your objective, do you want to help this project move forward or not?

-- 
Felipe Contreras
