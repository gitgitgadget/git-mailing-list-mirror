From: Chris Frey <cdfrey@foursquare.net>
Subject: git log --grep missing entries?
Date: Tue, 27 May 2008 16:28:42 -0400
Message-ID: <20080527202842.GA32252@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:30:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15o1-0005Tq-4Q
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864AbYE0U3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbYE0U3F
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:29:05 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:33633 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbYE0U3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:29:05 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4RKSgYf009002
	for <git@vger.kernel.org>; Tue, 27 May 2008 16:28:42 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83043>

Hi,

I ran into this the other day when I was looking at jgit's log history.
I retested today with the latest master branch, and it does the same thing.

So... what am I doing wrong?

	git clone git://repo.or.cz/egit/spearce.git bsd
	git log |grep "^Author:" | sort | uniq

	# note the user: Thad Hughes <thadh@thad.corp.google.com>

	# nothing appears for these commands
	git log --grep="thadh@thad.corp.google.com"
	git log --grep="google.com"
	git log --grep="thadh"

	# this works
	git log --author="thadh@thad.corp.google.com"

	# this works
	git log | grep thadh@thad.corp.google.com

- Chris
