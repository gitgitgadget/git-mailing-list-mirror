From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 16:19:05 -0600
Message-ID: <87wr95x06e.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<7vboqino1r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greene <dag@cray.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rivja-0001sx-M4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938Ab2AEWYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 17:24:25 -0500
Received: from dsl001-154-008.msp1.dsl.speakeasy.net ([72.1.154.8]:45713 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932516Ab2AEWYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 17:24:24 -0500
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RiveL-0000uF-DW; Thu, 05 Jan 2012 16:19:05 -0600
In-Reply-To: <7vboqino1r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 05 Jan 2012 07:53:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188001>

Junio C Hamano <gitster@pobox.com> writes:

> David Greene <dag@cray.com> writes:
>
>> How does the git community want the patch presented?  Right now it's one
>> monolithic thing.  I understand that isn't ideal but I don't think
>> incorporating the entire GitHub master history is necessarily the best
>> idea either.
>
> It depends on the longer term vision of how the result of this submission
> will evolve and more importantly, where you fit in the piture.

This is a very fair question.  I'll try to answer it as best I can.  I
think it mostly jibes with your suggested possible answer.

I've been using git-subtree for about six months now and as an
enthusiastic user who wants to introduce this too into my daily
corporate work environment, I'd like to see it incorporated as an
officially-supported git tool to make that introduction easier.

So my intention is to make git-subtree an integral part of the core git
suite and take on further maintenance and development along with Avery
and the other git-subtree developers.

I have not previously been a contributor to git-subtree and don't know
the code at all but I am a quick learner.  The actual git-subtree code
itself is not overwhelmingly large and strikes me as a tractable
learning project.

I approached Avery about submitting git-subtree to become part of the
core git suite.  He responded positively but indicated he does not have
the cycles to do it at this time.  He asked whether I could take on the
job and I agreed.

He mentioned that he'd talked to some developers at GitTogether and got
a positive reponse there.  I don't know whether you were part of those
discussions.  My impression is that the GitTogether discussions went
well and there was general agreement that git-subtree would be a
valuable addition to the core git suite.

I am perfectly happy to put this in contrib/ first if it eases the
introduction.  I would like to move it to the subcommand area after
getting everything in tip-top shape.  What I don't want is for it to
languish forever in contrib/.  That means I'll need some guideline of
the changes/standards necessary to qualify it for transition from
contrib/ to an official subcommand.  I expect we'll develop that as we
go along but I hope the git community has some institutional knowledge
gathered from previous experience.

I have asked Avery how he wants to do maintenance going forward.  I
haven't heard back from him yet so I can't speak to whether the existing
GitHub project will continue or not.  I'll pass along his thoughts when
I get them.

> Your answer might differ, of course, but the point is that we would need
> to weigh pros and cons between inclusion of it in the git repository and
> keeping it in Avery's repository and have him and his contributors
> maintain, enhance and distribute it from there, and it largely depends on
> the nature of the submission. Is it a "throw it over the wall" dump of a
> large code of unknown quality that we need to clean up first without
> knowing the vision of how "git subtree" should evolve by original author
> and/or people who have been actively developing it?

I certainly don't want this to be an "over the wall" operation.  I
intend to participate in maintenance of git-subtree in the official git
repository.

So I'll go ahead and work on adding this to contrib/.  Once I get a
response from Avery about his long-term vision I'll pass that along and
we can have further discussion.  I may start sending patches to the
mailing list for review before hearing back from him, however.

Sound good?

                             -Dave
