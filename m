From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Display "gitweb/test/file with spaces" in gitk
Date: Fri, 21 Jul 2006 23:01:56 +1000
Message-ID: <17600.53316.193618.755468@cargo.ozlabs.ibm.com>
References: <20060720101223.116320@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 21 15:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3ufF-00051r-T8
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWGUNDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 09:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGUNDb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 09:03:31 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:3763 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750707AbWGUNDa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 09:03:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AADB767BA8; Fri, 21 Jul 2006 23:03:29 +1000 (EST)
To: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
In-Reply-To: <20060720101223.116320@gmx.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24048>

Thomas Kolejka writes:

> with this patch files with spaces in their names are displayed
> in the treeview of gitk.
> 
> I use git to make a "backup"/"dump" of a DOS-FS .. and there are 
> those filenames ;-).

Hmmm, certainly my code is incorrect.  However with your code, tabs in
the filename will get changed to spaces.  Treating the line read from
git-ls-tree or git-diff-tree was a shortcut hack that isn't really
optimal.  I'll think about the best way to fix it.

Paul.
