From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [BUG?] git rebase not accepting :/ syntax
Date: Mon, 10 Sep 2012 10:29:48 +0200
Message-ID: <k2k8dt$i5v$1@ger.gmane.org>
References: <20120907150803.0ae2b186@chalon.bertin.fr> <m2ipbqx7iu.fsf@igel.home> <20120910091224.4eca1b6e@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 10:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAzNk-0005ld-FY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 10:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2IJIaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 04:30:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:39117 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab2IJIaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 04:30:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TAzNb-0005fX-NC
	for git@vger.kernel.org; Mon, 10 Sep 2012 10:30:03 +0200
Received: from dsdf-4db54003.pool.mediaways.net ([77.181.64.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 10:30:03 +0200
Received: from jojo by dsdf-4db54003.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 10:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db54003.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205112>

Yann Dirson wrote:
> On Fri, 07 Sep 2012 15:54:49 +0200
...
> BTW, git-rebase.sh seems to be quite inconsistent on the use of $()
> vs. ``, not to mention the clear preference stated in
> CodingGuidelines.

There are still quite a few more places in *.sh where `cmd`is used instead 
of $(cmd):

check-builtins.sh, git-am.sh, git-merge-one-file.sh, git-pull.sh, 
git-rebase--merge.sh, git-repack.sh, git-stash.sh, 
git-web--browse.sh,test-sha1.sh, unimplemented.sh

> I guess I'll find a moment for a couple of patches...

Might wanna fix them all in one go?

Bye, Jojo 
