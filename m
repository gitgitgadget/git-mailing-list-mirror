From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 17:39:58 +0530
Message-ID: <CALkWK0k5+2nebRLZfWFpxyPmptV_Qo3sKwgpbpvN-bK6_S6W3w@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
 <1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
 <7vobbv119k.fsf@alter.siamese.dyndns.org> <87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
 <51a56bef1b9c2_807b33e1899991@nysa.mail> <877giixl4c.fsf@linux-k42r.v.cablecom.net>
 <CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com> <87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 14:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfDH-0006k9-L6
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965981Ab3E2MKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:10:39 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:49328 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965976Ab3E2MKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:10:39 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so10241213iee.39
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eAEsnGgeNk8OZHWxbqrEYH5cApUBEIQqXXRf0Kv4WNM=;
        b=Pzli2c1aq2KpeDXr7hBIXGszrnuPIR4ujl9jb06P9spOU9JPpqHQGGl1dpiSJBs+Q2
         eXx6aVenlKH29ZavjfdIp7ZsSEzzP+A6Hm1NTql/pcifCKCgNJAQETQJcUNwWO9VUDkS
         T34fVIxcwd41mtY+P2XV/Fc0q+yrFWGpGzwJfmtO/WsTVb27L3RKF2H2An6adFd+Z3dX
         8BjGUA9o599a8DpTd6AOnRQFJVhL90r3897j3wPVEzCmIuwlqA228loY+vdWkiGsfj6N
         vFpUVZe/SBJNW/xlLGh6h9xGpPhOC/rH+Y+lVlXkuoM0/gifBy7PVVm6Z4qIgfBov2Nb
         pU2Q==
X-Received: by 10.50.141.230 with SMTP id rr6mr9160239igb.89.1369829438525;
 Wed, 29 May 2013 05:10:38 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 05:09:58 -0700 (PDT)
In-Reply-To: <87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225798>

Thomas Rast wrote:
> So until this changes, my $0.02 is a blanket NAK and a refusal to spend
> my time reviewing.

Then don't review the damn thing.  With Felipe, I have the following
rule of thumb: make some concrete suggestions and forget about
follow-ups.  He's not going to accept any general guidelines, unless
you're quoting Documentation/SubmittingPatches (and even then, it's
subject to interpretation); so provide a commit message and hope that
either he or Junio will use it.  There is no guarantee that he will
take any of your suggestions, no matter how sensible you think they
might be.  However, he is a productive programmer, and submits fixes
to real issues.  He's stubborn, and we can't do much to change that:
just learn to work with him.  I'm disappointed that I have to point
this out: haven't you learnt anything from previous discussions with
him?

Felipe, I suggest you put this in your commit message:

   This patch implements --copy-notes for 'git cherry-pick' so it can
copy notes in the same way that 'git rebase' does.

That is, if it's not too much trouble.

Stop this back-and-fourth nonsense, both of you.  It's degrading the
community, and hitting everyone's inboxes with garbage.
