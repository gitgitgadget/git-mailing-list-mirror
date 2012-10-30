From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Tue, 30 Oct 2012 21:15:39 +0100
Message-ID: <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:16:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTIEG-00079O-V9
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 21:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934497Ab2J3UPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 16:15:49 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40776 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934454Ab2J3UPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 16:15:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so691076oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MUepEkyComyCdoKfVlizMlS4f7yVpHmMhDZ2F0utcaE=;
        b=UfOy1C2lT4+vEszKIdfV/42el4nmneRwmA1p/qhkSjVJ7PMtTh70WvD51lp5o8lgHB
         PrcjSuiAiUxZvD+ddoY7a1gQ405bG1ErJI+mhhOMz0YLiZOMPhI4JImlNs46XmMcM8Bf
         cFJIHMwNhV+fnxM89f12/euqbvHNZM5Lsx5in6FI7gM2G60K0kroxh0J9zGxDu3LkZpQ
         Ab6HN2in2VHdKwtX5jCUbmU+hmNiVLDEAvHzRd00/PzqGFV7e1PWv/D6ebuDb/zrGgKs
         5wfYS1ytnz9d6WT9sJS2EQj7fDmDE9RJZJjoAlPzQmP1BmNflSFANFFf+0R7nRpSIkTD
         GQ6w==
Received: by 10.60.31.241 with SMTP id d17mr29658553oei.107.1351628139685;
 Tue, 30 Oct 2012 13:15:39 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 13:15:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208735>

Hi,

On Tue, Oct 30, 2012 at 8:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 30 Oct 2012, Felipe Contreras wrote:
>
>> But you mentioned something about cooperation, and I've yet to see how
>> is it that you are planning to cooperate. If you say you don't have time
>> to spend on this, I don't see why I should worry about testing this
>> series of patches.
>
> It has been mentioned before that the communication style including all
> these snarky and nasty comments is not helpful.

Snarky and nasty comments? How about this?

---
> As to the functionality you seek: git-remote-hg found in
> git://github.com/msysgit/git works. It has the following advantages
> over every other solution, including the one proposed in this thread:
>
> - it works
>
> - no really, it works
>
> - it supports pushes, too
>
> - it matured over a long time
>
> - there are tests
>
> - whenever we fixed bugs, we also added tests for the bug fixes
>
> - it is rock solid
>
> - it is in constant use
>
> Without push support, remote-hg is useless to me. Without regression
> tests proving that it is rock solid, I will not use remote-hg. And I
> will not indulge in efforts to duplicate work.
---

How many times does somebody has to say "it works" before it becomes a
snarky comment?

Or this?

---
> FTR, the reason that it's crashing is because you're lying. You're
> saying you already have master (by means of ^master), but you don't.
---

Or this?

---
> It seems unlikely to me that this never worked, surely no reviewer
> would accept a patch that doesn't actually implement the feature?
> What's the history here?
---

So what did I say?

> But you mentioned something about cooperation,

That's a fact.

Johannes:
---
> > It would be better to work together, but to me the code-styles are way
> > too different, the difference between night and day.
>
> Aha. Well, okay, it was an offer to collaborate.
---

> and I've yet to see how is it that you are planning to cooperate.

This is also a fact. You haven't provided a branch, you haven't reviewed
my implementation, you haven't tried it. You mentioned something about
testing the performance, but then retracted from it.

So, if you were planning to collaborate, now it would be a good time to
mention how.

> If you say you don't have time to spend on this, I don't see why I
> should worry about testing this series of patches.

I'm just clarifying how I'm planning to spend my time, specifically if
you are not going to collaborate.

What is snarky and nasty about any of these comments? I'm simply asking
you if you are going to collaborate and how, because I don't see it,
and what I'm going to do.

You think that's snarkier than the comments above? Well, I disagree.
But I don't blame you when you are snarky, nor do I think I should.

> It is hardly the first time that your mails have been insulting, as
> can be researched easily from in the public mailing list archives.

Those who want to be insulted would get insulted. I asked
a simple question "are you going to collaborate?", if you find that
offensive, that's your right.

> In light of the indignation when advised to keep the tone down a little,
> it is probable that the mails were never put through the "would I be
> insulted or hurt if I was the recipient of this?" test, as in "do you want
> me to throw away my work?" when you literally asked us to throw away our
> work.

How did I ask you to throw away your work? I have asked multiple times
now for you to provide a branch so that we can take a look and try it.

I don't know of a better way to throw away code than to refuse to
provide it, which is what you have been doing. So, if anybody can be
blamed of trying to throw away code, it shouldn't be me.

I know you will find the previous statement offensive, but it happens to
be true. It is sad that you will concentrate on the statement, rather
than the fact, and instead of providing the branch (which will help
to avoid throwing away the code), and thus nullify the statement, you
choose to be offended and complain about how offended you are.

Well, I'm offended at how much you refuse to collaborate, and at how
much disdain you throw at my code, but I'm not going to complain about
me being offended; people get offended about all sorts of things. Why
is why there's no law against offending people.

Instead, I choose to do something positive about it and improve my code
with your criticism (e.g. lack of tests), even if that criticism is rude
and unwarranted. But that seems to mean nothing to you.

> So unlike others, I do not ask you to change your tone, nor your
> willingness to work with others. Instead, I prefer to do other things
> instead.

I guess that answers the question; you are not going to collaborate. Got
it.

I will not ask you again for a branch with the remote-hg code.

Cheers.

-- 
Felipe Contreras
