From: Bill Lear <rael@zopyra.com>
Subject: How to pull only a few files from one branch to another?
Date: Tue, 23 Jan 2007 21:24:42 -0600
Message-ID: <17846.53626.895660.762096@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 04:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Ykg-0005cM-Lt
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 04:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbXAXDYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 22:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbXAXDYn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 22:24:43 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60259 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030196AbXAXDYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 22:24:43 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0O3OhV06422;
	Tue, 23 Jan 2007 21:24:43 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37600>

I have a long-running topic branch.  I have fixed a few nits on
the master branch that I would like on the topic branch.  How do I
pull in only a few files from the head of the master branch?

I tried all sorts of incantations (I am running 1.5.0-rc2), including:

git pull . origin foo.cc
git pull origin foo.cc
git pull foo.cc master
git pull . master foo.cc
git pull master foo.cc


Bill
