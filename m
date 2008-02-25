From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: "Contributors never merge" and preserving history
Date: Mon, 25 Feb 2008 13:35:36 -0800 (PST)
Message-ID: <alpine.DEB.1.00.0802251330340.28694@dell.linuxdev.us.dell.com>
References: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org> <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 22:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTl02-0008Li-Ch
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbYBYVgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbYBYVgA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:36:00 -0500
Received: from flpi195.sbcis.sbc.com ([207.115.20.197]:3537 "EHLO
	flpi195.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYBYVgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:36:00 -0500
X-ORBL: [69.232.226.160]
Received: from sf.creativecommons.org (adsl-69-232-226-160.dsl.pltn13.pacbell.net [69.232.226.160])
	by flpi195.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m1PLZcLl032315;
	Mon, 25 Feb 2008 13:35:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTPS id 36770174C41C;
	Mon, 25 Feb 2008 13:35:36 -0800 (PST)
X-X-Sender: paulproteus@dell.linuxdev.us.dell.com
In-Reply-To: <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75071>

On Mon, 25 Feb 2008, Linus Torvalds wrote:

>   For example, let's say that you're developing a driver. If you start at
>   some specific kernel version (say, 2.6.24) and you do *not* generally
>   merge from my development tree, now suddenly other people can happily
>   pull from your tree to get the driver, even if they are stable kernels
>   or vendor kernels that don't want all the development crud that is in
>   my tree!
>
>   See? Keeping a clean history actually makes your tree more useful!

I'm going to chime in on this thread as a relative newcomer to git.  If 
I'm developing a driver or other feature branch, and then a new upstream 
release comes along, I can't rebase and push - that would make the "is not 
a strict subset of local ref" complaint.

Is the right workflow, then, to rebase against 2.6.25 in a new local 
branch, and push that to a new remote branch for others (like you say, 
vendor kernel maintainers) to pull from?

Thanks!

-- Asheesh.

-- 
Who will take care of the world after you're gone?
