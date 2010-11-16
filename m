From: Phillip Hutchings <sitharus@sitharus.com>
Subject: Using git-svn with svnsync mirror
Date: Tue, 16 Nov 2010 02:08:16 +0000 (UTC)
Message-ID: <loom.20101116T030410-656@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 03:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIAzv-0002hX-1V
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759159Ab0KPCKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 21:10:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:53724 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759145Ab0KPCKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 21:10:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PIAzj-0002bG-JI
	for git@vger.kernel.org; Tue, 16 Nov 2010 03:10:04 +0100
Received: from xerown1-rt1.fx.net.nz ([131.203.100.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 03:10:03 +0100
Received: from sitharus by xerown1-rt1.fx.net.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 03:10:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.203.100.45 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.12 (KHTML, like Gecko) Chrome/9.0.576.0 Safari/534.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161528>

Hi,

I've got an svnsync mirror of a large repository, and I'm trying to do
a git-svn clone from the mirror as the main server is off site. This
works well until I try to dcommit or use git svn info.

My investigations show that working_head_info in git-svn doesn't
account for using svnsync properties, so it cannot find a log entry
that matches a config entry.

My perl isn't good enough to patch this yet, so I was wondering if
anyone else had encountered it.

I could change the config URL to match, but I'm worried this will
break things.
