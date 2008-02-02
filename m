From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 14:59:43 +0200
Organization: Private
Message-ID: <8x235xa8.fsf@blue.sea.net>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 14:01:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLHzS-0004wf-39
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 14:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYBBNA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYBBNA3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 08:00:29 -0500
Received: from main.gmane.org ([80.91.229.2]:38519 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352AbYBBNA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 08:00:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLHyo-0008W4-QY
	for git@vger.kernel.org; Sat, 02 Feb 2008 13:00:22 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 13:00:22 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 13:00:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:KPOXjRLpK59YSDRx05b88kkEzCQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72275>

* Sat 2008-02-02 Mike Hommey <mh@glandium.org> gmane.comp.version-control.git
* Message-Id: 20080202084406.GA15305@glandium.org
>> 
>> > -$ git reset --soft HEAD^      <1>
>> > +$ git reset --soft HEAD~1     <1>
>> > -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
>> > +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
>> > -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
>> > +$ git reset --soft HEAD~1 ;# go back to WIP state <2>

>> People need to refer to the HEAD^ (one commit ago) much more
>> often than HEAD~N for larger values of N. 

I use HEAD~1 always, because I think the consistency in learning the
most important factor.

It does not matter what advanced users use. The documentation should
primarily focus the newcomers.

The first question a newbie asks, if manual pages mixes syntaxes:

    What the heck "^" ?. I just saw HEAD~N, is the other one somehow
    special?

All the other examples refer to

    HEAD~N

Those used to git may prefer ^, but it does not follow that others
necessarily do so and that that should be the "proper learning path".
People usually migrate to git from other VCSs, which have very
consistent UI - There are no alternatives

    -r1:10      Subversion
    -r1..19     Bzr
    ...etc

It's unfortunate is the focus is given to comments like "easier type",
when the context is the manual pages.

>> Especially about HEAD~1, nobody sane would type that.

You consider all such users insane? It actually helps to select onlyt
one sytax, and HEAD~N is much more readable without further explanations,
(becasue people are already used to knowing, from other VCSs, what a
HEAD or TIP is). It's not all that different from prefering the
"--quiet" over "-q" e.g. e.g. in shell scripts.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
