From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Handle blobs containing a DOS end-of-file marker.
Date: Mon, 23 Mar 2009 21:33:23 +1100
Message-ID: <18887.25971.131679.375558@cargo.ozlabs.ibm.com>
References: <87y6v5ojdj.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhZ4-0006NL-Fk
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbZCWKh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZCWKhy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:37:54 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:32789 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078AbZCWKhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:37:52 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id A9E9FB7079; Mon, 23 Mar 2009 21:37:49 +1100 (EST)
In-Reply-To: <87y6v5ojdj.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114280>

Pat Thoyts writes:

>   If a patchset contains an EOF marker (Ctrl-Z) the blob diff terminates
>   at that point. This patch permits gitk to ignore the eof and continue to
>   display any subsequent blobs and also displays a sensible representation
>   of the eof char.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks, applied.

Paul.
