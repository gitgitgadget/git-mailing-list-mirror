From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
	number links
Date: Tue, 27 Sep 2011 11:49:47 +0200
Message-ID: <20110927094947.10955.qmail@stuge.se>
References: <1317060642-25488-1-git-send-email-peter@stuge.se> <7v62kf2jf4.fsf@alter.siamese.dyndns.org> <20110926194639.25339.qmail@stuge.se> <7vipof0zx0.fsf@alter.siamese.dyndns.org> <20110926222801.14985.qmail@stuge.se> <4E8170B3.8040205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:49:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8UIX-0001bq-W2
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab1I0Jtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 05:49:53 -0400
Received: from foo.stuge.se ([212.116.89.98]:43909 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631Ab1I0Jtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 05:49:52 -0400
Received: (qmail 10956 invoked by uid 501); 27 Sep 2011 09:49:47 -0000
Content-Disposition: inline
In-Reply-To: <4E8170B3.8040205@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182229>

Hey!

Johannes Sixt wrote:
> > It's a simple fix of links broken by manual URI manipulation that
> > didn't consider fragments. Is the subject description really not
> > enough?
> 
> No, it is not. The target audience of a commit message are people like I
> am. I do know a bit of Perl, and a bit of Javascript; I know how an URL
> is structured; I would find my way through the gitweb code if the need
> arises. But I am not an expert in any of these areas.
> 
> The subject alone is not sufficient because I do not know for sure what
> an "URI fragment" is or what role line numbers in gitweb's links play.

I shall continue playing advocatus diaboli only a little longer.


> The explanations and examples you gave in a later email were very
> enlightening, and they would be very helpful if *I* am forced to hack
> gitweb, and if I need to understand why this particular change was good.

On the other hand you're just one quick google search on uri fragment
away from the same enlightenment, and relying on terminology saves on
unneccessary redundance.

Lorelei: That's repetitive
Rory: ..and redundant.
Lorelei: That's repetitive
Rory: ..and redundant.

(SCNR the pop culture reference! :)


> Finding the right balance between verbosity and terseness needs
> practice,

I disagree, but I agree with you if we qualify that a little. The
right balance is a matter of subjective review, so the only way it
can be practiced with relevance is by actually working with the same
reviewers for a while, to learn what they consider right.

It can absolutely not be practiced out of context, ie. with different
peers. No later than the day before I sent this patch I wrote a
welcome mail in another open source project, to a new contributor,
where one bit was about commit messages.

http://marc.info/?l=openocd-development&m=131698532523018

"* Write a top quality commit message, technically and logically

...
As for the logical quality, it is important to write the first line
description of the change so that it makes sense for someone who
knows nothing at all about the code, since this is used in list
views, and since the background for this code and for why this change
was done the way it was done comes only in the later lines, which may
not be available from where that list view is. ... Keep it
high level, clear and simple. Writing this one line is not
neccessarily easy."

I of course also try to practise exactly this, but it's difficult to
know what reviewers expect to be fed, or how much verbosity they
prefer. :) I tend to prefer as much useful information as possible in
the first line, while keeping it ideally <60 chars. Many times I find
it to be enough.


> but to write *no* justification is practically always wrong.

I disagree strongly that I wrote no justification. I agree that it
was not verbose. I'm sorry that this is a problem. I'm personally
allergic to redundancy such as the commit message Jakub wrote, I
think it's not only reasonable but also desirable to avoid that.
Maybe gitweb is a special case in git.git though, I don't know, but
I'm a little surprised. :)

Anyway, I'm more than happy to write a more verbose message for you!


//Peter
