From: Bill Lear <rael@zopyra.com>
Subject: Optimizing repository speed
Date: Mon, 19 Feb 2007 08:37:38 -0600
Message-ID: <17881.46642.843674.49482@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 15:37:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ9eF-0000sj-IP
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 15:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXBSOho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 09:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXBSOho
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 09:37:44 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60893 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295AbXBSOhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 09:37:43 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1JEbhe11066;
	Mon, 19 Feb 2007 08:37:43 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40127>

As part of our conversion to git 1.5, I would like to ensure that
our code repository does not get crufty and slow.  Currently, I have
a cron job that runs each morning that does a 'git repack -a -d'.

I know there is 'git-gc', and it appears to do all sorts of good
things.  Can I simply replace my call to 'git repack -d -a' with 'git
gc', or is there anything else I might want to do?


Bill
