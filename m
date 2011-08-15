From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [feature wishlist] add commit subcommand to git add -i
Date: Mon, 15 Aug 2011 14:54:29 +0200
Message-ID: <201108151454.29912.trast@student.ethz.ch>
References: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 14:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qswgi-0004Yh-KT
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 14:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab1HOMyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 08:54:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:37816 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab1HOMyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 08:54:33 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 15 Aug
 2011 14:54:29 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 15 Aug
 2011 14:54:30 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.0-39-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179364>

Jim Cromie wrote:
> [f]ragment would also be handy, which would break each chunk of a diff
> into a separate commit, with the summary line provided automatically
> <file> @@ -696,7 +692,7 @@ int foo ...
> 
> This would help a bit with random cleanups, since rebase -i could then
> be used to
> reorder and recombine the fragments, and edit the commit messages afterwards.
> 
> going further, if git rebase -i  had ability to  "back" a fixup patch
> back to where it should have been

This little script may be of interest to you:

  http://article.gmane.org/gmane.comp.version-control.git/163621

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
