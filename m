From: Mihamina Rakotomandimby <mihamina@bbs.mg>
Subject: help on importing
Date: Sun, 19 Jun 2011 18:03:48 +0300
Message-ID: <20110619180348.576ea06e.mihamina@bbs.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 17:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJei-0000cw-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab1FSPLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:11:14 -0400
Received: from smtp-out.malagasy.com ([41.204.104.33]:43823 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab1FSPLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:11:13 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jun 2011 11:11:13 EDT
Received: from smtp-2.blueline.mg (unknown [41.204.104.56])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-out.malagasy.com (Postfix) with ESMTPS id 9ECA28DF4B
	for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:03:59 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by smtp-2.blueline.mg (Postfix) with ESMTP id 9064260065
	for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:03:59 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -4.027
X-Spam-Level: 
X-Spam-Status: No, score=-4.027 required=7 tests=[ALL_TRUSTED=-1.8, AWL=0.372,
	BAYES_00=-2.599]
Received: from smtp-2.blueline.mg ([41.204.104.56])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id O37Bp4SEwHE6 for <git@vger.kernel.org>;
	Sun, 19 Jun 2011 18:03:53 +0300 (EAT)
Received: from packard.rktmb.org (staff-104-10.malagasy.com [41.204.104.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mihamina@bbs.mg)
	by smtp-2.blueline.mg (Postfix) with ESMTPSA id 2466F6004E
	for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:03:52 +0300 (EAT)
X-Mailer: Sylpheed 3.1.0beta2 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176001>

Hi all,

I made several commits to a small local program.
When I list them with "git log" I see them.

To publish my work, I choosed to sign in a forge (like github, google
code,...). I choosed forge.ocamlcore.org

With my account creation, the forge automatically created an empty GIT
repository.

I clone it with:
  git clone git+ssh://rakotomandimby@forge.ocamlcore.org/gitroot/ocaml-crypt/ocaml-crypt.git
  Initialized empty Git repository in /tmp/ocaml-crypt/ocaml-crypt/.git/
  warning: You appear to have cloned an empty repository.
I am surprised the initialisation is not in /tmp/ocaml-crypt/ocaml-crypt.git/.git/ 
as I pulled "ocaml-crypt.git".

Anyway...
When add+commit a file into "/tmp/ocaml-crypt/ocaml-crypt/", 
I get no errors, but when pushing:
  $ git push
  No refs in common and none specified; doing nothing.
  Perhaps you should specify a branch such as 'master'.
  fatal: The remote end hung up unexpectedly

I dont understand...

If I have success on this first simple steps, 
I could switch to the next level: Importing my local commits
to that cloned repository ans then push that all.

I read several GIT documentation, but it seems I dont have the 
right keywords to have good results...


Would you help?

-- 
RMA.
