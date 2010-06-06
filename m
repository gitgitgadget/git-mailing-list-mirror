From: Johan Herland <johan@herland.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 06 Jun 2010 20:34:19 +0200
Message-ID: <201006062034.19471.johan@herland.net>
References: <20100605110930.GA10526@localhost>
 <20100606161805.GA6239@coredump.intra.peff.net>
 <20100606165554.GB10104@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Rabbitson <ribasushi@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 20:36:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLKho-00021E-WE
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 20:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0FFSeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 14:34:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54715 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab0FFSeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 14:34:21 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3L0096SVL8U700@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Jun 2010 20:34:20 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 10A241EA563D_C0BEA2CB	for <git@vger.kernel.org>; Sun,
 06 Jun 2010 18:34:20 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id ED2E61EA3566_C0BEA2BF	for <git@vger.kernel.org>; Sun,
 06 Jun 2010 18:34:19 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3L0088PVL7OK10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Jun 2010 20:34:19 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <20100606165554.GB10104@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148534>

On Sunday 06 June 2010, Clemens Buchacher wrote:
> On Sun, Jun 06, 2010 at 12:18:05PM -0400, Jeff King wrote:
> > Moreover, the burden for arguing against it is a little higher. It is
> > no longer "I think this is a bad idea" but "I think this is a bad
> > idea, and it is so bad that it is worth changing behavior that users
> > may have become accustomed to".
> 
> I argue that people are more likely to be surprised and confused by
> this feature rather than being accustomed to it already. I am also
> waiting to hear from someone who actively uses this feature.

I use this feature all the time, and find it very nice and useful.

Moreover, at $DAYJOB, we have a lot of Git newbies (many of them still can't 
properly juggle remote branches. remote-tracking branches, and local 
branches with tracking info). They mostly work on local topic branches that 
tracks corresponding shared topic branches in a central repo. For them, 
switching to one of these topic branches is simply a matter of 'git checkout 
<branchname>', without having to care (or know) if you've already created 
the local branch or not. In this case, Git really does the Right Thing (tm) 
for us.

In several cases this DWIMmery has prompted people to update from an old Git 
version, just to get this feature.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
