From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Show notes by default (like git log do)
Date: Sun, 30 May 2010 12:22:31 +1000
Message-ID: <20100530022231.GF2538@brick.ozlabs.ibm.com>
References: <1274349041-7886-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sun May 30 04:24:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIYCu-00079B-Co
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 04:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab0E3CWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 22:22:51 -0400
Received: from ozlabs.org ([203.10.76.45]:57183 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab0E3CWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 22:22:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6BCEAB7D4C; Sun, 30 May 2010 12:22:48 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1274349041-7886-1-git-send-email-kirr@mns.spb.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147982>

On Thu, May 20, 2010 at 01:50:41PM +0400, Kirill Smelkov wrote:

> Starting from ~ git-1.6.6, log, show & whatchanged show notes by default.
> 
> On the other hand, gitk does not show notes by default, because under
> the hood it calls `git log --pretty=raw ...` to get the log, and in
> `git log` notes are turned off, when user specifies format or pretty
> settings.
> 
> Yes, it is possible to invoke `gitk --show-notes` explicitly, but since
> from user's perspective, gitk is gui enabled git log, it would be
> logical for gitk to show notes by default too for consistency.
> 
> In git, --show-notes was introduced in 66b2ed (Fix "log" family not to
> be too agressive about showing notes) which predates 1.6.6.2
> 
> Notes can still be supressed with `gitk --no-notes`.
> 
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Thanks, applied.

Paul.
