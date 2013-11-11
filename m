From: Ari Pollak <ari@debian.org>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Mon, 11 Nov 2013 20:48:18 +0000 (UTC)
Message-ID: <loom.20131111T214646-550@post.gmane.org>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 21:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyPj-0002oL-HS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3KKUss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:48:48 -0500
Received: from plane.gmane.org ([80.91.229.3]:60142 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab3KKUsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:48:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VfyPY-0002XN-LI
	for git@vger.kernel.org; Mon, 11 Nov 2013 21:48:40 +0100
Received: from scvngr-gw.customer.alter.net ([scvngr-gw.customer.alter.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 21:48:40 +0100
Received: from ari by scvngr-gw.customer.alter.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 21:48:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 152.179.1.82 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237650>

Jens Lehmann writes:
> And after adding a modified file the log message also shows the diff of
> that file (and without leading "# "s too), so I doubt that diffs aren't
> normally included in the commit message with -v. What am I missing?

Ah, it is true that -v normally does not prefix the diffs with #, but there 
must be some filter in place after I save & quit my editor when a normal file 
diff is present, since that does not get included in the final commit 
message. But the submodule log does get included, which does not seem 
intentional.

Cheers,
Ari
