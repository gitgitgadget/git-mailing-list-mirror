From: Greg KH <greg@kroah.com>
Subject: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 13:38:37 -0700
Message-ID: <20070413203837.GA27660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 22:40:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcSZk-0008P5-8h
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 22:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbXDMUkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbXDMUkx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 16:40:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33124 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030263AbXDMUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 16:40:52 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HcSZf-0000cd-4U
	for git@vger.kernel.org; Fri, 13 Apr 2007 21:40:51 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44430>

In git 1.5.1 the quiltimport function started complaining in a new way:

	libata-clear-tf-before-doing-request-sense.patch
	Patch is empty.  Was is split wrong?
	/usr/bin/git-quiltimport: line 78: stop_here: command not found

yet it still applies the patch properly.

For an example of patches that causes this output, the -stable kernel
tree queue can be used (which is where I started seeing this problem...)

Any hints?  Or is it time to start bisecting?

thanks,

greg k-h
