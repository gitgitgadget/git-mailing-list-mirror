From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 9 Jul 2007 10:51:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
 <20070709173720.GS29994@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 19:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7xPJ-0003LG-7G
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 19:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbXGIRwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbXGIRwR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 13:52:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48615 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754113AbXGIRwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 13:52:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l69HpRcd017688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2007 10:51:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l69HpMhO030298;
	Mon, 9 Jul 2007 10:51:22 -0700
In-Reply-To: <20070709173720.GS29994@genesis.frugalware.org>
X-Spam-Status: No, hits=-2.64 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52008>



On Mon, 9 Jul 2007, VMiklos wrote:
> 
> > I think bk can export to CVS and then git can import from CVS.
> 
> i think so

That's how I did my kernel history, and cvsps has a special "BK mode", 
which knows to trust the CVS timestamps more when importing from a BK CVS 
archive (since the timestamps will then be exact).

That said, the quality of the result isn't stellar. The CVS export will 
obviously linearize the BK information, so you do lose things. So there's 
actually a better kernel BK->git archive around which doesn't do that, but 
that was done apparently from a custom database, so it's not reproducible.

			Linus
