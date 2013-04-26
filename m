From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 14:39:32 -0500
Message-ID: <CAMP44s0r52L0_r-tQWCkLjOvV7jBghHLqMi6rh_UyChXvx6J1g@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:39:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoUd-00019P-84
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab3DZTjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:39:35 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:52162 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab3DZTje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:39:34 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so3880739lab.39
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=90lCd26w0U+Y0lSCgt4KsQqU8WbFlQhKxQy9G94Jk3I=;
        b=YNsaG7BSt4Jy76YKgjrDsdycAPoVbet0qQvdrrM/YHCARrVgsLcz8iouzHdSqViITI
         MS4+pudfoJVrUwS1Ix2uepWjPNcRDyTRsgCvdPRj4cC4DKorTT2PgPjJpu3hn+ZEiO23
         AOod0fOklrfkqCFMSTH90QyKnvow0ur3fXRbfSclBdSzneiX58MMM5GTLlimIrVFcnKw
         3z2kEOMuIEWNBawzK3W/A6DELoVTShBUyvZOufWJLvMhAHhwWrHgzJ18iJeDkuRGcIt3
         VoqJTLUR4hqrKdDnYbXnThUuOoTYhAimwb8pXmIp3HbJayplwCPBazehIjz121sVml70
         6EOg==
X-Received: by 10.152.19.10 with SMTP id a10mr23152451lae.8.1367005172898;
 Fri, 26 Apr 2013 12:39:32 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 12:39:32 -0700 (PDT)
In-Reply-To: <CALkWK0mHCNdr7+QxmmB3jTnWTe8q0_ipXD0=1bKQdpLK07gnAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222563>

On Fri, Apr 26, 2013 at 1:53 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> What is your objective, do you want to help this project move forward or not?
>
> Forward, please.
>
> I want a solution to this persistent problem of conflict though.  And
> I presented one in my previous email:
>
> Here's my solution to the problem: maintain your project outside
> git.git and merge changes in every couple of months or so with a
> simple email containing a pull URL, addressing Junio.  If Junio trusts
> you enough to put the changes you send into contrib/ after a cursory
> glance, we're done.  Start a separate mailing list for your project/
> accept GitHub pull requests via which contributors can send you
> changes.  No more fuss or drama on the git list about this.  You can
> be as stubborn as you want, and we go back to our lives.  Everyone
> wins.

I already maintain my own clone outside of git.git[1], and I do
already accept pull requests[2], and people have sent me patches
directly. The stuff I send to the git mailing list is what I think is
ready for merging. But there's only so much stuff I can catch.

We all benefit from these patches being reviewed in the git mailing
list, nobody has claimed otherwise. You are making the error of
assuming that your review was actionable, that I should have done
something, fix the commit message I suppose, but I don't think that's
important.

In contrast, this is how a constructive, valid and helpful review looks like:

http://article.gmane.org/gmane.comp.version-control.git/220034

Junio caught a problem I didn't see, I accepted the valid feedback,
and I resent with a fix. We all benefit from such interactions, both
users, and developers. What's wrong with that?

You just got angry that your review didn't turn out to be helpful, is
that it? Why do you want to steal helpful review from the users of
remote-{bzr,hg}? If that's not the case, please stop doing that. All
review is welcome, not all review should be acted upon.

Cheers.

[1] https://github.com/felipec/git
[2] https://github.com/felipec/git/pulls?direction=desc&page=1&sort=created&state=closed

-- 
Felipe Contreras
