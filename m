From: Miles Bader <miles@gnu.org>
Subject: Re: Not pushing all branches?
Date: Sat, 14 Mar 2009 10:08:20 +0900
Message-ID: <874oxwgbcr.fsf@catnip.gol.com>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
	<43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
	<7v4oxxgpil.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 02:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiIO6-0007cC-Rp
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 02:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbZCNBIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbZCNBIg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 21:08:36 -0400
Received: from main.gmane.org ([80.91.229.2]:43773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbZCNBIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 21:08:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LiIMa-0007uJ-Lz
	for git@vger.kernel.org; Sat, 14 Mar 2009 01:08:32 +0000
Received: from 218.231.175.8.eo.eaccess.ne.jp ([218.231.175.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 01:08:32 +0000
Received: from miles by 218.231.175.8.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 01:08:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.175.8.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:UeS28iUyGuGlUXvsYafp6n91Qmg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113230>

Junio C Hamano <gitster@pobox.com> writes:
>    - The first "-" one; even though it may be useful to be able to say
>      "the remote the current branch is associated with by default", using
>      "-" as a short-hand for that might be harmful to the long term UI
>      health, and further study was requested, which hasn't been responded
>      yet.

I've often wished for such a thing in some contexts, actually...
e.g., "git diff REMOTE_BRANCH" to see what updates are pending if I
merge...  Also, it would be nice to have a more concise way to say
"git merge REMOTE_BRANCH".

I'm not sure "-" seems like the best syntax though... maybe it's a bit
_too_ short.

[Is there a general standard syntax for "keywords" in git, e.g., to
distinguish them from branch/rev names?  I mean, if the standard syntax
were "@foo", then one could imagine "git diff @remote" or something.]

-miles

-- 
Run away!  Run away!
