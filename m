From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rev-list diff options broken
Date: Tue, 6 Nov 2007 23:33:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062330220.4362@racer.site>
References: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Nov 07 00:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXw8-0007Ph-K9
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbXKFXeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbXKFXeI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:34:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:44202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbXKFXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:34:06 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:34:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp049) with SMTP; 07 Nov 2007 00:34:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qiIJIuytq/NX493fzO5t2EhYMU7y79GZFjcf18z
	nWGw2APKMxoJbW
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63749>

Hi,

On Tue, 6 Nov 2007, Han-Wen Nienhuys wrote:

> the git-rev-list manpage says
> 
> 
> **
> Diff Formatting
> ~~~~~~~~~~~~~~~
> 
> Below are listed options that control the formatting of diff output.
> Some of them are specific to gitlink:git-rev-list[1], however other diff
> options may be given. See gitlink:git-diff-files[1] for more options.
> **
> 
> however, the source code says
> 
> 
> 	if ((!list &&
> 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
> 	      !revs.pending.nr)) ||
> 	    revs.diff)
> 		usage(rev_list_usage);
> 
> so any attempt at showing diffs with git-rev-list will fail. What's
> the deal with this?

Probably you want to use "git log".

"git blame -L 585,589 builtin-rev-list.c" indicates that 8c1f0b44(Fix up 
rev-list option parsing) was responsible, which in turn indicates that it 
was intentional.

Hth,
Dscho
