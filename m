From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-2.6.git mirror
Date: Thu, 18 Oct 2007 15:26:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710181518120.26902@woody.linux-foundation.org>
References: <598D5675D34BE349929AF5EDE9B03E2701684C77@az33exm24.fsl.freesca
 le.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:26:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IidpK-0005Xx-Qb
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934110AbXJRW0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765891AbXJRW0S
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:26:18 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39976 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763523AbXJRW0R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 18:26:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMQ9qw013614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2007 15:26:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMQ8CF001636;
	Thu, 18 Oct 2007 15:26:09 -0700
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701684C77@az33exm24.fsl.freescale.net>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61565>



On Tue, 16 Oct 2007, Medve Emilian-EMMEDVE1 wrote:
>
> $ git remote update
> Updating origin
> error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
> error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit

Interesting. Something seems to be assuming that all tags are commits. 
Which is not true. You can have (and the kernel repo does this) a tag 
pointing to a pure tree state (with no history), or as in the case of git 
itself, there's a tag pointing to a blob that contains Junio's public key.

> The situation is similar with the git tree:
> 
> error: Object a0e7d36193b96f552073558acf5fcc1f10528917 is a blob, not a commit

Yeah, same thing.

> Is this something I should be worried about?

No, but if it still happens with a newer git, holler.

			Linus
