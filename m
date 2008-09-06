From: Thomas Koch <thomas@koch.ro>
Subject: Howto forward workdir to HEAD
Date: Sat, 6 Sep 2008 23:32:39 +0200
Message-ID: <200809062332.39147.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 08:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcDar-0005El-9S
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 08:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYIGGQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 02:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYIGGQn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 02:16:43 -0400
Received: from koch.ro ([195.34.83.107]:50416 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751587AbYIGGQm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 02:16:42 -0400
Received: from 136-35.62-81.cust.bluewin.ch ([81.62.35.136] helo=noname)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1KcDZe-0007HR-M3
	for git@vger.kernel.org; Sun, 07 Sep 2008 08:16:38 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95119>

Hi,

I'm trying to setup an intranet Webapp using GIT for maintanance and
backup. First I created a git repo on my working machine and imported
the webapp, made some changes.

Then I created a normal, non-bare repo at the server and pushed from my
local repo into the server repo, checked out branch "stable" and
everything is fine.

Now I made a local change and pushed again, but the servers workdir is
not automatically forwarded to the pushed state. How do I forward it?

Can I define a Hook that automatically forwards the workdir after a
push, but only if the workdir is clean?

What do you think of this method to deploy a webapp?

Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro
