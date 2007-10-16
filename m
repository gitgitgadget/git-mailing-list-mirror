From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 12:28:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161221590.6887@woody.linux-foundation.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
 <20070709173720.GS29994@genesis.frugalware.org>
 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
 <4713FA4A.5090501@bluelane.com> <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
 <20071016191549.GG26127@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pete/Piet Delaney <pete@bluelane.com>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:29:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihs67-0002Ru-Nq
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbXJPT2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765356AbXJPT2t
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:28:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56073 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761242AbXJPT2s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 15:28:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJSIm7021644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 12:28:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJSHdr011907;
	Tue, 16 Oct 2007 12:28:18 -0700
In-Reply-To: <20071016191549.GG26127@efreet.light.src>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61241>



On Tue, 16 Oct 2007, Jan Hudec wrote:
> 
> Kompare (KDE analog of meld) can. It is even bound to text/x-diff in
> konqueror, so opening patches with konqueror yields side-by-side diff view.
> On the other hand it still keeps a unixy behaviour:
>  git diff | kompare -
> works.

Side note: I think kompare is beautiful, but kompare does one thing 
totally wrong: it seems to think that you only want to look at the diff 
fragments one file at a time.

That's totally bogus. My trivial four-liner shell script does this better 
than kompare does - as does "gitk" in the diff view window.

The fact is, quite often you have diffs that are lots of small changes to 
tons of files, and the kompare interface is totally ludicrous and useless. 
It would be *much* nicer to literally show them as one long flowing diff.

And yes, it will depend on circumstances, but I can't seem to even find 
the config option to not do that. As a result, you have to click through 
all the files manually (even the "Next file" thing is grayed out when I do 
the "git diff | kompare -", so I can't even use the keyboard shortcut to 
go to the next file).

So I have to say, after playing with it, my shell-script "viewdiff" is 
actually infinitely better than "kompare -" is, at least for my workflow.

		Linus
