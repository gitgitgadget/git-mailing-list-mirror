From: dhruva <dhruva@ymail.com>
Subject: Re: git-p4 and keyword expansion
Date: Mon, 8 Sep 2008 14:20:42 +0530 (IST)
Message-ID: <888021.6870.qm@web95013.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 10:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KccZt-0001Ij-Pd
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 10:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYIHI50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 04:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbYIHI50
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 04:57:26 -0400
Received: from n4b.bullet.mail.tp2.yahoo.com ([203.188.202.116]:38633 "HELO
	n4b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750894AbYIHI5Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 04:57:25 -0400
Received: from [203.188.202.70] by n4.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 08:57:24 -0000
Received: from [202.43.196.225] by t1.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 08:57:24 -0000
Received: from [203.212.168.61] by t2.bullet.tpe.yahoo.com with NNFMP; 08 Sep 2008 08:57:24 -0000
Received: from [203.104.18.48] by t2.bullet.kr1.yahoo.com with NNFMP; 08 Sep 2008 08:57:24 -0000
Received: from [127.0.0.1] by omp104.mail.in2.yahoo.com with NNFMP; 08 Sep 2008 08:57:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 423106.33195.bm@omp104.mail.in2.yahoo.com
Received: (qmail 8029 invoked by uid 60001); 8 Sep 2008 08:50:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=MYW0YqYF9SkMjrESctxeXEA0G9klg588G9mtLAjpURfnuvYPiqhPeoLi66P9MYfq6X4e9B3HDE22SpFipi1aDgKTFPYCfR6dX4gRCBWwBC+e7v48UuS99zYrFcY4TCbKrUKq5TfP6hALIAItWunH8h3gvfUjYs+xkqT0roWxf94=;
X-YMail-OSG: JSs6WBkVM1kvOTQeDYELsqDWuTDVeeero.j3POcOFxIroZz3Uyl__UhYpDRhNZ37TZEFEEk_M0B_hnzJHwGu4tZUnZe3HzV7o.VFW549w7fUBN_jVP3_XOz_F_.49_E-
Received: from [202.3.112.9] by web95013.mail.in2.yahoo.com via HTTP; Mon, 08 Sep 2008 14:20:42 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95231>

Hi,
 Nice to see some traction in this area, motivates me to work harder to solve this problem.



----- Original Message ----
> From: Tor Arvid Lund <torarvid@gmail.com>
> To: dhruva <dhruva@ymail.com>
> Cc: Git Mailing List <git@vger.kernel.org>
> Sent: Monday, 8 September, 2008 2:07:05 PM
> Subject: Re: git-p4 and keyword expansion
> 
> On Mon, Sep 8, 2008 at 10:27 AM, Tor Arvid Lund wrote:
> > Hi,
> >
> > On Mon, Sep 8, 2008 at 6:25 AM, dhruva wrote:
> >>  Removing the keyword unexpanding code in 'git-p4' with the following patch 
> makes it work:
> >
> > Yes, I have also experienced this problem, and haven't yet come up
> > with a solution to it. Your solution seems to solve the problem with
> > submitting to p4, but it would also mean that files cloned from p4
> > would have diffs in the git database whenever the p4 headers changed.
> 
> Hmm... Now that I think about it... Maybe we _want_ the extra diff
> hunks... Personally I don't care much for the keyword expansions, but
> since they're there in p4, and p4 diff shows a diff hunk there, maybe
> we should just do the same. In which case your original patch might be
> just fine. I realise I haven't had my morning coffee yet. Me
> confused... :-/
> 

I was drafting my reply and saw your response. The only area I am not sure it git-p4 handles is a rename/copy of an existing file. If that depends on heuristics based on diff, that might fail due to keyword expansions. I will look closer into the git-p4 script today.

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail..com. Click here http://in.promos.yahoo.com/address
