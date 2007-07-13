From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Fri, 13 Jul 2007 12:33:02 +0200
Organization: eudaptics software gmbh
Message-ID: <469754DE.4A4EE499@eudaptics.com>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org> <18071.19489.6733.665052@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 12:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9IRi-0006IU-TP
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 12:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXGMKcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 06:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbXGMKcT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 06:32:19 -0400
Received: from main.gmane.org ([80.91.229.2]:54985 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbXGMKcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 06:32:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I9IRX-0007Rf-TJ
	for git@vger.kernel.org; Fri, 13 Jul 2007 12:32:11 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 12:32:11 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 12:32:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52383>

Paul Mackerras wrote:
> Try this, let me know what you think.  I called the changes in the
> working directory "Local uncommitted changes, not checked in to index"
> and the changes in the index "Local changes checked in to index but
> not committed".  If you prefer some other wording, let me know.

Maybe you go with git-gui's wording:

Index: Staged changes
WD:    Unstaged changes

-- Hannes
