From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 20:43:22 +0200
Message-ID: <87wt70nlth.fsf@rho.meyering.net>
References: <87slhopcws.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
	<87mz7wp6ek.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
	<87ejt8p5l9.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
	<873b9op19n.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610161129350.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:44:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZXRM-0004fj-UY
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWJPSny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWJPSny
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:43:54 -0400
Received: from mx.meyering.net ([82.230.74.64]:60814 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1422801AbWJPSnx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 14:43:53 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 86F6E2734E; Mon, 16 Oct 2006 20:43:22 +0200 (CEST)
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610161129350.7697@alien.or.mcafeemobile.com>
	(Davide Libenzi's message of "Mon, 16 Oct 2006 11:30:59 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28984>

Davide Libenzi <davidel@xmailserver.org> wrote:
...
> No, the patch is broken. It will discard *any* line seen at least two
> times, that is an extremely low threashold.

Oh!  I see it now.  Thanks.
