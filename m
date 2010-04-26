From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Unable to coax hooks into working
Date: Mon, 26 Apr 2010 14:32:09 +0200
Message-ID: <4C764DDD-420E-40C6-9848-96E2197BE70D@pelagicore.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 14:32:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6NU1-0004db-Kh
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 14:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab0DZMcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 08:32:12 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:56610 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0DZMcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 08:32:11 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 020E937E65; Mon, 26 Apr 2010 14:32:09 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP id A8A7D37FEE
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 14:32:09 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 9D19537E4D
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 14:32:09 +0200 (CEST)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145815>

Hello,

	After reading this page: http://book.git-scm.com/5_git_hooks.html on git hooks and doing a test implementation, I cannot seem to coax my git hooks into working.

	My understanding is that the hook is in the right location, in the git repository on the remote server, when doing a hook based on a post-commit update. I have down chown and chmod, the code executes, it just doesn't execute when I update the git repo and push. I have also tested this on the local machine with a different hook for the client also without success. 

	We're using debian testing and git 1.7.0.2 with the http-smart backend.

	What should I do to get hooks working?

Regards,

Jeremiah
