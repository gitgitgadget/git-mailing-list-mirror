From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Handle msysGit version during version comparisons
Date: Tue, 19 May 2009 08:57:58 +1000
Message-ID: <18961.59382.839207.898823@cargo.ozlabs.ibm.com>
References: <87hbzirso6.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 19 01:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6C3k-0003Of-OV
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZERXPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbZERXPn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:15:43 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:47336 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbZERXPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:15:43 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 348FEB7080; Tue, 19 May 2009 09:15:44 +1000 (EST)
In-Reply-To: <87hbzirso6.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119470>

Pat Thoyts writes:

>   msysGit generates version strings with text appended which cannot
>   be used with vcompare. Limit git_version to the first three digits
>   which are the real git version.

Thanks, applied.

Paul.
