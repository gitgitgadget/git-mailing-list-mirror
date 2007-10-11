From: David Kastrup <dak@gnu.org>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:18:17 +0200
Message-ID: <86lka9spjq.fsf@lola.quinscape.zz>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 16:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifyvn-00049A-W7
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbXJKOWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbXJKOWV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:22:21 -0400
Received: from main.gmane.org ([80.91.229.2]:55593 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbXJKOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:22:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ifytf-00044q-4i
	for git@vger.kernel.org; Thu, 11 Oct 2007 14:20:19 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 14:20:19 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 14:20:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:YJ79UivZ1ZEO2OoyvTFhjg2Ae8A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60600>

"Patrick Doyle" <wpdster@gmail.com> writes:

> Sorry for cluttering up the list with yet another very basic workflow
> question, but I'm still struggling with finding an answer to the
> burning question, "What can git do for me?"  (So far, I have come to
> the conclusion that, for my simple, single developer, branchless,
> linear projects, there's not much that git can do for me that any
> other SCM could do for me.  It appears to have been designed to solve
> problems for which I have absolutely no appreciation whatsoever. :-))
>
> Anyway, on to basic newbie quesion #107...
>
> I've been working on my project and I realize that I have 3-4 files
> modified with two orthogonal sets of changes.  (I didn't realize this
> until I said to myself -- "Self, I should really check in these files
> before I go too much further down this path".)  So I start "git
> diff"-ing the files and I find that most files have differences
> related to only one change or the other, but one file has differences
> related to both changes.
>
> What do others do in this situation?
> a) Not allow themselves to get into this situation in the first place
> by careful planning?
>
> b) Copy the file to "file.bothchanges", edit out one set of changes,
> commit that with one log message, edit back in the other set of
> changes, edit in the other set of changes, commit that with another
> log message?
>
> c) Use some sort of automation to do option (b) for them?
>
> d) Something else?

git-add -i

-- 
David Kastrup
