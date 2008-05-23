From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk - restore operation of git-reset on Cygwin
Date: Fri, 23 May 2008 13:46:15 +1000
Message-ID: <18486.15879.551874.408651@cargo.ozlabs.ibm.com>
References: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 05:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzOGn-0001SY-0t
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 05:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212AbYEWDrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 23:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYEWDrs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 23:47:48 -0400
Received: from ozlabs.org ([203.10.76.45]:43414 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbYEWDrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 23:47:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C27C7DE030; Fri, 23 May 2008 13:46:20 +1000 (EST)
In-Reply-To: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82676>

Mark Levedahl writes:

> Commit 6df7403a98737 modified the call to git-reset to invoke git
> directly rather than using "sh -c", but is redirecting stderr to stdout.
> This does not work on Cygwin, probably because the Tcl/Tk package is
> a windows program rather than Cygwin. The result is always an error
> message proclaiming 'can not find channel named "1"'. This restores
> invocation through sh -c.

Are you using Tk 8.4 or 8.5?  The man pages for 8.5 imply that the
2>@1 form should work for all platforms, but maybe that wasn't true in
8.4.  If that's the case it's worth mentioning in the patch
description.

Paul.
