From: Paul Mackerras <paulus@samba.org>
Subject: Re: Recent issues
Date: Mon, 9 Jul 2007 19:28:06 +1000
Message-ID: <18065.65446.474822.436800@cargo.ozlabs.ibm.com>
References: <7v7ipcbrfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, pasky@suse.cz,
	ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 11:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7prL-0007cT-Od
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 11:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbXGIJso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 05:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbXGIJso
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 05:48:44 -0400
Received: from ozlabs.org ([203.10.76.45]:35256 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbXGIJsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 05:48:43 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7A03FDDE4A; Mon,  9 Jul 2007 19:48:42 +1000 (EST)
In-Reply-To: <7v7ipcbrfd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51977>

Junio C Hamano writes:

> * gitk --left-right
> 
>   From: Linus Torvalds <torvalds@linux-foundation.org>
>   Message-ID: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
>   From: Junio C Hamano <junkio@cox.net>
>   Message-ID: <7vabwifl23.fsf@assigned-by-dhcp.cox.net>
> 
> Paulus?

Looks mostly OK; I assume there's no possible downside to using git
log -v --pretty=raw rather than git rev-list?

Also, in the second patch, commitside needs to either be indexed by
view as well as id, or needs to be "context-switched" by showview.
I'll fix it.  Since neither you nor Linus included a signed-off-by,
I'll combine the patches and fix up a few things.

> * gitk tree view fix
> 
>   From: Brian Downing <bdowning@lavos.net>
>   Subject: [PATCH] gitk: Fix for tree view ending in nested directories
>   Message-ID: <20070704212643.GR4087@lavos.net>
> 
> Paulus?

Looks reasonable.

Paul.
