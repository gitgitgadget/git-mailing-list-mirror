From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] ls-files: honour per-directory ignore file from higher
	directories.
Date: Thu, 09 Feb 2006 22:38:50 -0500
Message-ID: <1139542730.23725.3.camel@dv>
References: <1138125570.24415.11.camel@dv>
	 <20060125061140.GA8408@mars.ravnborg.org>
	 <7vmzh1eykq.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 04:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7P7w-00064W-FG
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 04:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWBJDi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 22:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWBJDi7
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 22:38:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:18050 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751032AbWBJDi7
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 22:38:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F7P7Z-000505-Ch
	for git@vger.kernel.org; Thu, 09 Feb 2006 22:38:57 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F7P7S-00087n-Ut; Thu, 09 Feb 2006 22:38:50 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzh1eykq.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.90 (2.5.90-1.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15861>

Hello, Junio!

On Thu, 2006-02-09 at 00:16 -0800, Junio C Hamano wrote:
> When git-ls-files -o --exclude-per-directory=.gitignore is run
> from a subdirectory, it did not read from .gitignore from its
> parent directory.  Reading from them makes output from these two
> commands consistent:

You beat me at that.  Thank you!

With this patch, the simplified version of cg-clean passes the cogito
testsuite.  That's where the original bug was caught.

>  * If there are positive feedbacks on this one, I consider it
>    a safe enough candidate to be included in 1.2.0 release.

Yes, it would be nice to see it released.

-- 
Regards,
Pavel Roskin
