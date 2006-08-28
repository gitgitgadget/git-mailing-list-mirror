From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 23:12:38 +0200
Message-ID: <m3r6z0ef95.fsf@defiant.localdomain>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
	<Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg
	.de> <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org>
	<656C30A1EFC89F6B2082D9B6@localhost>
	<Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
	<m34pvwfwl5.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0608281317070.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 23:13:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHoPV-0001gn-0Q
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 23:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWH1VMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 17:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWH1VMl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 17:12:41 -0400
Received: from khc.piap.pl ([195.187.100.11]:37837 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932126AbWH1VMl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 17:12:41 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 0875510815; Mon, 28 Aug 2006 23:12:39 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608281317070.27779@g5.osdl.org> (Linus Torvalds's message of "Mon, 28 Aug 2006 13:20:26 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26180>

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, the way to do it (if you want to use git to document SHA1 hash 
> mismatches) is to just check the files that have an identical SHA1 in. It 
> will magically work!
>
> Why? Because a git SHA1 is actually _not_ the SHA1 of the file itself, 
> it's the SHA1 of the file _with_the_git_header_added_.
>
> So if you find two files that have the same SHA1, they would also have to 
> have the same length in order to actually generate the same object name. 

Well, conflicting files will most probably have the same size,
like with MD5 cases :-)
-- 
Krzysztof Halasa
