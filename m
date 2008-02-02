From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 22:10:04 +0200
Organization: Private
Message-ID: <abmj3ysj.fsf@blue.sea.net>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
	<m3d4rf7a4r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 21:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLOi0-0000VR-2q
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 21:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761459AbYBBUKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762017AbYBBUKy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 15:10:54 -0500
Received: from main.gmane.org ([80.91.229.2]:52919 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761045AbYBBUKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 15:10:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLOhJ-00031Z-8n
	for git@vger.kernel.org; Sat, 02 Feb 2008 20:10:45 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 20:10:45 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 20:10:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:0MVuJ7arnT7PL4H8YRSiP4K8zqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72300>

* Sat 2008-02-02 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m3d4rf7a4r.fsf@localhost.localdomain
> Jari Aalto <jari.aalto@cante.net> writes:
>> I use HEAD~1 always, because I think the consistency in learning the
>> most important factor.
>
> "HEAD~1" and "HEAD~2" are not shorter than original notation.

I'm afreaid that "optiomization" is seen a virtua in the manual pages.
I certainly do not wish to use "shorter", if it would mean "less readable"

It's certianly true that the cognitive burder to see foreign construct
is higer than, when you can associate a thing to familiar one.

Here, he familiarity from other CVSs is term HEAD or TIP, which follows
that

    HEAD~1

in context of other similar ones (HEAD~2, HEAD~2 ...) is self evident
without further explanations.

> The documentation should cater to both advanced users and newcomers,

The advanced user's don't matter. People will become advanced over time,
with their own learning paths.

The documentation should prefer the most readable format. There can
always be separate geek manaual if needed.

> IMHO the sequence: 
>   "HEAD^1"     -> "HEAD^", 
>   "HEAD^1^1^1" -> "HEAD^^^" -> "HEAD~3"
> is the proper sequence to teach.

Only from GIT perspective, if you've gwon with git. For every other
designer used to the CVSs, it's the RCS/CVS/SVN temrinology and
concept of HEAD. Only then comes the other issues.

We don't expect to grasp the "decentralization", without first being
familiar with older systems, so the more natural progression is:

    HEAD~1  ->  HEAD^1 > HEAD^
    HEAD~2  ->  ...

> Especially that "rev^sth" is used also for other things, like
> "HEAD^{tree}", or "v1.3.0^{commit}" peeling operators, or even
> "master^0" used to force detach HEAD to 'master'.

Only very small grou of persons will ever need very advanced features. I
don't even understand what those mean and haven't have any ose for
those. The "get previous version", "get N version backward in diff" are
the 99% daily bread.

>> People usually migrate to git from other VCSs, which have very
>> consistent UI - There are no alternatives
>> 
>>     -r1:10      Subversion
>>     -r1..19     Bzr
>>     ...etc
>> 
>> It's unfortunate is the focus is given to comments like "easier type",
>> when the context is the manual pages.
>
> This is stupid example.

It's perfect example. The key was "consistent UI", which git does not
yet have, nor does the documentation. The version numers were not my
point.

You really want to count this:

    HEAD^^^^^^^^^^^^

How many revisions again that was? That tells something about the UI.

> It is also much less powerfull, as it can only follow first-parent
> line. In the presence of merges you usually use ^n more.

Everything is powerfull in git. There is no doubt about it, but there is
difference how "to serve the audience". If Git wishes, and I sincerely
hope, that the focus is not "advanced users" per se.

> That said, I personally don't have strong preference whether to use
> "HEAD", "HEAD^", "HEAD^^", "HEAD~3" in examples, or "HEAD", "HEAD~1",
> "HEAD~2", "HEAD~3". It is a bit of "bikeshed" discussion.

I feel that this is very essence of the the path. What, if any, is the
strategy to develop the documentation towards. What kind of
conversations, exmaples and notations are used to convey the content in
uniform way to the reader.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
