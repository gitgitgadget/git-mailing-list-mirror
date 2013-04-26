From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 17:22:32 -0500
Message-ID: <CAMP44s1h50Xjo7H4Op=yDuO7pon2JdxZMBy2JSj2kf+Tnznd=w@mail.gmail.com>
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
	<CAMP44s0P4K8MSsuPLCSCVzNJnioCpTJ0puD-gduuDbmRcGZGOg@mail.gmail.com>
	<7v1u9xvt88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVr2N-0007Ne-6E
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3DZWWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:22:35 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:60799 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab3DZWWe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:22:34 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so4018988lab.31
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=eja0WowbiQc2UNkFQeKFg/c0QUPEO0l2smuYHyoFiFg=;
        b=0sWSxNP4/qYXHnz8zXxuZr/SRu1l0vR8Uchfv4GwwPiVMmyoa9dtuchzp9DtcYgZrm
         gQa7y3f8dbeho82GWj8M2lENQ8bxcXwGnWH62SI9CYD4Qy5FeR1OfNoB1ylo/bWbCXJ7
         ypHCxiEWFicbGweWVsCuYxL3oBkcHnr8pknqi+9CEwid1b9Tsps178pRaUfk1sVfbnol
         60TRgkBRgfPSVmyUPJy8g6LVs+UpXci4egTUZyVJ1uEIiDrVoS33kH7bv3oW8erjEVx2
         eY2eudRsE9DTWaHjJ8NpW1LwKJmGKCPI+dAGNMITfS9okV3zAFzvsGIC3o2h6fYen4fN
         imqg==
X-Received: by 10.112.139.226 with SMTP id rb2mr22026384lbb.12.1367014952920;
 Fri, 26 Apr 2013 15:22:32 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 15:22:32 -0700 (PDT)
In-Reply-To: <7v1u9xvt88.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222597>

On Fri, Apr 26, 2013 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Good, so I'll keep sending the patches, because our users benefit from
>> the review.
>
> Just for the record, a patch sent to the list which nobody bothered
> to read does not really count as reviewed.

No, but I did my part, which is sending them for review.

> You can either
>
>  (1) pace yourself when people are otherwise busy; or

I would, if there was a reason to.

>  (2) send them anyway but not claim "this was sent to the list two
>      weeks ago, nobody complained, so it must be perfect" when it is
>      not picked up after a few weeks.

When have I ever done that?

> Often (1) is a better strategy, as people who wanted to review but
> otherwise were busy tend to declare patch bankruptcy after their
> busy period ends.

Not for remote-{bzr,hg}. I've yet to see anybody claim they would
review the patches thoroughly, if only they were given time. I've yet
to see anybody claim they would review the patches thoroughly under
any circumstance at all. And by that I mean the patches that really
would benefit from reviewing.

> Also, a reason that a patch goes uncommented is when it is difficult
> to judge.  A patch with code change without sufficient explanation
> behind the motivation to justify the change, a reviewer finds it
> much harder to convince himself that the patch is a good change, and
> it also is much harder to find which part of the change is wrong and
> offer improvements, compared to a patch with the same change that is
> justified properly.

Yes, but is that the case *HERE*? And no, single line changes that are
trivial and obvious don't count. Show me an important patch that
surely would benefit from reviewing that doesn't have sufficient
explanation. Show me an important patch that anybody is not convinced
is a good patch. In the remote-{hg,bzr} context.

If there isn't any, I don't see why remote-{bzr,hg} should slow down.

For this patch, I don't care one iota.

Cheers.

-- 
Felipe Contreras
