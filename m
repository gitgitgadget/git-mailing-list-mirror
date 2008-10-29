From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 16:22:02 +0100
Message-ID: <20081029152202.GA10029@leksak.fem-net>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:23:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCtI-0003Ja-1c
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYJ2PWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbYJ2PWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:22:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752749AbYJ2PWG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:22:06 -0400
Received: (qmail invoked by alias); 29 Oct 2008 15:22:04 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp021) with SMTP; 29 Oct 2008 16:22:04 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/oUodiK/Ho1qhobDNhg76JZS3LAZ6VcgNHj1pO84
	LGA5/K2S0EVz8I
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KvCry-0005Al-AI; Wed, 29 Oct 2008 16:22:02 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99372>

Hi,

Johannes Schindelin wrote:
> So saying "this is what aliases are for" you ask for _newbies_ to add it 
> for themselves.  We are talking the same newbies who should be helped by 
> that command, and typically do not know that there are Git aliases yet.

I'm not sure if yet more commands really help newbies.

I *see* the problem that talking about the index, the cache and the staging
area can be difficult to newbies.  But then I'd rather vote for "git diff
--staged" (instead of --cached) or "git show --staged" (both make sense
in some way).
Perhaps it is even sufficient to add a help text to "git status", like
this:

 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
+#   (use "git diff --cached" to see a diff of staged files)

For me, a "git staged" feels wrong without a "git stage" (alias for
"git add") and "git unstage <file>" (alias for "git reset <file>").
And I think the list of examples can easily be continued.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
