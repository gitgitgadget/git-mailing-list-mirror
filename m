From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 21:57:17 -0700
Message-ID: <7vhcmfugnm.fsf@gitster.siamese.dyndns.org>
References: <400762.26134.qm@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, jnareb@gmail.com
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Sat Sep 01 06:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRL3A-00020O-0J
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 06:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXIAE5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 00:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbXIAE5Z
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 00:57:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbXIAE5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 00:57:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F1CC2129BE6;
	Sat,  1 Sep 2007 00:57:40 -0400 (EDT)
In-Reply-To: <400762.26134.qm@web31810.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 31 Aug 2007 19:15:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57251>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I am a bit worried about the 'master' being a "StGIT stack",
>> though.  Playgrounds to be cherry-picked from (aka 'pu') would
>> make *perfect* sense to be managed that way (and the topics that
>> go only 'pu' of git.git itself are managed the same except that
>> I do not do so using StGIT), but I think we need a stable
>> history for the branch git.git will eventually pull from.
>
> That was my concern too, but seeing the immediate hostility
> I got about asking about the review process I decided not
> to mention it.

I do not think Johannes meant any hostility against you by
mentioning the obvious "person A sets up a repository, he gets
to decide rule for _his_ repository", implication of which is
that anobody else can do the same.

It is a completely different matter how the bits of the results
are decided to be good and bad and merged as part of git.git,
and that will be done with community input as always.

I asked Pasky to host series of patches for various reasons.

 (1) I know I am less qualified than Pasky, you nor Jakub (the
     three people I publicly said I consider more interested in
     and have experience with gitweb than I am).  If I were to
     sift through the patches, I am sure many patches will rot
     because of indecision.  I wanted to make sure people more
     interested in gitweb than myself play more active role in
     its development and maintenance.

 (2) It would make it easier to view and judge the impact of
     pending patches if the code is used on to show various real
     repositories to the public.  repo.or.cz is an ideal place,
     and Pasky has shown competence managing that service to the
     community.  A change to gitweb may look obviously correct
     with just minor performance impact while code inspection,
     but may have scaling issues in the real world --- he will
     have the first hand experience to catch that.  Anybody
     could set something like that up, but I trust the three
     gitweb gang more or less equally, so why not utilize the
     infrastructure we already have, especially Pasky agreed to
     help?

 (3) I have disagreed on a handful technical issues with Pasky,
     you and Jakub, but I do not expect all of us to always
     agree something is good or bad unanimously, nor I expect it
     would satisfy everybody in the community even if we agree
     on something unanimously, if we acted as a Cabal.  One
     thing that is important is that the process is transparent.

     I trust Pasky to be open-minded as any of us would be.  I
     do not expect him to start acting as a dictator on gitweb
     issues and force bad technical decisions without listening
     to others.  I trust him at least that much.  I would
     probably trust you or Jakub the same way, but I do not have
     to pick one single person that I trust _most_.  As long as
     the person who maintains the gitweb patch queue is trusted
     and respected _enough_ by the community, I think that is
     good enough.  And this is all volunteer work.  Good
     maintainers are hard to find.

> I'd be interesting to see how gitweb support pans out
> given this initial hostility to inquiry of accountability.
>
> Over the years I've seen that the best support and accountability
> has been had when the maintainer is not the main contributor/developer,
> especially for shared development. Otherwise personal preferences over
> feature X and Y come into play and then things get ugly.

I understand your concern, and I think that is where you can
help the most.  If you see questionable patches queued, spot
them and raise issues.  We've been a friendly community, and
luckily we haven't had too many burnt bridges over personality
differences.

We have a _LOT_ of work ahead of us in gitweb area.  You may
remember that there was a call-for-help from k.org gitweb master
(J. H. "warthog9", with comments from HPA) some time ago.  The
installation there is heavily modified to support a large and
heavily-hit site better than the stock gitweb, but the codebase
has diverged quite a bit.  We need to fold that effort back so
that (1) they do not have to keep maintaining their fork, and
(2) everybody else will benefit from their scalability work.
