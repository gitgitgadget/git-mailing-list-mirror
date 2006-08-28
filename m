From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 22:12:54 +0200
Message-ID: <m34pvwfwl5.fsf@defiant.localdomain>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
	<Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg
	.de> <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org>
	<656C30A1EFC89F6B2082D9B6@localhost>
	<Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 22:13:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHnTn-0007dK-2X
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 22:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWH1UM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWH1UM6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 16:12:58 -0400
Received: from khc.piap.pl ([195.187.100.11]:59557 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751420AbWH1UM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 16:12:57 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id BCFA510815; Mon, 28 Aug 2006 22:12:55 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org> (Linus Torvalds's message of "Mon, 28 Aug 2006 10:56:01 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26177>

Linus Torvalds <torvalds@osdl.org> writes:

>    In related news, the question is what to do about the inadvertent 
>    collision.. First off, let me remind people that the inadvertent kind 
>    of collision is really really _really_ damn unlikely, so we'll quite 
>    likely never ever see it in the full history of the universe.

Actually I think we may see it when somebody tries to put a real
example of conflicting SHA-1 pair into git repository.
-- 
Krzysztof Halasa
