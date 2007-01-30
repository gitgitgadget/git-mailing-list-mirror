From: Bill Lear <rael@zopyra.com>
Subject: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 12:05:38 -0600
Message-ID: <17855.35058.967318.546726@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 19:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxMY-00008Y-59
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965669AbXA3SFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965673AbXA3SFm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:05:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60167 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965669AbXA3SFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:05:42 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UI5fD25584;
	Tue, 30 Jan 2007 12:05:41 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38175>

I don't understand why clone (version 1.4.4.1) is not checking out my
files:

% ls /repos/git/project
branches  description  HEAD   info     refs
config    FETCH_HEAD   hooks  objects  remotes
% git clone /repos/git/project
remote: Generating pack...
remote: Done counting 1149 objects.
remote: Deltifying 1149 objects.
remote: 149/1149) done49) done
Indexing 1149 objects.
remote: Total 1149, written 1149 (delta 619), reused 1149 (delta 619)
 100% (1149/1149) done
Resolving 619 deltas.
 100% (619/619) done
% ls project
% ls -a project
.  ..  .git


Bill
