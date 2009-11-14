From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix "git gui blame" invocation when called from topdir
Date: Sat, 14 Nov 2009 22:14:17 +1100
Message-ID: <19198.37129.682215.327167@cargo.ozlabs.ibm.com>
References: <19184.2163.760155.285153@cargo.ozlabs.ibm.com>
	<1257290501-21093-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 12:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9GgZ-0000Dr-Ed
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 12:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbZKNLUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 06:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZKNLUh
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 06:20:37 -0500
Received: from ozlabs.org ([203.10.76.45]:54594 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbZKNLUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 06:20:36 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6518DB7B60; Sat, 14 Nov 2009 22:20:41 +1100 (EST)
In-Reply-To: <1257290501-21093-1-git-send-email-markus.heidelberg@web.de>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132872>

Markus Heidelberg writes:

> In this case "git rev-parse --git-dir" doesn't return an absolute path,
> but merely ".git", so the selected file has a relative path.
> The function make_relative then tries to make the already relative path
> relative, which results in a path like "../../../../Makefile" with as
> much ".." as the number of parts [pwd] consists of.
> 
> This regression was introduced by commit 9712b81 (gitk: Fix bugs in
> blaming code, 2008-12-06), which fixed "git gui blame" when called from
> subdirs.
> 
> This also fixes it for bare repositories.
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

Thanks, applied.

Paul.
