From: Paul Mackerras <paulus@samba.org>
Subject: naive question
Date: Tue, 19 Apr 2005 23:00:14 +1000
Message-ID: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 14:57:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNsHA-0003Rt-Fh
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 14:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDSNAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDSNAZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:00:25 -0400
Received: from ozlabs.org ([203.10.76.45]:30665 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261493AbVDSNAX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 09:00:23 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 38D1E67A6B; Tue, 19 Apr 2005 23:00:21 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there a way to check out a tree without changing the mtime of any
files that you have already checked out and which are the same as the
version you are checking out?  It seems that checkout-cache -a doesn't
overwrite any existing files, and checkout-cache -f -a overwrites all
files and gives them the current mtime.  This is a pain if you are
using make and your tree is large (like, for instance, the linux
kernel :), because it means that after a checkout-cache -f -a you get
to recompile everything.

Paul.
