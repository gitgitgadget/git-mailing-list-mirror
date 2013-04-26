From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:26:57 +0530
Message-ID: <CALkWK0nkt-uytJYpyZ94YCqV8L=m7v39TxKBaKfMJivh2COEng@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <7vsj2e1d83.fsf@alter.siamese.dyndns.org> <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
 <CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
 <CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
 <CALkWK0mHCNdr7+QxmmB3jTnWTe8q0_ipXD0=1bKQdpLK07gnAg@mail.gmail.com> <CAMP44s0r52L0_r-tQWCkLjOvV7jBghHLqMi6rh_UyChXvx6J1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVom8-0004eS-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067Ab3DZT5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:57:39 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:60164 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab3DZT5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:57:38 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so4013252iab.22
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=89Bivo27IXhRThbmK+9Ra6y+Uus0dk4OGru3cwAyODc=;
        b=m9CDb8/c5vrG6cF6IVw2vD2FpIbXbYD5wA3FXPWIEqGiMtnQAcvse7iuUtgXOI9Csk
         atvyB762mawg6Xnwkw0j0fTNWrH613MxMO8Il3/auQp2Yh66jdZ5O9shuv7zj1zggTnp
         NuGjI5p+FpTLaQZoLhvkJD51v3/FDpuy4aWd5qwU/QaI90HKXAjFEUUoVctzD1jfbcCF
         Vos2B/1vccdVo+ODd5/AE0mEp6TxfZsfcD8Z2ymfJXUWHbTvWrwnl38N4ALt77FuSRsl
         N9N/99QkwLpFmStTYzMnco9gNKm3VjcUNDj3VR7077T/QNHu95BOBZhkHEy6nYzwjk5g
         wr9w==
X-Received: by 10.50.72.65 with SMTP id b1mr2772398igv.63.1367006258307; Fri,
 26 Apr 2013 12:57:38 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 12:56:57 -0700 (PDT)
In-Reply-To: <CAMP44s0r52L0_r-tQWCkLjOvV7jBghHLqMi6rh_UyChXvx6J1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222568>

Felipe Contreras wrote:
> We all benefit from these patches being reviewed in the git mailing
> list, nobody has claimed otherwise. You are making the error of
> assuming that your review was actionable, that I should have done
> something, fix the commit message I suppose, but I don't think that's
> important.

What I'm saying is that you can get more eyes.  A lot more eyes.  If
you just write a proper commit message!

Why are you hitting everyone's inboxes with such cryptic patches that
require either:
1. The reviewer to trust what you've done and move on.
2. The reviewer to do a lot of digging before the patch becomes
accessible to her.

> You just got angry that your review didn't turn out to be helpful, is
> that it? Why do you want to steal helpful review from the users of
> remote-{bzr,hg}? If that's not the case, please stop doing that. All
> review is welcome, not all review should be acted upon.

I'm not angry about anything, or trying to steal anything.

What happened:  New email.  Felipe's remote-hg fixes.  Okay, let's
look at this.  Part 1.  What?!  [I wrote down what I was thinking as I
was reading the email]

This is where you _should_ apply reason: justify everything you've
done in the patch in your commit message.  Why are you so stubborn
about not wanting to change your ways despite so many people telling
you?  Is it your pride*?

* Yes, I noticed that you have a huge ego.  I consider it an undesirable trait.
