From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 17:42:25 +0200
Organization: At home
Message-ID: <ehinsa$a7n$1@sea.gmane.org>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com> <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com> <Pine.LNX.4.64.0610230826080.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 23 17:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc1xe-0006S1-AI
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 17:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWJWPnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJWPnb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:43:31 -0400
Received: from main.gmane.org ([80.91.229.2]:22184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932129AbWJWPna (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 11:43:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc1wr-0006EI-W2
	for git@vger.kernel.org; Mon, 23 Oct 2006 17:42:46 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 17:42:45 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 17:42:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29836>

Linus Torvalds wrote:

> So depending on the problem, you can try two different approaches.

[The approaches being: 1) applying patchseries before testing, and marking
the commit before applying as good or bad for bisect; 2) rebasing
(applying) the patch-series on top of current kernel, and bisecting the
series]

You can try yet another approach, namely rebase v2.6.15..v2.6.18 on top of
your patch-series applied to v2.6.15, and bisect that.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
