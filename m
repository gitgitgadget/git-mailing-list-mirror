From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git rev-list formatting
Date: Mon, 22 Mar 2010 07:39:38 -0400
Message-ID: <m3eijcpoud.fsf@winooski.ccs.neu.edu>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 12:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntfzd-0004mZ-5F
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab0CVLjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:39:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:36189 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab0CVLju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:39:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ntfz2-0004Wv-Q7
	for git@vger.kernel.org; Mon, 22 Mar 2010 12:39:49 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 12:39:48 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 12:39:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:MRT/p422wcnFtMFFobhmazaL7xM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142924>

Eli Barzilay <eli@barzilay.org> writes:

> [...]
>
> Also, is there a way to avoid the "commit <sha1>" line, print some
> information that I specify in the format string, and show the whole
> message as is (without wrapping or other tweaks)?

Looks like `git log' does something similar to what I want anyway,
which leads me to a related question -- it's not clear to me what are
the differences between `git rev-list', `git log', `git diff', and
`git show', since it looks like they can all be tweaked to produce
similar outputs.  Are they all the same with different outputs?  Is
there some description of them with the differences explained?

Also related, it looks like `--abbrev-commit' has no effect on `git
rev-list', but does on `git log', even through it's documented in the
former's man page.  So it looks like either there are more
(undocumented?) differences, or maybe that's also a bug?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
