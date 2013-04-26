From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Sat, 27 Apr 2013 00:23:09 +0530
Message-ID: <CALkWK0mHCNdr7+QxmmB3jTnWTe8q0_ipXD0=1bKQdpLK07gnAg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 26 20:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnmO-0007ct-5j
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab3DZSxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:53:51 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:51460 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab3DZSxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:53:50 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so3976726iag.14
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nQPfI52c48DVS1nxrxveGNl99Qn7JK3v1Ci5dN2IvsE=;
        b=aIke8KC8TAQOPwsAgnathWi/UbcqnKnpBVHtbUKxczT912OVwk26Ewhmj4nOe8mSBJ
         7tAV3nLkwhOxtZdJhzIkHFhGTTfl3ZQOHZJ5q5KxFw3QLt66ogqjefHzRhTO/qhiqMxu
         A3R+MEVwYzpPCSpo3naI0W6X0YVseg5YVGO4RNf4cV5uTlGNoN8xwu78uZfYUlanlZYu
         FbuT5j2NG5rM5/Ky2NQWts2CXKpj1wCfW19cedHUp6MqLOjyra3v0rjxaLix0cOk96sj
         TsBKy9ZAybn2R2VxEit8W6Y6eRAZ4ptsLa0GVobYydl8w2QMC3SqIA6YEA2ekfkHdB9h
         LuEg==
X-Received: by 10.50.57.116 with SMTP id h20mr2655616igq.49.1367002430080;
 Fri, 26 Apr 2013 11:53:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 11:53:09 -0700 (PDT)
In-Reply-To: <CAMP44s1MHUc_jw5EQviSYWc9phWCYD-FK_gRA-0QYNcLix098w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222553>

Felipe Contreras wrote:
> What is your objective, do you want to help this project move forward or not?

Forward, please.

I want a solution to this persistent problem of conflict though.  And
I presented one in my previous email:

Here's my solution to the problem: maintain your project outside
git.git and merge changes in every couple of months or so with a
simple email containing a pull URL, addressing Junio.  If Junio trusts
you enough to put the changes you send into contrib/ after a cursory
glance, we're done.  Start a separate mailing list for your project/
accept GitHub pull requests via which contributors can send you
changes.  No more fuss or drama on the git list about this.  You can
be as stubborn as you want, and we go back to our lives.  Everyone
wins.

I'll probably even contribute small patches once in a while.
