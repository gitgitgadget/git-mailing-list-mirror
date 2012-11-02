From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Sat, 3 Nov 2012 00:52:19 +0100
Message-ID: <CAMP44s2aCpYWzemMCpYJBvT0u4MDNxXge-MOCt=JV+zjyZp-3Q@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
	<20121102144618.GA11170@sigill.intra.peff.net>
	<CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
	<CA+39Oz7vbAwQSfL0PMjjYgQ=njQpu5i_3BSTCzznQJozKOKeXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 00:52:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUR2P-0005oy-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 00:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758996Ab2KBXwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 19:52:20 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37232 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2KBXwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 19:52:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4162128oag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KLfyjxEOyj8l4nGC00RqxxnvIbRlCG+6sD+sJqZ/bmk=;
        b=eA0FrznxJuPbbQ44xYqB1Qy9GqcwDJkEBb5if6ulQpQ07//7yuyUpf0UQsvQQ26T1+
         EWH90uCgxnq5rZYQzWZaCqnTJYt7BkPK2SETYT6npbuFaiwlErWfwGpLcekEloLkf1k0
         wm5r8lH57TTjY1A3ENDFqOirMMxWTvx1q2TZsADNhXvhqZ+7fOPU61/PgaC4szqmWGHT
         5Jb9S5IWwQ6H7JCt/rGY71zdL+DWEAvgYlItYKX+illaHuo6mxuMOFZtDWUadP1QNeUs
         IhPPt/KWOzFjJ2xagoo0Px1thsrpf8yqRQdSdvczY5MpwCXfa9qaNw+GKv8cC0lrN6uS
         4UHA==
Received: by 10.60.27.201 with SMTP id v9mr2629069oeg.85.1351900339061; Fri,
 02 Nov 2012 16:52:19 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 16:52:19 -0700 (PDT)
In-Reply-To: <CA+39Oz7vbAwQSfL0PMjjYgQ=njQpu5i_3BSTCzznQJozKOKeXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208976>

On Sat, Nov 3, 2012 at 12:18 AM, Thomas Adam <thomas@xteddy.org> wrote:
> On 2 November 2012 18:39, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> I disagree. The open source process works not by making favors to each
>> other, but by everyone sharing and improving the code, by
>> *collaborating*. "I review your code if you review mine", or "if you
>> by me a bear in the next conference" is not the spirit of open source,
>> although it might happen often.
>
> So shunning any attempt at explanation, and peddling your own thoughts
> over and over again, irrespective of whether you contribute code or
> not -- doesn't mean to say you're right, Felipe.

Who is saying I'm right? Certainly not me.

I have explained patches over and over, even to the point that people
apparently get offended, and now you say I should explain more?

I'm sorry, but no, you cannot have your cake and eat it at the same
time. Either you want me to explain things, or not.

> And that's the
> fundamental issue here -- your code speaks for itself, sure, no one
> denies that, but the code is not even *half* of what makes up the
> discussion.  And so far, the surrounding context and attitude from you
> doesn't help or enhance the process under which your code is reviewed.

I would say it's the other way around, it's the attitude of other
people that believe they are entitled to their opinion not being
shined in a critical fashion, while at the same time being very
critical themselves.

If you want to disagree, fine, but it's still the project that gets
hurt, not me, reviewing code is still for the benefit of the project.

>  And no, you cannot philosophise this, or wriggle out of it through
> idealism or some other "charter" or "code of conduct" -- as reviewers
> of your code, we have to interact with you to be able to better it.

That's right, for the benefit of the project.

> But you seem very reluctant to do that.

Reluctant to what? Interact? I've answered every single question, and
then some. I've also implemented tests, and addressed every criticism
of this patch series however rude that criticism was thrown.

It's actually the other way around. There's a thread about netiquette,
precisely to avoid certain kinds of discussion.

Show me a *single* instance where I've ignored a review comment, or
whatever you mean by being reluctant to interact.

> The fact that we're even having the conversation is evident of that.

The fact that the sun raised at east and set at the west was evident
that it was rotating around the Earth, but that, like many other
assumptions, was wrong.

Cheers.

-- 
Felipe Contreras
