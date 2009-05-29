From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFC PATCH] Documentation: teach stash/pop workflow instead of
 stash/apply
Date: Fri, 29 May 2009 00:59:06 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh1ucqq.6ls.sitaramc@sitaramc.homelinux.net>
References: <20090515021105.GA19241@coredump.intra.peff.net>
 <ef178b42f4db36811e07f1bca4436ed79e550957.1243502202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 02:59:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9qRZ-0007Z2-9U
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 02:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZE2A7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 20:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZE2A7X
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 20:59:23 -0400
Received: from main.gmane.org ([80.91.229.2]:41684 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbZE2A7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 20:59:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9qRJ-0003Cm-Dn
	for git@vger.kernel.org; Fri, 29 May 2009 00:59:17 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 00:59:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 00:59:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120244>

On 2009-05-28 09:40:15, Thomas Rast <trast@student.ethz.ch> wrote:
> Recent discussion on the list showed some comments in favour of a
> stash/pop workflow:
>
>   http://marc.info/?l=git&m=124234911423358&w=2
>   http://marc.info/?l=git&m=124235348327711&w=2
>
> Change the stash documentation and examples to document pop in its own
> right (and apply in terms of pop), and use stash/pop in the examples.

[snip]

> +Applying the state can fail with conflicts; in this case, it is not
> +removed from the stash list. You need to resolve the conflicts by hand
> +and call `git stash drop` manually afterwards.

For what it is worth, when I take classes on git in $DAYJOB
I insist on using only save/pop (and drop when needed as
described above).  My students are largely freshers with
little or no dev experience, and this just seems much more
intuitive.  Even the aspect of having to drop manually is
logical, because something exceptional happened.

I certainly would appreciate this patch, to answer the "RFC"
aspect in your subject line.
