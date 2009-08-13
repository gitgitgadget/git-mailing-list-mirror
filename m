From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: new option to hide remote refs
Date: Thu, 13 Aug 2009 21:53:35 +1000
Message-ID: <19075.65215.120894.823187@cargo.ozlabs.ibm.com>
References: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thell Fowler <tbfowler4@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 13 13:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbYuH-0002JE-LN
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 13:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZHMLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 07:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbZHMLzO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 07:55:14 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:47110 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZHMLzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 07:55:09 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 0ED04B7063; Thu, 13 Aug 2009 21:55:08 +1000 (EST)
In-Reply-To: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125806>

Thomas Rast writes:

> In repositories with lots of remotes, looking at the history in gitk
> can be borderline insane with all the red labels for remote refs.
> Introduce a new option in the preferences that hides them.

Thanks, applied.  I modified the patch description slightly since the
patched gitk doesn't just hide the remote refs, it ignores them
completely ("hide" implies to me that gitk still knows about them but
chooses not to show them).

Paul.
