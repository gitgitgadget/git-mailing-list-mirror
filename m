From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: let you easily specify lines of context in diff view
Date: Fri, 27 Jul 2007 20:31:28 +1000
Message-ID: <18089.51584.704957.310331@cargo.ozlabs.ibm.com>
References: <11854367692095-git-send-email-prohaska@zib.de>
	<18088.38093.876993.410483@cargo.ozlabs.ibm.com>
	<6EA8D0EC-6E64-4F0E-BEDB-A8C5C91AAB53@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 12:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEN7T-0003lS-2I
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 12:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758751AbXG0KcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 06:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbXG0KcX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 06:32:23 -0400
Received: from ozlabs.org ([203.10.76.45]:55566 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXG0KcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 06:32:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7731BDDE29; Fri, 27 Jul 2007 20:32:21 +1000 (EST)
In-Reply-To: <6EA8D0EC-6E64-4F0E-BEDB-A8C5C91AAB53@zib.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53912>

Steffen Prohaska writes:

> This is already included in the patch but I don't know which of gtk's
> procs to call to update the view. gitk would need to execute git diff
> and update the text box in the bottom left. I tried 'dodiffindex'
> but this causes corruptions of the history view.

reselectline should do what you want.

Paul.
