From: walt <wa1ter@myrealbox.com>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 11:19:33 -0800
Organization: none
Message-ID: <dq11c6$g15$1@sea.gmane.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 10 20:20:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwP2N-0000zG-PS
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWAJTUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWAJTUE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:20:04 -0500
Received: from main.gmane.org ([80.91.229.2]:27078 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751305AbWAJTUB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 14:20:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EwP25-0000uP-5n
	for git@vger.kernel.org; Tue, 10 Jan 2006 20:19:49 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 20:19:49 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 20:19:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060110)
In-Reply-To: <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14437>

Linus Torvalds wrote:
[...]
> but the fact is, whenever you leave off the version specifier, it will 
> just assume that "current HEAD" is it...

I'm still very much struggling with nomenclature, and trying to
deduce what is a synonym for what, and which words cannot be used
synonymously.

Yesterday (while reading the bisect HOWTO) I did a git-revert on the
'bad' commit, which indeed fixed my bug.  But this caused a problem
this morning when I did my daily 'cg-update' for the kernel.

I got a merge conflict (of course) because of yesterday's git-revert.

My question (I think) is:  exactly what did I change when I did the
git-revert?  I notice in retrospect that (in refs/heads) master is
no longer identical to origin.  I think (but I'm not certain) that
the two used to be the same.  (For example, in my 'git' repository
the 'master' and 'origin' files are identical.)

Did the git-revert change my local kernel repository permanently?
Did the merge-conflict prevent today's cg-update from updating my
local repository with your commits from the last 24 hours?  Or is
the merge conflict only with my currently checked-out-and-modified
copy of the repository?

Is it clear to you why I'm confused? :o)  Most of my muddle is
because I don't know the definitions of some important words, I
suspect.

Thanks!
