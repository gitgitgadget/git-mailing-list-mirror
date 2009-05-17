From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix errors in the theme patch
Date: Mon, 18 May 2009 09:32:20 +1000
Message-ID: <18960.40580.699131.292524@cargo.ozlabs.ibm.com>
References: <87zldi9y8d.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon May 18 01:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5pqY-00051E-L6
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 01:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbZEQXc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 19:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbZEQXc1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 19:32:27 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:49480 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbZEQXc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 19:32:27 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 84977B7079; Mon, 18 May 2009 09:32:27 +1000 (EST)
In-Reply-To: <87zldi9y8d.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119410>

Pat Thoyts writes:

>   This patch fixes a typo in the commit selection combobox that
>   prevented it from working and sets the width of the widget.
>   Also fixed show_error to handle errors arising before the gui is
>   fully configured (ie: invalid command line parameters)

Applied to the dev branch, thanks.  I'll pull it into the master
branch soon - there have been changes to [vieweditor] on the master
branch that conflict, including new widgets added which will need to
have the ${NS}:: treatment.

Paul.
