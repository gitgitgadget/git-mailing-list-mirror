From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 15:52:19 -0500
Message-ID: <CAMP44s1uS23OvsDY+_YOBGMgc9t=FBEV3YvM34M9sLMEF9hnTg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<87bo92l5el.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:52:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVT9W-0005XP-EN
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314Ab3DYUwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:52:22 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:43087 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab3DYUwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:52:21 -0400
Received: by mail-la0-f47.google.com with SMTP id ez20so2960420lab.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U+AuNb3+R/zK53sLPGHjrySxZDA+mseQBVRd+EClYtQ=;
        b=Wy8LA0KgwQDMK1rZRYMVEBA3duHqZValfBfJlCd8cl7koj4JWpjeBEVql8ktVx+YzY
         X0pZeDXVnZRKPewxuLEp0M/6201ZPtQY4rl0WufE7a+cF2Kzf3DRIgSJE0cUCKnPfoYD
         I11krn89yLWupzK7mH8OtxoE7483jqje4IwgvMYfOZ8zDFiOKnZ9JzbMa+jDJIlyWA+i
         tMijfqaFgWlD+ME6K+BH0vaT19g6KRUUQEHFaV76Pm5U8J2Rm8iM327I9mxRtzYya6lD
         Nvv9cPgoKFW1xGNREKucs3y+U4JyRSiPQNP9zX/m1dzqyKazzAJvbFU/CFIIzrst+rx8
         eYvA==
X-Received: by 10.112.135.3 with SMTP id po3mr17353407lbb.103.1366923139477;
 Thu, 25 Apr 2013 13:52:19 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 13:52:19 -0700 (PDT)
In-Reply-To: <87bo92l5el.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222447>

On Thu, Apr 25, 2013 at 3:30 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> But I do not care that much really. The patch is good either way, if
>> you don't like it, you go ahead and fix it, because I won't. I have
>> 174 remote-helper related patches in my queue, and nobody benefits
>> from rambling about a one liner that is obviously correct, not you,
>> not me, not the users, not the developers.
>
> You don't stick to the rules of this project, which have been pointed
> out already:

The rules of the contrib area are different from the ones of the rest
of the project.

> Your project is moving too fast to put up with the established
> procedures in this community.

That's one of the reasons it's in the contrib area.

> In fact you are pretty much holding us hostage with a "take it or keep
> it broken while causing more work" attitude:

I'm the maintainer of this code, so it's my call. If Junio has a
problem with that, I would gladly take my code somewhere else. I doubt
that's in the best interest of anyone.

But if the problem is this particular patch (reaally?), Junio could
just drop this particular patch. Are you seriously suggesting that the
whole contrib/remote-helpers should be dropped because this patch
introduces a one-liner fix without mentioning it in the commit
message? Really? I haven't seen anybody complain about *any* of the
other patches where I "held the project hostage" and refused to fix
the commit message or change the patch.

Other than this instance, show me where exactly did I do that.

>> Junio of course might disagree and drop this patch, but then he would
>> need to deal with the fallout of possible conflicts.
>
> You did not respond well to reviews and criticism.  Even the
> constructive fine-let's-do-the-work-for-him kind that Peff offered.

Define "respond well". If your idea to "respond well" is to say "Yes
sir!" to every criticism, then no, I didn't. OTOH, if it's to reply
and address the issues with objective reasoning and an open mind, I
did.

I don't understand this notion that every review criticism is valid
and correct. They are not, and it's OK to point that out.. really. If
they turn to be valid and correct, the reviewer can surely
counter-argue and substantiate his/her claims.

And I don't recall Peff ever doing this "constructive
fine-let's-do-the-work-for-him" on any contrib/remote-helpers stuff.

> So why is this in git.git?
>
> Why should we take any more contrib additions from you?

Because it's good for the users.

If you are seriously suggesting to drop contrib/remote-helpers, I
suggest that 1) don't do it in the review thread of a trivial patch 2)
start a new thread where you point multiple instances where the
maintainer of the code (me) failed to respond correctly to criticism
(of remote-helpers's code), 3) show how this affects negatively the
project, and 4) ask for new maintainers if the job of the current one
is not deemed up-to-par, and only if no maintainer steps up, drop the
code.

Cheers.

-- 
Felipe Contreras
