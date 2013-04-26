From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:09:38 +0530
Message-ID: <CALkWK0mV-zZ1akdk7rt9HUic7E-gL17sH7dgepw8Bs7hmZ+=LA@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <7vsj2e1d83.fsf@alter.siamese.dyndns.org> <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
 <CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com> <CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoVN-00022l-0K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3DZTkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:40:21 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:45096 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab3DZTkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:40:19 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so3884423iar.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nH9yrQYOCMolfQ6hGtYkEL6URvXniaMfaM3N5jElnZo=;
        b=tGLSctraiYCL11hk2XadWgA5mCC/RN+65xRLOOAUO9OMxA5ys9w6h5NQ1bU/H69Rbn
         nAx9sQ/eNfnNuzDbtqxzwadK5EDQpYba6msI09UcsYLmM1IbnpFWi9UIca3Qvj6mv35w
         sffHTCctID/24XqkuHSjhQfNO1TYKyPwFKXio8bAKXtAlRAvl+KjCmwVCd6u9rUSTGsa
         01r3DbF4ZqtjrHa6cVxHs3phv1zvwtV+jdRpo76VCg8MuMwgE8Ktb9jAC/VBXn1AsU3K
         OB8qeW9mkOBX/kS4sm5pLNTOnVxtopCW6qwB7VDWGW1bznzypw9NWLzaLleMRLhCUe6F
         0YJQ==
X-Received: by 10.42.27.146 with SMTP id j18mr13841029icc.54.1367005219267;
 Fri, 26 Apr 2013 12:40:19 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 12:39:38 -0700 (PDT)
In-Reply-To: <CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222564>

Felipe Contreras wrote:
> If you don't understand the reasoning and history behind remote-bzr,
> you might be doing a disservice to everyone by commenting at all.

Felipe, I'm trying to help.  If you think my review lacked context,
you can write me a paragraph/ link me to an email and I will read it.

It's not reviewers and submitters "attacking" each other.  It's
helping out other rational people in the community because you care
for their reviews.  Don't practice exclusivity and label some people
as "not eligible to review".  That's not a good way to develop.

> Bazaar is a dead project, and there are *real* users suffering as we
> speak, bound to eternal SCM torment by evil dictators and political
> non-speak. Even the worst of remote-bzr patches are a thousand times
> better than what you see in bzr code itself.
>
> To give you some perspective, one commit broke a branch in the emacs
> project, and ever since then people are not able to clone that branch.
> This bug has been known for years, and nobody fixes it. Every time
> anybody tries to clone that branch, they need a special sequence of
> commands.
>
> They *need* something like remote-bzr to escape the horrendities of
> bzr, and all you are doing complaining about a sneaked fix is a
> disservice to everyone. Yes, doing such a thing on git.c would not be
> particularly great, but wouldn't be horrific either, fortunately we
> are not doing that!

My God.  This is horror story.

> Answer me, do you use bzr? No? Do you use remote-bzr? No? Then how in
> hell could you possibly have any contextual information to make even a
> guess as to what would be the impact of sneaking such a small fix? You
> can't.

No Felipe, I don't use bzr.
