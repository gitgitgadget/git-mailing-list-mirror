From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Replace "git-" commands with "git "
Date: Fri, 26 May 2006 22:26:50 +1000
Message-ID: <17526.62474.530421.79594@cargo.ozlabs.ibm.com>
References: <20060524105740.2cb97585.tihirvon@gmail.com>
	<81b0412b0605240323q29b64949s80d4738cb54c22c8@mail.gmail.com>
	<20060524133455.f78b11a4.tihirvon@gmail.com>
	<17526.59159.484712.500414@cargo.ozlabs.ibm.com>
	<20060526145954.cea5613c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: raa.lkml@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 14:39:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjbbg-0004dY-CE
	for gcvg-git@gmane.org; Fri, 26 May 2006 14:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEZMjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 08:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWEZMjx
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 08:39:53 -0400
Received: from ozlabs.org ([203.10.76.45]:26855 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750704AbWEZMjw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 08:39:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 97A5F67B15; Fri, 26 May 2006 22:39:51 +1000 (EST)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060526145954.cea5613c.tihirvon@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20808>

OK, thanks.  I have applied your patch.  The ones that gitk uses that
aren't built-in now are git-rev-parse and git-repo-config, which
aren't performance-critical.

Paul.
