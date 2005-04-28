From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 21:03:21 +0200
Message-ID: <42713379.7080107@lsrfire.ath.cx>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRECz-0001pF-Uu
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 20:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVD1TD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVD1TD1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:03:27 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:18585 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262225AbVD1TDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 15:03:24 -0400
Received: from [10.0.1.3] (p508E4F7A.dip.t-dialin.net [80.142.79.122])
	by neapel230.server4you.de (Postfix) with ESMTP id F160AB4;
	Thu, 28 Apr 2005 21:03:22 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> Right now my major gripe with cogito is "cg-log" (which is actually
> the only command I use right now, everything else I just do by hand
> with the raw git archive) is that bash is being an ass about SIGPIPE,
> and when I only look at the top part of the log, ie I do something
> like:
> 
> torvalds@ppc970:~/src/cogito> git log | head

I think you misspelled "cg-log". :-D

Doing "cg-log | head" gives me 10 lines of log and nothing else.  Maybe
the problem has been fixed between 0.7 and the current version I'm using
(commit ID 49612c471eebd26efe926a71752e254c1cdc382d)?

Rene
