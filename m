From: dhruva <dhruva@ymail.com>
Subject: Re: git-p4 and keyword expansion
Date: Tue, 9 Sep 2008 16:44:11 +0530 (IST)
Message-ID: <665268.90219.qm@web95009.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GIT SCM <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 13:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd1Bp-00077m-RM
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 13:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYIILOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 07:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbYIILOP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 07:14:15 -0400
Received: from n1a.bullet.in.yahoo.com ([202.43.219.18]:36655 "HELO
	n1a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751566AbYIILOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 07:14:14 -0400
Received: from [202.86.4.170] by n1.bullet.in.yahoo.com with NNFMP; 09 Sep 2008 11:14:11 -0000
Received: from [203.104.18.53] by t1.bullet.in.yahoo.com with NNFMP; 09 Sep 2008 11:14:11 -0000
Received: from [127.0.0.1] by omp105.mail.in2.yahoo.com with NNFMP; 09 Sep 2008 11:14:11 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 745435.77688.bm@omp105.mail.in2.yahoo.com
Received: (qmail 90620 invoked by uid 60001); 9 Sep 2008 11:14:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=wPBNGDvJx7dTYBi7Nv8mO0eiuobLOLcxtjbqR50rvIXMy+TnERhbvbH+Cl8U/RyjHuuk0D9hQ2mhQAUWVIzbBjblXCmtMk8o1rfEmOWTu7PMaVHcQJ+dYiUsmQhgeZOys58Z1dVEt28tcl1+oGVx/Bvqj3Zcju3NhgGAF5MLpWM=;
Received: from [202.3.112.9] by web95009.mail.in2.yahoo.com via HTTP; Tue, 09 Sep 2008 16:44:11 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95374>

Hello,



----- Original Message ----
> From: Jing Xue <jingxue@digizenstudio.com>
> To: dhruva <dhruva@ymail.com>
> Cc: GIT SCM <git@vger.kernel.org>
> Sent: Tuesday, 9 September, 2008 3:09:00 AM
> Subject: Re: git-p4 and keyword expansion
> >  Removing the keyword unexpanding code in 'git-p4' with the  
> > following patch makes it work:
> 
> I'm not really arguing against the patch itself, but just wondering  
> whether it would be a good idea to make it optional or configurable.

I feel the configuration must be set the first time only, when you clone using 'git-p4 clone'. Altering it in between will be very confusing! Ideally, the setting must be transferred when the git repo (cloned from git-p4) is cloned using standard git. Is it something possible (well, I am new to git and am exploring. Any extra information would help).

My proposal is as follows:
1. Add an extra command line argument to 'git-p4 clone' to either enable/disable keyword expansion
2. Store that information under the .git folder in a file that is copied when someone clones that repo
3. Use the stored information in future 'git-p4 sync/rebase'

> IIUC, there are reasons for git to discourage keyword expansion - for  
> instance as discussed in this thread:
> 
> http://kerneltrap.org/mailarchive/git/2007/10/11/335112

I agree that keyword expansion is bad but there is no alternative when you work with a system that has keyword expansion and you need interoperability (p4<->git)

-dhruva



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
