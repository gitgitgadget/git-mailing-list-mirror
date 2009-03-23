From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: put all startup code into a proc to enable re-sourcing
Date: Mon, 23 Mar 2009 21:04:34 +1100
Message-ID: <18887.24242.451428.980685@cargo.ozlabs.ibm.com>
References: <87prh3e7p2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhZ3-0006NL-4W
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbZCWKhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbZCWKhx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:37:53 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:32788 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962AbZCWKhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:37:52 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 9EF7FB7066; Mon, 23 Mar 2009 21:37:49 +1100 (EST)
In-Reply-To: <87prh3e7p2.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114279>

Pat Thoyts writes:

>     All the startup code is moved into a procedure. All the variables
>     get initialized using 'variable' to ensure they are in the global
>     namespace.  This makes it possible to re-source the script during
>     development from the Tk console or a tkcon interactive session.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

The patch does other stuff as well, that should be mentioned in the
patch description or split out into a separate patch - namely it
changes error_popup on win32 (why?) and it introduces some ttk widget
use into confirm_popup.

Paul.
