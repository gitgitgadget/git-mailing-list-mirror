From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Windows: git-shell can be compiled again
Date: Mon, 8 Sep 2008 17:42:26 +0530 (IST)
Message-ID: <117629.48595.qm@web95011.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Kevin Yu <yujie052@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 14:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcfcg-00087I-SE
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 14:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbYIHMMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 08:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbYIHMMc
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 08:12:32 -0400
Received: from n5.bullet.mail.tp2.yahoo.com ([203.188.202.86]:38171 "HELO
	n5.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751605AbYIHMMb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 08:12:31 -0400
Received: from [203.188.202.76] by n5.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 12:12:30 -0000
Received: from [202.43.196.224] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 12:12:29 -0000
Received: from [203.212.168.61] by t1.bullet.tpe.yahoo.com with NNFMP; 08 Sep 2008 12:12:29 -0000
Received: from [203.104.18.54] by t2.bullet.kr1.yahoo.com with NNFMP; 08 Sep 2008 12:12:29 -0000
Received: from [127.0.0.1] by omp106.mail.in2.yahoo.com with NNFMP; 08 Sep 2008 12:12:27 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 291752.97313.bm@omp106.mail.in2.yahoo.com
Received: (qmail 48945 invoked by uid 60001); 8 Sep 2008 12:12:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KyRo4FbXmtBv8BiN0FXoxnOnKRuMJtMCdkwaoJDojPHkCIPVVWoTXNQBJk/rzkQoKQmykwegdkmI18o03ihuldfKJW5bEIpLt4SPJQL0caxJLR2iOMTdZLh7PSY53MKkTEeqnbzjEIImfejQHQyu03bnR3GxzgwQwGCM6GosT9I=;
X-YMail-OSG: h9qhCpQVM1mQ2Fj0P9svyiPADb4bIeTSLcbNhT2jEsgxkXDbKpEDadAnDrUN.EZpDqIPL8FzcqPv1s.if.o3UZ.Pq5e.aMFTCR.XxQPSGdEG53ZqKqIG5DyW6lR_P1Q-
Received: from [202.3.112.9] by web95011.mail.in2.yahoo.com via HTTP; Mon, 08 Sep 2008 17:42:26 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95243>

Hi,



----- Original Message ----
> From: Johannes Sixt <j.sixt@viscovery.net>
> In order of increasing difficulty:
> 
> - Run the tests on different platforms and servicepack levels.

I have no access to multiple boxes but when more people start using git locally, I will try that.
 
> - Find a way to build perl scripts that is acceptable for upstream git.git
> and that also works on MSYS/MinGW. Currently we still modify the build
> procedure, and the results do not work during 'make test'.

Could you please elaborate on the above. Do you mean, rewrite some perl scripts or something else?
 
> - Give some love to git-svn.perl. It will be removed from msysgit's
> 1.6.0.x release because it raises expectations that cannot be fulfilled.

Since I do not work on SVN, that would be tough in the present state for me. SVN does not even ship their perl bindings for perl 5.10 and I just could not build it from source. I was considering hacking 'svk' to bring back p4 support (which has been dropped in its current avatar).

> Please dig the list archive: http://groups.google.com/group/msysgit

I will look into it.
 
> I don't think a lot can be done performance-wise unless you want to help
> port scripts to C.

No promises here as I do not know the complexity of perl scripts.

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
