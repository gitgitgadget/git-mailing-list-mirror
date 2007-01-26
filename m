From: Bill Lear <rael@zopyra.com>
Subject: Commit through git.el evades commit hook
Date: Fri, 26 Jan 2007 17:28:59 -0600
Message-ID: <17850.36539.972386.69800@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 00:29:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAaVD-0008IB-WC
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbXAZX3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbXAZX3B
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:29:01 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61219 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbXAZX3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:29:00 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QNT0s00577;
	Fri, 26 Jan 2007 17:29:00 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37898>

Apparently git.el does not invoke the commit hook when committing a
file.  This seems like an egregious error.  Am I perhaps overlooking
something obvious?


Bill
