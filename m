From: Josef Wolf <jw@raven.inka.de>
Subject: Automatic merge of local modifications in submodules?
Date: Sat, 3 Oct 2009 13:30:02 +0200
Message-ID: <20091003113002.GA29831@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 13:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu2od-0004ux-42
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 13:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZJCLaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 07:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbZJCLaH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 07:30:07 -0400
Received: from quechua.inka.de ([193.197.184.2]:37695 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbZJCLaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 07:30:06 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Mu2oT-0001ye-0m; Sat, 03 Oct 2009 13:30:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 192EA2CC00; Sat,  3 Oct 2009 13:30:03 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129483>

Hello,

I am trying to explore gti's submodule functionality. Since I'm used to
svn:externals, I am missing the automatic merge of local modifications.
So I'd like to do something like:

  (cd submodule; git stash)
  git submodule update
  (cd submodule; git stash pop)

The problem with this command sequence is that it is not atomic. So if it
is automatically executed from a script (e.g cron or post-update-hook), it
will cause damage.

Any ideas how to properly auto-merge local modifications on submodule
update? git-submodule don't seem to have an option to do that.
