From: Hans-Christoph Steiner <hans@at.or.at>
Subject: developing a modified Linux-style workflow
Date: Sun, 12 Dec 2010 17:24:16 -0500
Message-ID: <7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 23:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRuLA-0000cJ-Lo
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 23:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab0LLWYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 17:24:18 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41943 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057Ab0LLWYR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 17:24:17 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D2306E0
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 17:24:17 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 12 Dec 2010 17:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date; s=smtpout; bh=SGQz6+2LrVbtWpPsXyhOu4hwqGI=; b=EHZM1tcDHq2ZFijssY8IqwUYYwaF+O0L7MW2829DyCmuRyXvzLDyPKSogvpzZ0Ps/aRmzrIbdggswAvwePAHF8TbnpoOHFPaPqsMsWDR17EOrQMznP2GtvP6Skafgvh/cmNBRNMciPCXHK0MlqH6OQ1yjhB9nE2w5MJ+y4IcAik=
X-Sasl-enc: tWa88G/rUXgWYXXtTkZhA5ToA2yrmjZK2akufpKLc9tM 1292192657
Received: from palatschinken.lan (hq.nycresistor.com [216.254.98.120])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FF8E403A1E
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 17:24:17 -0500 (EST)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163495>


Hey all,

(and my second post on this list...)

I've gotten pretty good at git, and its helping me already with  
managing the very odd workflows I have with the software I work a lot  
on called Pd (http://puredata.info).  My role in Pd development is  
like a Linux lieutenant.

I also the main dev for an app called Pd-extended, which is based on  
Pd.  Now I'm stuck trying to figure out how to use git to match my  
current workflow for Pd-extended, which is a kind of long-lived  
branch, almost like a friendly fork.  So its kind of close to the  
Linux workflow with me as a lieutenant, but not quite.

What makes it tricky is that I make releases directly from my repo  
that are widely used.  So my repo is both lieutenant and dictator at  
the same time.  So that's where I am stumped.  I want to be able to  
rebase and push to a public repo, but that would be stupid.  So there  
has got to be another way.

.hc


----------------------------------------------------------------------------

I have the audacity to believe that peoples everywhere can have three  
meals a day for their bodies, education and culture for their minds,  
and dignity, equality and freedom for their spirits.      - Martin  
Luther King, Jr.
