From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Thu, 09 Aug 2007 09:55:00 +0200
Message-ID: <86r6mdqh0r.fsf@lola.quinscape.zz>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com> <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de> <85lkclrdpr.fsf@lola.goethe.zz> <20070809032610.GA24573@spearce.org> <85odhhntmb.fsf@lola.goethe.zz> <20070809065810.GC24573@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 09:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2s0-0003wx-WC
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764748AbXHIHzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 03:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761006AbXHIHzo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:55:44 -0400
Received: from main.gmane.org ([80.91.229.2]:56986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXHIHzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:55:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ2rr-0003Ej-5i
	for git@vger.kernel.org; Thu, 09 Aug 2007 09:55:39 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 09:55:39 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 09:55:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:4YPnJaXgHbrpvjgvmlqhu7ypWUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55424>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> >> Well, yes.  But git-gui only works on a single branch head at a time,
>> >> and that is not enough for rebasing.
>> >
>> > Sure.  But so does git's command line tools.  They tend to only
>> > work on a single branch at time, the one called `HEAD`.
>> 
>> "tend", and many accept an explicit override: rebase accepts three
>> commit names, for example.  Those that _write_ into the repository
>> usually _end_ up at HEAD, but most need not start there.
>> 
>> And git-gui does not have any operation either looking at or working
>> other than on the current HEAD.  No diff, no file view, no rebase,
>> nothing.
>
> Uh, "Repository->Browse Browse Branch Files..." will let you look at
> files from any commit-ish, not just HEAD or an existing branch.

Duh.  But why are the menus called "Browse master's Files" and "Browse
Branch Files" rather than "Browse heads/master" or "Browse master's
head" versus "Browse any commit" or maybe just "Browse current" and
"Browse at ..."?  "Browse Branch Files" is _really_ misleading.

> You can open many file browsers at once against the same commit or
> different commits.  Double clicking a file opens it in the blame
> viewer, which itself can move around history a little bit.

I though about the blame window after my first posting (actually, I
did not yet notice one can move around in the revisions in the blame.
Nice.  Now if it supported utf-8 files...).  Well, yes.

> "Merge->Local Merge..." will let you select any another commit to
> merge with this current branch.  That's two commits.

Ok, ok.  Still, commits and history are much more visible as whole in
gitk: git-gui mostly lets one pick out single views (the blame window
is probably the closest one gets to moving about, but then it _is_ a
moving view which always shows a single point of time ultimately).

> So your assertion that git-gui only works with one commit, HEAD,
> is wrong.

Yes.

-- 
David Kastrup
