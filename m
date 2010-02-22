From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Sun, 21 Feb 2010 22:08:29 -0500
Message-ID: <20100222030829.GA32020@cthulhu>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 04:51:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjOf5-0000DJ-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 04:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab0BVDIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 22:08:30 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:43037 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab0BVDIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 22:08:30 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 7F645822023; Sun, 21 Feb 2010 22:08:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtytacebd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140570>

* Junio C Hamano (gitster@pobox.com) [100221 19:19]:

> [Stalled]
> 
> * ld/push-porcelain (2010-02-09) 4 commits
>  - git-push: fix an error message so it goes to stderr
>  - git-push: make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
>  - git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
>  - git-push: squelch advice message if in --porcelain mode
> 
> This needs further simplification, judging from the previous discussion?

I was waiting for Michael Lukashov to put out the next version of his
refactoring series to do another of this (there was some concern there would be
a merge issue between this and that).  Aside from the --quiet issue, are there
any other changes this series needs?

      --larry
