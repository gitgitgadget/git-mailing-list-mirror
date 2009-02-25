From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 01:26:11 -0800
Message-ID: <7viqmy7tqk.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
 <20090225090230.GA15919@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcG3W-0000rc-LY
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbZBYJ00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbZBYJ0Z
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:26:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZBYJ0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:26:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBCA39D5FC;
	Wed, 25 Feb 2009 04:26:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ECD6E9D5F9; Wed,
 25 Feb 2009 04:26:13 -0500 (EST)
In-Reply-To: <20090225090230.GA15919@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 25 Feb 2009 04:02:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D73236A-031E-11DE-8F53-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111419>

Jeff King <peff@peff.net> writes:

> But I don't buy this at all. It is totally dependent on workflow and how
> you use branches.

Of course. "Encouraging a behaviour" means just that.  A better workflow
and a better use of branches.

> When you think about "is my current branch ready to push?" there is no
> reason for you to think of that other long-running branch that you
> haven't seen for days.

Sorry, I have to disagree with that.

We are talking about people to whom the "push matching refs" is a problem,
and that means they are using a branch with the same name with other
people (either from a shared central repository or his own publishing
branch) to house long-running, intermediate, uncooked state.

Why aren't you forking off your own topic branch from such a branch that
is either shared (or for publishing)?  For the purpose of this discussion,
shared branch is the same as your own publishing branch -- that's where
you put things that are *ready* to be seen by other people.

The one you haven't seen for days, if it is not shared, won't bother you
nor your "matching push", because you wouldn't have merged your uncooked
changes from your own topic branch to that shared branch yet.
