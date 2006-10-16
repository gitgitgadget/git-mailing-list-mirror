From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 18:57:08 +0200
Message-ID: <878xjgp5az.fsf@rho.meyering.net>
References: <87slhopcws.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
	<87mz7wp6ek.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
	<87ejt8p5l9.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160953480.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVm6-00026L-DK
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWJPQ5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWJPQ5K
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:57:10 -0400
Received: from mx.meyering.net ([82.230.74.64]:62945 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1422682AbWJPQ5J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:57:09 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 5127F2F4B2; Mon, 16 Oct 2006 18:57:08 +0200 (CEST)
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610160953480.7697@alien.or.mcafeemobile.com>
	(Davide Libenzi's message of "Mon, 16 Oct 2006 09:54:46 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28974>

Davide Libenzi <davidel@xmailserver.org> wrote:
>> That helps a little.
>> Now, instead of taking 63s, my test takes ~30s.
>> (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)
>
> That's too much still. May I have the offending files?

These URLs were in at least one of the messages to which
you've replied.  Would you like me to send them instead?

>   http://meyering.net/code/git-perf/configure.gz
>   http://meyering.net/code/git-perf/configure-curr.gz
