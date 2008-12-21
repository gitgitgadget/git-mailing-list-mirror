From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Swap positions of 'next' and 'prev' buttons in the
 'Find' section.
Date: Mon, 22 Dec 2008 09:59:54 +1100
Message-ID: <18766.51818.313516.421046@cargo.ozlabs.ibm.com>
References: <4948E779.9080909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 22 00:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEYCJ-0000QN-Tj
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 00:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYLUX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbYLUX5l
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 18:57:41 -0500
Received: from ozlabs.org ([203.10.76.45]:34473 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbYLUX5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 18:57:39 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4D2ECDDDEE; Mon, 22 Dec 2008 10:57:38 +1100 (EST)
In-Reply-To: <4948E779.9080909@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103732>

Johannes Sixt writes:

> The button order 'prev' left of 'next' feels more natural than the other
> way round, in particular, compared to the order of the forward and backward
> arrows that are in the line above.

The next/prev labels are a bit awkward in any case, since "next" finds
an earlier commit - one further down the list, and "prev" finds a
later commit - one further back in the list.  A better solution might
be to make images for arrows pointing up and down and use compound
buttons so the buttons say Find ^ and Find v (if you image the ^/v as
up and down arrows).

I also find myself often wanting a "Find first" button, i.e. search
starting at the top of the list.

Paul.
