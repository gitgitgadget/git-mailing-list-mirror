From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 09:19:19 +0200
Message-ID: <20050523071919.GG23388@cip.informatik.uni-erlangen.de>
References: <20050521214700.GA18676@mars.ravnborg.org> <2765.10.10.10.24.1116713164.squirrel@linux1> <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 09:19:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7Di-00023e-3G
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVEWHUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEWHUd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:20:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:28101 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261848AbVEWHU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 03:20:29 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4N7JKS8018061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 May 2005 07:19:20 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4N7JJ5q018060;
	Mon, 23 May 2005 09:19:19 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Sean <seanlkml@sympatico.ca>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Linus,

> 	git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin

This doesn't work for me:

(faui00u) [~/work/git/git] git-rev-tree 2cb45e95438c113871fbbea5b4f629f9463034e7 ^09d74b3b5ac634495e17b92b2b785fa996ffce97
1116799695 2cb45e95438c113871fbbea5b4f629f9463034e7:1 09d74b3b5ac634495e17b92b2b785fa996ffce97:3
(faui00u) [~/work/git/git] git-rev-tree 2cb45e95438c113871fbbea5b4f629f9463034e7 ^09d74b3b5ac634495e17b92b2b785fa996ffce97 | git-diff-tree -v -m -s --stdin
(faui00u) [~/work/git/git]

Bit this does:

(faui00u) [~/work/git/git] git-rev-tree 2cb45e95438c113871fbbea5b4f629f9463034e7 ^09d74b3b5ac634495e17b92b2b785fa996ffce97 | awk '{print $2'} | sed 's#:.*##' | git-diff-tree -v -m -s --stdin

was that a typo or is git-diff-tree supposed to handle the output of
git-rev-tree as well and it is a bug?

	Thomas
