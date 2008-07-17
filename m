From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt(1): fix path to git-sh-setup
Date: Thu, 17 Jul 2008 10:53:56 -0400
Message-ID: <20080717145356.GA7235@josefsipek.net>
References: <20080716232339.GC22919@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Alex Chiang <achiang@hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 16:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUss-0003Fz-9G
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbYGQOyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYGQOyG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:54:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42660 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYGQOyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:54:05 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.8) with ESMTP id m6HErtgs012039;
	Thu, 17 Jul 2008 10:53:55 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 3B7A81C00D88; Thu, 17 Jul 2008 10:53:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080716232339.GC22919@ldl.fc.hp.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88862>

On Wed, Jul 16, 2008 at 05:23:39PM -0600, Alex Chiang wrote:
> git is in the process of moving subcommands to /usr/libexec/git-core
> 
> This move breaks an assumption in guilt about the location of
> git-sh-setup.
 
I already have a fix for this queued up.

Thanks anyway,

Josef 'Jeff' Sipek.

P.S. Pasky: good catch, I'll check the queued up patch to make sure it's not
"broken"

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
