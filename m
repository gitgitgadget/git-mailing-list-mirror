From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 17:49:09 +0530
Message-ID: <CALkWK0ndinJPeufokYUiPeC_Hs=9WA71Xpd=K6vimJseXJsAOA@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <7vsj2e1d83.fsf@alter.siamese.dyndns.org> <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 14:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVhd6-0005ve-70
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 14:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab3DZMTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 08:19:52 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48602 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3DZMTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 08:19:51 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so4791642ieb.41
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uH1GCm84pRw5428KdBBfu/BXwNQWAqLEK/Tr5xzRZJc=;
        b=okK0buQb67DCIeR7WnYVnOq23stD/JmMH8WMQekfVdMgP/xTJKMmRU5nYBbjIKIeZ9
         XHnNIlB1t2EEx8Pz9G647xo9ce6eQT0wdkNuTpTxwMaF/5nCF41Ii+rxmYMAN41UeZzx
         zIba6sIj6Sl1v1rNm9kJUjI0Q8OxIJqlyRiJdk/LJDDOpcz5pAhQ3gbKHC3KkUfPspmx
         GbmOeBpddO7gpGHnaJpPPfj7IHehOlcjD8/4TlmeFnKDaXnWRfcpjXSIjhNnJEB40d6o
         lay52KWWj8Rlo6p6kD3f58mIrQ/ufuX4Q8vcII9IWP8eBSbVaF/RKCQ4R+mSlzeqmiPm
         VdwA==
X-Received: by 10.50.57.200 with SMTP id k8mr1684624igq.44.1366978790915; Fri,
 26 Apr 2013 05:19:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 05:19:09 -0700 (PDT)
In-Reply-To: <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222529>

Felipe Contreras wrote:
> Any sensible reviewer would be context aware, notice that this
> is a contrib patch, and focus on behavioral changes, notice the
> mistake I made, and point that *one* of the changes was changing the
> behavior, at which point I would agree and reroll either without that
> change, or with the change in a separate commit (which I don't want to
> do right now). The maintainer (you), wouldn't even have to reply at
> all.

Personally, I think it is the job of the submitter to provide a really
helpful commit message and widen his review audience.  If I'm hitting
the git mailing list with my patches, I try to make sure that nearly
everyone on the list can understand what I've done and potentially
review it.  Why else would I want to hit their inboxes with my
patches?

Here's my solution to the problem: maintain your project outside
git.git and merge changes in every couple of months or so with a
simple email containing a pull URL, addressing Junio.  If Junio trusts
you enough to put the changes you send into contrib/ after a cursory
glance, we're done.  Start a separate mailing list for your project/
accept GitHub pull requests via which contributors can send you
changes.  No more fuss or drama on the git list about this.  You can
be as stubborn as you want, and we go back to our lives.  Everyone
wins.

If you want to submit patches to other parts of git, you seriously
need to change your ways.  Let's deal with that problem when it arises
next.
