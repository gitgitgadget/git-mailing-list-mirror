From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Sun, 13 Jul 2008 14:38:43 -0700
Message-ID: <7vmyklpiqk.fsf@gitster.siamese.dyndns.org>
References: <4876B223.4070707@gmail.com>
 <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9IN-0004Gm-TT
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYGMVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbYGMVix
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:38:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbYGMViw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:38:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6007C2AB0E;
	Sun, 13 Jul 2008 17:38:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 99CA42AB0C; Sun, 13 Jul 2008 17:38:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 162F1C40-5124-11DD-95A1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88346>

Lea Wiemann <lewiemann@gmail.com> writes:
> Here's some elaboration on why I didn't use or extend Git.pm.
>
> Please note before starting a reply to this: This is not an argument;
> I'm just explaining why I implemented it the way I did.  So please
> don't try to argue with me about what I should or should have done....
> ...
> So where do we go with Git.pm and Git::Repo?  I would suggest that
> they both stay.

This probably is something the person who mentors you as a GSoC student
should tell you, and shouldn't come from me, but I am going to mention
it anyway.

I thought GSoC program was about giving participants a chance to acquire
skills to work better with open source community, and I firmly believe
that a major component of that skillset is about working with people,
probably even more so than about working with code.  Of course you need
have a certain basic coding skills and disciplines, but it is clear to
everybody that you are beyond that threashold already.  I would have
preferred to see the first paragraph of yours stated more diplomaticly;
it sounds rather unilateral ultimatum to me.

Having said that, I agree with your reasoning.  People who care enough can
help refactoring Git.pm to build on top of Git::Repo (this would include
adding missing Git::WC and possibly others), but I agree that would
largely be outside of the scope of gitweb caching.

This patch was not signed-off, but I assume it was simply forgotten and
not deliberate?
