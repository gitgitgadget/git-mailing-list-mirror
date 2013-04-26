From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:23:03 -0500
Message-ID: <CAMP44s0P4K8MSsuPLCSCVzNJnioCpTJ0puD-gduuDbmRcGZGOg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
	<CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
	<CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
	<CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
	<CALkWK0mHCNdr7+QxmmB3jTnWTe8q0_ipXD0=1bKQdpLK07gnAg@mail.gmail.com>
	<CAMP44s0r52L0_r-tQWCkLjOvV7jBghHLqMi6rh_UyChXvx6J1g@mail.gmail.com>
	<CALkWK0nkt-uytJYpyZ94YCqV8L=m7v39TxKBaKfMJivh2COEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpAl-0006BZ-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab3DZUXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:23:07 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33030 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab3DZUXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:23:04 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so3876751lab.25
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QCWF/U0ffGVMRh4iVaRH8MWgZpbGP57ZM3esrEI+7nk=;
        b=1EqtihJ9pa15LaYS2n546rHVhEz0v6gHb9YTLMrg7xKZODWg1wLK/RNzfEsxK5zM54
         tPQwKEf+VkKCydBm2FmrNtjQyKEBO7ZAr07WOsJ0xbgg5bDx/lVlRiHw6feZCXSjcU9d
         FpSpMBmR+syObMaX5Q3lBi8plELP8wwP79VO3X6y8+phdK/tG03tVfN89pZ5jZ1FJcnM
         tBGaDaYzZgOl4NABg/ILUJ6dZ4ULDcsfvjeZvx281MLcyr9poxEXTh0cWkxHojWf2wPx
         q9V3TPx9inU3Dcm2v3XSpmcHNWYjj/GQ325EC9AoVXH4zorpaLynUmR7RHl/Uy0TWeeJ
         ajiQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr21160854lbb.8.1367007783342;
 Fri, 26 Apr 2013 13:23:03 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 13:23:03 -0700 (PDT)
In-Reply-To: <CALkWK0nkt-uytJYpyZ94YCqV8L=m7v39TxKBaKfMJivh2COEng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222574>

On Fri, Apr 26, 2013 at 2:56 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> We all benefit from these patches being reviewed in the git mailing
>> list, nobody has claimed otherwise. You are making the error of
>> assuming that your review was actionable, that I should have done
>> something, fix the commit message I suppose, but I don't think that's
>> important.
>
> What I'm saying is that you can get more eyes.  A lot more eyes.  If
> you just write a proper commit message!

It is a trivial obvious patch that changes very few lines of code, it
doesn't need more eyes in my opinion. For the patches that do need
eyes I do send descriptive commit messages. And some patches that I
don't think need eyes, but I think I could do wrong, I also write
descriptive messages.

So far, it looks like I was right in thinking this patch didn't need
more eyes. And I think my original commit description, which I deleted
by mistake was more than enough "Mostly from remote-hg. It's possible
that there's a fix to delete files with spaces". Because so far,
nobody has pointed out any actual issue, and it's not clear if this
patch would benefit from even more eyes... probably won't.

> Why are you hitting everyone's inboxes with such cryptic patches that
> require either:
> 1. The reviewer to trust what you've done and move on.
> 2. The reviewer to do a lot of digging before the patch becomes
> accessible to her.

Because there's no other way to get the changes into git.git. If you
wan't I can add "DO NOT REVIEW" in the title, but I think "trivial
cleanups" pretty much sums that what I feel, and actually I wouldn't
want people to _not_ review the patches, but rather to understand that
I think they are trivial, and shouldn't worry too much about them.

>> You just got angry that your review didn't turn out to be helpful, is
>> that it? Why do you want to steal helpful review from the users of
>> remote-{bzr,hg}? If that's not the case, please stop doing that. All
>> review is welcome, not all review should be acted upon.
>
> I'm not angry about anything, or trying to steal anything.

Good, so I'll keep sending the patches, because our users benefit from
the review.

> What happened:  New email.  Felipe's remote-hg fixes.  Okay, let's
> look at this.  Part 1.  What?!  [I wrote down what I was thinking as I
> was reading the email]

Write what you see, not what you feel. Your questions about the code
are fine, but making assumptions about what remote-bzr users must be
suffering by not having more descriptive commit messages are not. You
also assumed that I wanted to send that commit message, when that was
not true, I removed a chunk by mistake.

In general, you shouldn't make assumptions.

> This is where you _should_ apply reason: justify everything you've
> done in the patch in your commit message.  Why are you so stubborn
> about not wanting to change your ways despite so many people telling
> you?  Is it your pride*?

Stop asking these questions, I thought you already agreed this patch
was not worth discussing about. If you see *any other* patch that
doesn't have a good enough commit message, reply _there_. And if you
do want to pursue these questions irrespective of this patch, start a
new thread.

> * Yes, I noticed that you have a huge ego.  I consider it an undesirable trait.

I don't think so, but even if I did, it doesn't matter, all that
matters is that my arguments are sound and valid, you should
concentrate on the ball, not on the man. The fact that I believe my
arguments are valid and sound doesn't make me egotistic, it might be
that they are actually valid and sound, and I'm simply assessing them
correctly. I of course I'm willing to admit otherwise, based on
evidence, and reason.

Cheers.

-- 
Felipe Contreras
