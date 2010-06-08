From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Mon, 07 Jun 2010 20:04:06 -0400
Message-ID: <1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
References: <InstallingonAIXfails> <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 02:54:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLn5S-0002LK-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 02:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab0FHAyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 20:54:33 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:45824 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0FHAyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 20:54:32 -0400
X-Greylist: delayed 3025 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2010 20:54:32 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49665 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1OLmIY-00050t-Dp
	for git@vger.kernel.org; Mon, 07 Jun 2010 20:04:06 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1OLmIY-0006xB-Ct
	for git@vger.kernel.org; Mon, 07 Jun 2010 20:04:06 -0400
In-reply-to: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148637>

Excerpts from Dario Rodriguez's message of Mon Jun 07 19:58:08 -0400 2010:

> Default pager was 'less' even when some systems such AIX and other
> basic or old systems do NOT have 'less' installed. In such case, git
> just does not display anything in pager-enabled functionalities such
> as 'git log' or 'git show', exiting with status 0.

Why not set a sensible DEFAULT_PAGER value for the system in your
config.mak file instead?

Just curious.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
