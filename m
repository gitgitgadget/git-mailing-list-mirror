From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 18:22:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710151815230.6887@woody.linux-foundation.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
 <20070709173720.GS29994@genesis.frugalware.org>
 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
 <4713FA4A.5090501@bluelane.com> <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
 <20071016011212.GA609@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pete/Piet Delaney <pete@bluelane.com>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 03:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihb9k-00053t-K3
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 03:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbXJPBX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 21:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756190AbXJPBX0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 21:23:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56327 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756344AbXJPBXZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 21:23:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9G1MxD4012181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 18:23:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9G1MxYT002461;
	Mon, 15 Oct 2007 18:22:59 -0700
In-Reply-To: <20071016011212.GA609@old.davidb.org>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61062>



On Mon, 15 Oct 2007, David Brown wrote:
>
> On Mon, Oct 15, 2007 at 05:45:44PM -0700, Linus Torvalds wrote:
> 
> > 	git diff -U99 | viewdiff -
> 
> Do you have reference for viewdiff.  I can't seem to locate it.

That was the stupid script I just posted ;)

> > [ Quite frankly, I don't understand why tools like meld and kdiff3 can't
> > just take the unified diff directly - they have *all* the logic, it  should
> > be trivial to do, and very useful to view diffs for those people  who like
> > that graphical bling. ]
> 
> kompare can read the unified diffs.  If you add enough context, the result
> is no different than the full files.

Ahh, good pointer. I had to google for it to find that it's part of the 
kdesdk package, which I hadn't installed. But a simple "yum install 
kdesdk" worked fine.

Much better than my stupid script ;)

		Linus
