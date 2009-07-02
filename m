From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT] missing feature: writing of a detached HEAD
Date: Thu, 2 Jul 2009 21:05:37 +0000 (GMT)
Message-ID: <946532.38891.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Shawn Spearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 23:05:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMTTY-0005u0-6C
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 23:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZGBVFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZGBVFg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 17:05:36 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:46021 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753456AbZGBVFg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 17:05:36 -0400
Received: (qmail 40912 invoked by uid 60001); 2 Jul 2009 21:05:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1246568737; bh=KjxOEggjV5D1y1mdtstrqPsDJKSB8jswU0ccDRtKgLY=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=pzuvWMbZeK5HlEupLA4lt/lCzsljc93JXsma1vdS1KFa7EKznDW+uSj4pk9EX6p3boMGRng2cUP1e0+ksHDbSZG8xyPoY7QkmVtfqLMg0eLVMaw0No2x0vK1NG4RjClAU7Wd5kugF3e/kODIRASk3Qf6rZGnFrEbMeonXJxg9C0=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1GVY2gXOl3c2pevdtWCrpJXTCY5mpczL4mzY+sWpoTNfbF+FnWfuKIb8+z03PEAHIpwzyXWktnpTljWG7nXrPJu/C5HNcvEnTMrZMm9V3cCRNjC6c1b0dy2rOng5Kn6PfTTGEk7Ik1GLejSQyC+Yfp+dUWcM8C8P8KVHj+Ge83g=;
X-YMail-OSG: QsYbW2QVM1kzPIzzXUm1fICMn1CvJvxSuGSOHMrJuH2NJFPJvW5mFskmWivh0Lyrl7JOJK8cGlX6nEaMRtglWcBGf0uo.yr9iWX7AYmy4QVv.59iCr1IDg_ZLYucxzHSHb8UJ7X9T2gdiCRr2VNz.yVGbb.qS4tW6540YmvWwPAPL83oqDUt.OgBAb3M.pWq6OlZCOziqNX939sI.ADYr14XeU_rvza4SUMEWnI7Rci7zZgjyHDhIE0g8mcVAzh1DwnaxQFz6fWUcr_QHb1JGPKavaL6cAU1xbeKiOv3eKSaI58akw--
Received: from [81.3.214.196] by web27803.mail.ukl.yahoo.com via HTTP; Thu, 02 Jul 2009 21:05:37 GMT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122672>


Hi!

As discussed with Shawn and Ilari on IRC, JGit is currently missing a way to write a detached HEAD.

I need this to implement a checkout of tags with JGit.

txs and LieGrue,
strub


      
