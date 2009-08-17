From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/6] "git commit --dry-run" updates
Date: Mon, 17 Aug 2009 12:01:41 +0200
Message-ID: <200908171201.43343.trast@student.ethz.ch>
References: <1250330803-22171-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 12:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcz2b-0002Ix-5t
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 12:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbZHQKCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 06:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbZHQKCD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 06:02:03 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26747 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbZHQKCC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 06:02:02 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 12:02:04 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 12:02:02 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <1250330803-22171-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> The third and the fourth ones tentatively introduce "git stat".  The
> former is an incomplete implementation that ignores the pathspec, and the
> latter adds pathspec limiting to it.  In the final form before it goes to
> 'next', these two should probably be squashed.

If it's not too much work, it would be nice to somehow detect if -u
can have any influence at all.  For example,

  $ git status bar
  # Not currently on any branch.
  nothing to commit (use -u to show untracked files)

is a bit misleading if 'bar' is tracked because adding a -u won't make
any difference.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
