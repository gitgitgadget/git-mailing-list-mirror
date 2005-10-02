From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] Stacked GIT 0.7
Date: Sun, 2 Oct 2005 14:10:59 +0200
Message-ID: <20051002121059.GA32367@elte.hu>
References: <1128244627.9740.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 02 14:11:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM2fe-0007QZ-Q6
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 14:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVJBMKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 08:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVJBMKR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 08:10:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40126 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751086AbVJBMKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 08:10:16 -0400
Received: from chiara.elte.hu ([157.181.151.252])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1EM2fX-00033c-8m
	from <mingo@elte.hu>; Sun, 02 Oct 2005 14:10:15 +0200
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id BECA11FC2; Sun,  2 Oct 2005 14:10:14 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <1128244627.9740.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Received-SPF: softfail (mx3.mail.elte.hu: transitioning domain of elte.hu does not designate 157.181.151.252 as permitted sender) client-ip=157.181.151.252; envelope-from=mingo@elte.hu; helo=chiara.elte.hu;
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9617>


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> Stacked GIT 0.7 release is available from 
> http://www.procode.org/stgit/
> 
> StGIT is a Python application providing similar functionality to Quilt 
> (i.e. pushing/popping patches to/from a stack) on top of GIT. These 
> operations are performed using GIT commands and the patches are stored 
> as GIT commit objects, allowing easy merging of the StGIT patches into 
> other repositories using standard GIT functionality.

i'm wondering - have you (or anyone else) done performance comparisons 
of quilt vs. stgit, using the same stack of patches? One of the most 
important features of quilt (for me) is that it's very fast at 
popping/pushing through hundreds of patches.

	Ingo
