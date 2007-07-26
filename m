From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: let you easily specify lines of context in diff view
Date: Thu, 26 Jul 2007 22:34:21 +1000
Message-ID: <18088.38093.876993.410483@cargo.ozlabs.ibm.com>
References: <11854367692095-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 00:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEBj8-0006OD-Uy
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 00:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934352AbXGZWWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934179AbXGZWWS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 18:22:18 -0400
Received: from ozlabs.org ([203.10.76.45]:55168 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934258AbXGZWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 18:22:17 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 833C2DDE30; Fri, 27 Jul 2007 08:22:16 +1000 (EST)
In-Reply-To: <11854367692095-git-send-email-prohaska@zib.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53872>

Steffen Prohaska writes:

> More lines of context sometimes help to better understand a diff.
> This patch introduces a text field above the box displaying the
> blobdiffs. You can type in the number of lines of context that
> you wish to view.

Nice idea!  I suggest you use a spinbox instead of an entry though,
since that has up and down buttons, and allows you to restrict the
value to an integer.

>    * I don't know how to update the view after entering a new value. 

You can put a trace on the associated variable and specify a function
to be called when the variable's value changes.  Grep for "trace add
variable" in gitk to see how it's done.

Paul.
