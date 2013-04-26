From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 01:58:08 +0530
Message-ID: <CALkWK0kTf_U3NMLTXS-spW-TbZ2x6-46EyEQtD6ZrZK2Tw-91w@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
 <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
 <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
 <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com> <CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpGI-0003ql-8G
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab3DZU2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:28:49 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:56167 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab3DZU2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:28:48 -0400
Received: by mail-ia0-f176.google.com with SMTP id l27so3555852iae.35
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fY/IiqraHCoZXo7ODwIga2/RK5wRdFU4Zlsln/nRpWA=;
        b=qImWQxVPer5raBZ1rO8nycJypYD0DQ6ytZYxGzkZ9sjYVrGdqAKdvxfps6Unyf+UzH
         ZGdICEMp4iwbbXTWp5+ovPK/fUcL2vurN8xqnvIEvSGL25a8Y8u/tKg+svQrIx/9pzSx
         JmIMsuVHZQlRh1OHNsB8T/lewkIFO6J0UHvbg3c9AwJV+yGvRmmWuGmqKZvNVMq16ZlM
         hvhM7s6GH+UOXKKACIL8MadGNJa7kdPL1vEAjq9SiRG76dpk/8toIiQsN/5HMNk7UceL
         J9ivCn2+Na/gzJgEjYNkQ72cIZpjLDl6aSxeOVleHkG/PBYOl7RUHYM+b4fHmGamAU2t
         u5Kw==
X-Received: by 10.50.72.65 with SMTP id b1mr2834899igv.63.1367008128325; Fri,
 26 Apr 2013 13:28:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 13:28:08 -0700 (PDT)
In-Reply-To: <CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222575>

Felipe Contreras wrote:
> If you are so keen in receiving feedback from your fellow developers,
> you should eventually send an email summarizing the issues and the
> proposal for everyone to understand.

Thanks.  I'll do that in the morning.

> Reason is not a tool for appreciating art, reason is a tool for
> discovering truth, and if when arguing you are not interested in what
> is actually true, I'm not interested in arguing with you.

There is no great truth to be discovered by arguing about the length
of commit messages, Felipe.  There are some "guidelines" or "axioms"
upon which we build reason.  If you want to argue till everything
breaks down to Peano's Axioms, do Foundations of mathematics or
Analytical philosophy.  From personal experience, it's much more
satisfying than arguing with other humans (who aren't exact
creatures).

> I appreciate your criticism, but that doesn't mean I must agree with
> it. And if I do agree, that doesn't mean I must act upon it.

Why not?  Am I being unreasonable in asking you to justify your
changes, so I can understand what you've done with one quick reading?
