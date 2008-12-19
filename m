From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Thu, 18 Dec 2008 16:28:11 -0800
Message-ID: <7vabatf1pg.fsf@gitster.siamese.dyndns.org>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
 <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness>
 <20081219000218.GA23990@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
X-From: git-owner@vger.kernel.org Fri Dec 19 01:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTFb-0002OQ-KN
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbYLSA2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYLSA2X
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:28:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYLSA2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:28:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E39688DE1;
	Thu, 18 Dec 2008 19:28:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A0F5488DDF; Thu,
 18 Dec 2008 19:28:13 -0500 (EST)
In-Reply-To: <20081219000218.GA23990@linux.vnet.ibm.com> (Paul E. McKenney's
 message of "Thu, 18 Dec 2008 16:02:18 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F07251FE-CD63-11DD-8A9B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103518>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Fri, Dec 12, 2008 at 07:57:38PM +0100, Johannes Schindelin wrote:
> ...
>> I am sure we want to have something like that in git.git.
>
> So am I.  Except that I am not being sarcastic.  ;-)

Hmm, but we seem to already have too many intro-to-git documents in tree.
Perhaps good points in the document can be used to augment or replace
parts of existing documents?  For example, which part of the new
documentation would have helped you avoid the pain you mentioned below...

> In particular, David's guide was quite helpful to me.  It would have been
> even more helpful had it existed when I first tried (unsuccessfully)
> to use GIT.  In particular, GIT's requirement that I tell it about new
> versions of existing files (either with "git add" or "git commit -a")
> was extremely counter-intuitive, and caused me no end of pain.

... and which part of the existing user manual or tutorial should have
talked about it to help you?

> But my experience is that git is at best an acquired taste for those of
> us who grew up with traditional source-code control systems.  Such
> people will benefit greatly from a git-haters guide,...

"Acquired taste" is a much nicer and more diplomatic way to say the same
thing as what Linus often refers as "unlearning the braindamage inflicted
by years of using CVS." ;-)

> ..., and git's user
> population will grow as a result.

I do not think it constitutes any basis for judging the merit of having
the document in git.git tree.  The world domination is not our goal, but
it may come as a mere side effect of being the best in the business.
