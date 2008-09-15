From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 12:01:33 +0530 (IST)
Message-ID: <888385.13417.qm@web95013.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7dd-00018Q-DB
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYIOGbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYIOGbh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:31:37 -0400
Received: from n4b.bullet.mail.tp2.yahoo.com ([203.188.202.116]:41441 "HELO
	n4b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751187AbYIOGbg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:31:36 -0400
Received: from [203.188.202.76] by n4.bullet.mail.tp2.yahoo.com with NNFMP; 15 Sep 2008 06:31:34 -0000
Received: from [202.43.196.224] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 15 Sep 2008 06:31:34 -0000
Received: from [203.212.168.60] by t1.bullet.tpe.yahoo.com with NNFMP; 15 Sep 2008 06:31:34 -0000
Received: from [203.104.18.51] by t1.bullet.kr1.yahoo.com with NNFMP; 15 Sep 2008 06:31:34 -0000
Received: from [127.0.0.1] by omp112.mail.in2.yahoo.com with NNFMP; 15 Sep 2008 06:31:34 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 66625.19863.bm@omp112.mail.in2.yahoo.com
Received: (qmail 13474 invoked by uid 60001); 15 Sep 2008 06:31:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DxzyUyG8TyH+MmtY7lHBJ0a0x8N+GXIyR7fGix8dmk6nUS9FP3nxC2g0HL8t6XpuYNUQQOaA3hPEFO4f61X2MvSs1Y9wLQ9XSyb9kMjzuBQ9MIwCC3DCeI7P7W62YyXYFd/OZjFwBCEdl3/SJ+nkoyk/ri4MP8Ni+zzZ7dCefsI=;
X-YMail-OSG: GQEgukgVM1m0eztALsIIkERA8yAKnY3qcfksqmg_goWRX3fFWY6RxRhdDUIeT.ylrqzn.5Ozd_ZuX.lwbYNOwsUmAvGuU8MnGd.IdR21V52pUEIX3RHOv6dxd77pEcs-
Received: from [202.3.112.9] by web95013.mail.in2.yahoo.com via HTTP; Mon, 15 Sep 2008 12:01:33 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95881>

Hello,



----- Original Message ----
> From: Junio C Hamano <gitster@pobox.com>
> To: Dhruva Krishnamurthy <dhruva@ymail.com>
> Cc: GIT SCM <git@vger.kernel.org>
> Sent: Monday, 15 September, 2008 11:47:19 AM
> Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
> 
> Dhruva Krishnamurthy writes:
> 
> > Modifying RCS keywords prevents submitting to p4 from git due to missing 
> hunks.
> 
> Hmm.  How are "missing hunks" caused?  Do you mean:
> 
> - the substituted values from the expanded keywords are stripped out by
>    default (with kwstrip=True) when you check out from p4;
> 
> - when you submit your changes back, p4 side expects you to send the file
>    with keywords just as it originally expanded;
> 
> and this causes the contents mismatch, leading p4 to reject your change?

Yes (you got my point ;), I have quite often stumbled in conveying things in a crisp manner (on going learning process)

> The patch itself looks fine; I just wanted to make sure commit log
> explains what was fixed.

-dhruva



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
