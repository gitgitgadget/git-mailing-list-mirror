From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: force focus to main window
Date: Thu, 18 Dec 2008 08:38:36 +1100
Message-ID: <18761.29020.237388.687560@cargo.ozlabs.ibm.com>
References: <4948E771.4050705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD50v-00065Y-MC
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYLQWfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYLQWfv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:35:51 -0500
Received: from ozlabs.org ([203.10.76.45]:41040 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbYLQWfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:35:50 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 64C0EDDF29; Thu, 18 Dec 2008 09:35:49 +1100 (EST)
In-Reply-To: <4948E771.4050705@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103405>

Johannes Sixt writes:

> On msysGit, the focus is first on the (Tk) console.  This console is then
> hidden, but keeps the focus.  Work around that by forcing the focus onto
> the gitk window.

Hmmm, I don't like doing focus -force unconditionally on all
platforms.  I hate it when applications decide they know best and
override what the window manager decides.

At least put a if {[tk windowingsystem] eq "win32"} in there.
(msysGit is a windows thing, isn't it?)

Paul.
