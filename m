From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Fri, 19 Sep 2008 08:26:00 +0530 (IST)
Message-ID: <816161.55725.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: dhruva <dhruva@ymail.com>, Jing Xue <jingxue@digizenstudio.com>,
	David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 04:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgWBG-0007L3-Rz
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 04:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbYISC4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 22:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324AbYISC4F
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 22:56:05 -0400
Received: from n4a.bullet.mail.tp2.yahoo.com ([203.188.202.98]:48839 "HELO
	n4a.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754223AbYISC4E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 22:56:04 -0400
Received: from [203.188.202.76] by n4.bullet.mail.tp2.yahoo.com with NNFMP; 19 Sep 2008 02:56:01 -0000
Received: from [202.43.196.225] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 19 Sep 2008 02:56:01 -0000
Received: from [203.212.168.61] by t2.bullet.tpe.yahoo.com with NNFMP; 19 Sep 2008 02:56:01 -0000
Received: from [203.104.18.49] by t2.bullet.kr1.yahoo.com with NNFMP; 19 Sep 2008 02:56:01 -0000
Received: from [127.0.0.1] by omp110.mail.in2.yahoo.com with NNFMP; 19 Sep 2008 02:56:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 915925.4522.bm@omp110.mail.in2.yahoo.com
Received: (qmail 59333 invoked by uid 60001); 19 Sep 2008 02:56:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=YqsNozwvQ2C5BjiKKuqe2eFvpplG27sQmCR8iIRYj0S1ZjeCq+GUDT5AGbb1x00si/VO/FqL/ThSzBApH5Csuy1hO0gt99zk9z16uzBQWW8cFjz7YUczhvRatKIq+PZmFeJK6dZtcukWAcRwJ62OkbLuXGg8pm84qU14/JpBq9k=;
X-YMail-OSG: QmB52IkVM1mOTT1Qw3nNW5nR4ZRYEyXoE5hoQmcv1bT4hcmESnoEovUwMuS7TE6qV2kYMNE3i9QwSYYd3q_LYDH5_wK8lg3AeOS.bUrt_nE7BBldFcqNgKhb4rBoeXONf8hf4askBjo63ilhdepE
Received: from [202.3.112.9] by web95003.mail.in2.yahoo.com via HTTP; Fri, 19 Sep 2008 08:26:00 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96256>

Hello,



----- Original Message ----
> From: dhruva <dhruva@ymail.com>
> To: Jing Xue <jingxue@digizenstudio.com>; David Brown <git@davidb.org>
> > 
> > How about collapsing the keywords in the _p4_ version after "p4 edit"
> > but before applying the patch, and just "p4 submit" the collapsed
> > version if patching succeeds? As pointed out earlier in this thread, p4
> > submit doesn't care about whether keywords are expanded or not anyway.
> 
> That is feasible but would require more changes. I still feel having an option 
> to disable the keyword from collapsing is a move forward followed by your 
> suggestion as a bug fix to fix the issue with 'p4 submit' when rcs keywords are 
> collapsed. Would that be an acceptable approach?
> 


If there are no more suggestions or objections, could we go ahead with patch? Personally, I would love to start seeing my small contributions getting into mainline and hence the shameless eagerness :)
-dhruva


      Add more friends to your messenger and enjoy! Go to http://in.messenger.yahoo.com/invite/
