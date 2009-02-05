From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Git's static analysis
Date: Thu,  5 Feb 2009 21:40:04 +0000
Message-ID: <1233870004-63540-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 23:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVCQE-0003rL-Ai
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 23:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZBEWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbZBEWIm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 17:08:42 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:38875 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751562AbZBEWIm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 17:08:42 -0500
X-Greylist: delayed 1708 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 17:08:42 EST
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LVBx7-0005ws-Ak; Thu, 05 Feb 2009 21:40:05 +0000
Received: from [82.41.227.224] (helo=localhost.localdomain)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LVBx6-0003Kk-Pd; Thu, 05 Feb 2009 21:40:04 +0000
X-Mailer: git-send-email 1.6.1.2.458.g9de76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108628>

Hi all,

I played around a bit with the 'Clang' static analyser, and tried to run git's
source code through it. It comes up with a few possible errors, so I thought
you might find it interesting. I took a quick glance, and it also seems to
have a few false positives, but it might still be worth to take a look.

The results can be found here:

	http://frim.frim.nl/git-analyse/

- Pieter
