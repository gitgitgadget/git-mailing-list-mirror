From: Petr Baudis <pasky@suse.cz>
Subject: Re: does anything like cvs export exist in git?
Date: Fri, 15 Aug 2008 00:11:48 +0200
Message-ID: <20080814221148.GB10544@machine.or.cz>
References: <977100.98240.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTl3t-0007XX-QF
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbYHNWLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYHNWLu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:11:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52972 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbYHNWLu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:11:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2176D3939B56; Fri, 15 Aug 2008 00:11:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <977100.98240.qm@web27803.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92415>

  Hi,

On Thu, Aug 14, 2008 at 09:20:10PM +0000, Mark Struberg wrote:
> I'm the initial author of the Apache maven-scm-providers-git and I need to update our SCM-Matrix. 
> 
> This is just for making sure I did not oversee anything.
> 
> I didn't came across anything like 'cvs export' and I do not think git really needs this, since it doesn't pollute the working directories with lots of waste like CVS and SVN does. 
> But I just want to make sure to not build workarounds in our scm-provider (checkout + afterwards blasting the GIT_DIR) for things that do exist natively in git.

  I'm not sure what exactly do you want, but couldn't you abuse
git-cvsserver for the job?

				Petr "Pasky" Baudis
