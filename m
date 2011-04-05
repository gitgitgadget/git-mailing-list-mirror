From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 0/8] make gitk work better in non-top-level directory
Date: Tue, 5 Apr 2011 20:48:03 +0200
Message-ID: <20110405184803.GA19515@m62s10.vlinux.de>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 20:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7BIW-00030j-O8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1DESsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 14:48:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:57335 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751996Ab1DESsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 14:48:11 -0400
Received: (qmail invoked by alias); 05 Apr 2011 18:48:07 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp006) with SMTP; 05 Apr 2011 20:48:07 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18Kf0N0Mm4K68viTdY6mlniz5VbDZkmX4mCCiaer/
	JT1AfrP0/mRXof
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A4C65D400C; Tue,  5 Apr 2011 20:48:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170902>

On Mon, Apr 04, 2011 at 10:14:11PM -0400, Martin von Zweigbergk wrote:
> This series fixes a few different bugs in gitk related to its working
> directory.
> 
> I started working on patch 1, which fixes "Highlight this only/too"
> when gitk is started in a subdirectory. This problem has bothered me
> for a long time, but I had heard that the Tcl code in gitk was hard to
> maintain, so I didn't have a look at it until now. I have to say that
> it was a lot easier to follow the code than I had feared.
> 
> While testing that the fix in patch 1 worked, I found that gitk does
> not work very well when the work tree is not at ".git/..", so most of
> the other patches try to improve that situation.
> 
> I think I have tested most combinations of setups (top-level dir,
> subdir, separate work tree, bare repo, .git) and operations (highlight
> file, blame, external diff, show origin of line).
> 

This is something which anoyed me a long time. I even tried to fix
it [1], but with my limited Tcl knowledge I failed misserably.

Your patch series seems to fix all the problems I was having.
Nice job!

-Peter

[1]: http://article.gmane.org/gmane.comp.version-control.git/120391
