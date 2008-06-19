From: Mukund Sivaraman <muks@banu.com>
Subject: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 21:12:52 +0530
Message-ID: <20080619154251.GA16475@jurassic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 18:03:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Mbz-0004MR-Fi
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761534AbYFSQCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 12:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761538AbYFSQCp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 12:02:45 -0400
Received: from mail.banu.com ([67.19.28.195]:36727 "EHLO mail.banu.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761528AbYFSQCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 12:02:44 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2008 12:02:44 EDT
Received: from ? (unknown [59.93.81.46])
	by mail.banu.com (Postfix) with ESMTP id 486701110066;
	Thu, 19 Jun 2008 10:42:57 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85486>

Hi all

We have two public branches on the tinyproxy project[1]: master and 1.6.
We send patches to the mailing list to get them reviewed before they are
applied and pushed to the public repo.

When i use "git format-patch", it doesn't seem to include the branch (or
remote) name in the email it creates. So a reader of this mail may not
know what branch to apply it on to test it. Aside from adding in branch
information manually in the body of the message, is there any other
existing way to get git format-patch to include it?

Apologies in advance if this is a stupid question.

		Mukund

Refs:
 1. http://git.banu.com/?p=tinyproxy;a=summary
