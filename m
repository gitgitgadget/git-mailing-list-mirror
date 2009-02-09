From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Mon, 9 Feb 2009 09:24:37 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
 <20090206161954.GA18956@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 18:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWZtl-0007fq-Su
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 18:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZBIRYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbZBIRYx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 12:24:53 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:60568 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbZBIRYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 12:24:52 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n19HOe8a001040;
	Mon, 9 Feb 2009 09:24:40 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n19HObPi001037;
	Mon, 9 Feb 2009 09:24:40 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090206161954.GA18956@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109095>

On Fri, 6 Feb 2009, Jeff King wrote:

> if somebody really wants to call a porcelain and _disable_ options, I don't 
> think "--no-primer" is necessarily the right interface. Instead, the actual 
> command line options given override what's in diff.primer, so you can 
> selectively disable whatever you like.

Sir I appreciate the intention, as I interpret it, that it's always better to 
accomplish something without adding new vocabulary.  I'd much rather avoid 
adding new vocab if possible.  If I'm missing something, I apologize ahead of 
time, but let me describe the problem I see.  Let's take the context size 
setting as an example, i.e. -U<n> or --unified=<n>.  Default is 3.  Let's say 
someone defines diff.primer = -U6.  Now, without --no-primer, how does a program 
say "use the default value for context."  Aren't there options for which no 
inverse counterpart exists?  Is there command-line syntax to disable all 
whitespace ignore options, e.g. to disable -b?  If not then we need --no-primer.
