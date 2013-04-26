From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:00:29 +0530
Message-ID: <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com> <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoMX-0008GV-7C
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab3DZTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:31:11 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:49381 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab3DZTbK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:31:10 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so3932578iae.20
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EtwFZ7ngIsX2pZSWLZ2KVzo/5VZWF2Zx+utfJOTfrdE=;
        b=CgxmEh8+JR1az7L4kB0ep6ZfXnVZKOzKGW473TBgx7EqQPGCcw/13Dqu0JVmAffSjG
         oauGjwJlPE2UeNP0B9Oz7gEN7cMI190dVp488AKVNIPFi6oF2HCHlfPrwjHZGvschvx2
         8N4DunnsrTY7A05GRAocPtORNLEhBk6RoP0EFMQ4/oZ+BuVMe0qOtohChhIDZrrfqDuy
         6Mo3Sk64SLVsm09aRN+2D9YicP2fc0z4VkqAmux+dstFG0kMk12NJsKaIc6Eia++r+Pa
         G7zyukIkZcHXCJXyp4myrv6gOhPbtpoHoYJV/HmmlG6Rd/7nqL93Sb1ziu0BpbBKtuXz
         Rv7w==
X-Received: by 10.50.66.197 with SMTP id h5mr2623585igt.63.1367004669471; Fri,
 26 Apr 2013 12:31:09 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 12:30:29 -0700 (PDT)
In-Reply-To: <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222561>

[completely off-topic; don't worry, we're just having a friendly chat]

Felipe Contreras wrote:
> If you are not prepared to defend your review, so are others, why to
> you blame that on me? If you were right, you would be shown to be
> right. Period.

Felipe, there are some things that are worth arguing about for a long
time (like the new revision spec I'm proposing in [1]), and others
that are not.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/222248/focus=222526

> No, we operate in evidence and reason, *not* opinion. Any reasonable
> person would say "well, I *think* this commit message needs more
> description, but I don't *know*, I don't have *evidence* for it, so
> I'm not going to fight to the death, as if I had".

Don't you think you're taking reason to an extreme here?  Reason is a
tool that I use when I want.  I don't want reason when I'm browsing
Google Art Project or listening to Gentle Giant.  Arguments like "is
this commit message large enough?" are really not worth the time and
effort.

> Ultimately the decision to merge or not to merge comes to Junio, if
> you don't like his decision, go complain to him, but I would be
> prepared with points in time where people complained about these
> patches, and there are no complains, so you have no ammunition at all
> whatsoever.

I have no desire to "attack" you, Felipe.  I respect you as a more
experienced developer than myself, and am trying to offer constructive
criticism.

I don't have an ego (or consider myself important to the community).
Whatever will happen will happen, with or without me.

> And this is how communities die. When everybody thinks the same, and
> everyone who thinks differently is displaced. A monoculture, a place
> full of yes-men where nobody criticizes anybody, a circlejerk where
> everyone palms the back of everyone else. Eventually things go south,
> and nobody around you understands why.
>
> Diversity in a community is healthy. If you don't like people who
> think differently, *you* have a problem. If you don't like standing up
> and defending your ideas, *you* have a problem. If you don't like
> discussing on the basis of evidence and reason, *you* have a problem.

Diversity is certainly healthy, and I it would be nice to have you in
the community.  We just have to find a way to keep the conflict down.
