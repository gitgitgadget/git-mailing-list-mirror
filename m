From: Jeff Garzik <jgarzik@pobox.com>
Subject: [RFC] git email submissions
Date: Wed, 16 Nov 2005 09:38:42 -0500
Message-ID: <437B4472.1080401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 15:41:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcOR0-0002TT-1S
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 15:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVKPOir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 09:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVKPOir
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 09:38:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030347AbVKPOir (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 09:38:47 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EcOQu-0004Fd-72
	for git@vger.kernel.org; Wed, 16 Nov 2005 14:38:46 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12026>


For people without _any_ hosting, it would be nice to give them a method 
to submit some git changes via email.

It seems like most of the necessary stuff is already present in git to 
bundle up a set of changes.  The open questions in my mind are

- what form would the emails take?  MIME-attach a .pack file, plus a 
GPG-signed sha1sum in a separate attachment?

- what's the easiest user interface for selecting the changes?  for my 
usage, it would be

	GIT_GPG_AUTHOR=jgarzik... \
	GIT_DEF_HEADERS=./email.headers \
	git-mkmail --sign master..upstream > email.rfc822
	Enter GPG passphrase:

- what user interface does a kernel maintainer use, to merge changes 
submitted using this method?

- is this all pointless, since the submittor could just email patches? 
[IMO no, git trees are better merges than emailed patches]

Overall, I was thinking it would be nice to have some way to safely 
transmit a small part of a git tree, including all history information, 
since its easier to merge git trees than patches.

And for someone without the resources to obtain hosting, email may be 
the only way to publish a git sub-tree.

	Jeff
