From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Thu, 17 Oct 2013 16:34:01 -0500
Message-ID: <526057c98609c_448145fe74bb@nysa.notmuch>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <xmqqy55ub1ud.fsf@gitster.dls.corp.google.com>
 <525e0b6e25aeb_81a151de7495@nysa.notmuch>
 <xmqqppr3znf1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 23:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWvSe-0000Zw-43
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 23:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762702Ab3JQVuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 17:50:23 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54860 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762435Ab3JQVuX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 17:50:23 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so2481218obc.17
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=X5ZCa0NyggQ+PUdf3QrjnQGfRu6cSBVo/lBFMtOme7I=;
        b=vqub2GpLofxo/Zd+dmKywKIdkbv5qBN5ZaWxDzM6TI8qeKyrh+LuPodFEHZptl4IZH
         9j+unZTQFfQfOgzn2erE+mMUTweMeXJ16AJLU+0JIKmEtUhqOQfkuNmcygO3xwb3Zf+F
         QQSJytIeg/7qWw6/3CdRddqN5kl94Kgas73L0FgB0uYIKXPo7B+irdYBTZ0Xnc8ep6DS
         9LXRWB3svd7Hi3LBjIrV9LPqtSQH04ztQQ5X1gesC1TNJN0n/6yaBBbcK2YtbqQqceeu
         D/aZ84ac0a8Tfc9bA3M4zpCl4Oe2MJrj5O4gSi5gr1u5SjrZHOGiuMXnzfSYkd9poWiM
         ZBNg==
X-Received: by 10.182.102.2 with SMTP id fk2mr767760obb.69.1382046622628;
        Thu, 17 Oct 2013 14:50:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm78978915obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 14:50:21 -0700 (PDT)
In-Reply-To: <xmqqppr3znf1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236324>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > It seems[1] that some
> >> > people define "ci" as "commit -a", and some people define "st" as
> >> > "status -s" or even "status -sb".
> >> 
> >> These option variants aside.
> >> 
> >> Just like thinking that committing must be the same as publishing,
> >> it is a cvs/svn induced braindamage to think that "checking in" must
> >> be the same as "committing".  The former is a sign of not
> >> understanding the "distributed", the latter "the index".
> >> 
> >> In a world with both check-in and commit as two words usable to
> >> denote possibly different concepts, it may make sense to say "you
> >> check-in the current status of the working tree files into the
> >> index, in order to make commits out of it later".
> >
> > Yet a wide amount of users do use 'ci' to mean 'commit', so basically they are
> > just wrong. So you are saying they are just ignorant.
> 
> I am sick of seeing my word twisted, especially when they were not
> even addressed to you (see the message's primary recipients list).

When you send messages to a public mailing list, even if not addressed to that
mailing list, is with the expectation that other people in that mailing list
will reply.

When you say something is a sign of not understanding, that means ignorance,
and there's nothing bad about that, we are all ignorant about many things.

> Those who want to type "git ci" due to their familiarity with "svn
> ci" are not wrong; they can do so if they choose.

I never suggested they were wrong, you suggested they were ignorant.

And this is being used by you as reason *not* to use ci as an alias for commit
by default.

> > Now, if you are commenting on the aliases, that would mean you are not against
> > the idea of aliaes per se, but more about values of those aliases. So if we
> > agreed on the right values, you would welcome this patch.
> >
> > Is that correct?
> 
> No.
> 
> I agree with the issue the message I was replying to raised. The
> alias mechanism is a way to help users to define their own
> convenient short-cut. If you want to say "git ci" to mean "git
> commit" (and not "git commit -a" or something else), define it for
> your own use, and stop there, without getting in the way of other
> people.

A set of default aliases doesn't get in the way of other people either.

That's why all VCS tools have them, and none of them have a problem.

> That is why I see an attempt to add hard-coded set of aliases as a move in
> the wrong direction.

They are not hard-coded, they are configurable.

> A set of hard-coded alias that _officially_ declares that "checkin"
> is an equivalent to "commit" has another issue.

No. Nobody said anything about check-in, it's ci, which could be CommIt. And
you are conveniently ignoring all the other possible aliases for commit.

> It will close the door for us to later add "git checkin" that may mean
> something different from "git commit", and that is another reason why I do
> not agree with the patch under discussion in this thread. A "checkin" that is
> an operation that checks-in the current contents to the index is one example
> of an action other than committing that the word may make sense for, because
> "git checkout README.txt" is about checking out of the index, its logical
> opposite "checkin" could be about checking into the index.

Nobody said anything about a check-in. This is a red herring.

Absolultely nothing you have said in this second half has anything to do with
the question I asked. I asked specifically about the idea of aliases,
independently of their actual values, and all you have done is argue against
the value of a single alias: ci.

-- 
Felipe Contreras
