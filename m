From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Do not hard-code "encoding" in attribute lookup functions
Date: Thu, 13 Aug 2009 21:52:13 +1000
Message-ID: <19075.65133.297090.208203@cargo.ozlabs.ibm.com>
References: <4A6577CC.2000403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 13:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbYtw-00029A-KI
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 13:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbZHMLzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbZHMLzM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 07:55:12 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:47110 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbZHMLzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 07:55:10 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 17488B7079; Thu, 13 Aug 2009 21:55:08 +1000 (EST)
In-Reply-To: <4A6577CC.2000403@viscovery.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125804>

Johannes Sixt writes:

> Commit 39ee47e (Clean up file encoding code and add enable/disable option,
> 2008-10-15) rewrote the attribute lookup functions gitattr and
> cache_gitattr, but in the process hard-coded the attribute name "encoding"
> instead of using the functions' parameters. This fixes it.
> 
> This is not a serious regression because currently all callers look only
> for "encoding".
> 
> Further note that this fix assumes that future callers will not pass an
> attribute name that contains regex special characters.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thanks, applied.

Paul.
