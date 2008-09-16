From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 19:03:40 +0530 (IST)
Message-ID: <410359.9532.qm@web95013.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: Jing Xue <jingxue@digizenstudio.com>, David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfaoI-0000D5-RB
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYIPNkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 09:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYIPNkb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:40:31 -0400
Received: from n8.bullet.mail.tp2.yahoo.com ([203.188.202.89]:43910 "HELO
	n8.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751782AbYIPNkb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 09:40:31 -0400
Received: from [203.188.202.70] by n8.bullet.mail.tp2.yahoo.com with NNFMP; 16 Sep 2008 13:40:29 -0000
Received: from [202.43.196.224] by t1.bullet.mail.tp2.yahoo.com with NNFMP; 16 Sep 2008 13:40:29 -0000
Received: from [203.212.168.60] by t1.bullet.tpe.yahoo.com with NNFMP; 16 Sep 2008 13:40:29 -0000
Received: from [203.104.18.52] by t1.bullet.kr1.yahoo.com with NNFMP; 16 Sep 2008 13:40:29 -0000
Received: from [127.0.0.1] by omp113.mail.in2.yahoo.com with NNFMP; 16 Sep 2008 13:40:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 405259.70294.bm@omp113.mail.in2.yahoo.com
Received: (qmail 9662 invoked by uid 60001); 16 Sep 2008 13:33:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=bWYHknNBvpQmKsqdRsfrEpZwQxqk8EpPoh1JX23swJPpW18MjHY97/XimXslzXHQeNHuvca0mkLZl2FU/cfrh9SbWntQbvjaN5d97od9AW8HDE9koxqKlESAa8Zn3M8p4uGoeZchMZv5Y7sx1EHPOtmtGP18XaThITbJ2jIJ0nw=;
X-YMail-OSG: FP_Zhv0VM1noC23kTzAgcVHSJselm1BHpZ411_cuEV1FJMbeJCY1Z37HUQUrajw.kAJLJ32Pts29z30WMCGRq7yTW.70NvaHBes4lTlsxZu0SMDftqMgs_gOGCLZGR4-
Received: from [202.3.112.9] by web95013.mail.in2.yahoo.com via HTTP; Tue, 16 Sep 2008 19:03:40 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96003>

Hello,



----- Original Message ----
> From: Jing Xue <jingxue@digizenstudio.com>
> To: David Brown <git@davidb.org>
> Cc: Daniel Barkalow <barkalow@iabervon.org>; Junio C Hamano <gitster@pobox.com>; dhruva <dhruva@ymail.com>; GIT SCM <git@vger.kernel.org>; Simon Hausmann <simon@lst.de>
> Sent: Tuesday, 16 September, 2008 6:28:56 PM
> Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
> 
> On Mon, Sep 15, 2008 at 09:12:01PM -0700, David Brown wrote:
> > A simple way to be paranoid would be something (shell-ish) like:
> >
> >   p4 print filename | collapse-keywords | git hash-object --stdin
> >
> 
> How about collapsing the keywords in the _p4_ version after "p4 edit"
> but before applying the patch, and just "p4 submit" the collapsed
> version if patching succeeds? As pointed out earlier in this thread, p4
> submit doesn't care about whether keywords are expanded or not anyway.

That is feasible but would require more changes. I still feel having an option to disable the keyword from collapsing is a move forward followed by your suggestion as a bug fix to fix the issue with 'p4 submit' when rcs keywords are collapsed. Would that be an acceptable approach?

-dhruva



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
