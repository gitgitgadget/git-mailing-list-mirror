From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 12:28:38 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804281222190.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428114509.240ef4ae.akpm@linux-foundation.org> <alpine.DEB.1.00.0804281948270.19187@eeepc-johanness> <20080428120917.dd9f01e8.akpm@linux-foundation.org> <alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:29:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZ2X-0001yL-Id
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966362AbYD1T2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966125AbYD1T2p
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:28:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46244 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965937AbYD1T2o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 15:28:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJSddU024919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2008 12:28:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJScTP011408;
	Mon, 28 Apr 2008 12:28:39 -0700
In-Reply-To: <alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.478 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80595>



On Mon, 28 Apr 2008, Johannes Schindelin wrote:
> 
> On Mon, 28 Apr 2008, Andrew Morton wrote:
> > 
> > That's missing the "logical" bit :)
> 
> Heh, you're right.  I am too used to Git to think how other people would 
> feel about these things... :-)

No, you are both wrong.

You're wrong because apparently you never did abstract algebra and set 
theory in school.

If you know math, git actually does the rigth and very much the *logical* 
thing.

So ".." is a simple difference, while "..." is a more complex difference. 

They mean different things for different operation types, but that is 
again something a math person takes for granted (ie in algebra, a "+" or 
"-" is just a random operation that follows certain rules: "a-b" means one 
thing for the set of real numbers, and something *totally* different if 
you are talking about set algebra).

And "diff" and "log" really are different operation types, exactly in the 
sense that "operations on real numbers" are different from "set 
operations".

A "diff" is more like a difference between two real numbers: it gives a 
single answer (admittedly the single answer is in a different domain from 
the arguments). While "log" is very close to a set operation, in that it 
gives a set as its result.

		Linus
