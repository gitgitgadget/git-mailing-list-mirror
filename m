From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Rebase problems
Date: Fri, 12 Nov 2010 00:07:37 +0000 (UTC)
Message-ID: <loom.20101112T005610-259@post.gmane.org>
References: <loom.20101108T190513-206@post.gmane.org> <FA37BC66-64CF-4A62-80E9-EC45EAE392C4@wincent.com> <4CD856B8.7030305@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 01:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGhBM-0002oA-FS
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 01:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab0KLAHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 19:07:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:33770 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128Ab0KLAHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 19:07:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGhBD-0002jh-U9
	for git@vger.kernel.org; Fri, 12 Nov 2010 01:07:48 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 01:07:47 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 01:07:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161311>

Maaartin-1 <grajcar1 <at> seznam.cz> writes:

> On 10-11-08 19:33, Wincent Colaiuta wrote:
> > - If you are really enamored of timestamps, would extracting the latest 
commit timestamp out of the repo be enough?
> 
> Sure it would, I was mostly ignoring the commit timestamp until now, and
> didn't notice that I'm using a different timestamp for the executable
> without any reason. Now I need just trivial changes.

Time to comment on myself:

It works nice, but there's a small problem. I can't take the author date since 
it gets preserved across rebases, so I could get non-unique dates. The committer 
date corresponds with the time I actually create the executable, and I really 
not going to produce more than one executable per second, so it works nicely. 
Except for rebase, which can create a lot of commits with the same committer 
date quickly.

Currently I'm using cygwin and rebase is slow like hell, but when I switch to 
Linux, I'll need something to ensure that there'll be no two commits with the 
same committer date. I think even a one second sleep could do for me, but can I 
arrange for it easily?
