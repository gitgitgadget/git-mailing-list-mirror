From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Git.pm: add rev_parse method
Date: Fri, 30 May 2008 13:28:42 -0700
Message-ID: <7vve0vilj9.fsf@gitster.siamese.dyndns.org>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
 <483FA6B3.4070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BER-0002iR-Cu
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYE3U2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYE3U2y
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:28:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbYE3U2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:28:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 858F32489;
	Fri, 30 May 2008 16:28:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A0B692486; Fri, 30 May 2008 16:28:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0382C76E-2E87-11DD-92EF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83331>

Lea Wiemann <lewiemann@gmail.com> writes:

> Should I perhaps stay on my branch with these changes, and then merge
> when it has stabilized (in 1-3 months)?
>
> One thing I'd be concerned about is that I might introduce fundamental
> issues in my API, since I'm neither a Git nor a Perl expert (yet
> ^^). What's the best way to avoid discovering such issues only at the
> Big Merge?

First of all, we do not do "Big Merge".  We merge small and we merge
often.  Nobody has perfect foresight, so you shouldn't be too afraid of
contaminating the public history with experiments that did not pan out
well.

> Is there anyone who'd be willing to monitor my commits and
> give me feedback on a semi-continuous basis?

Isn't it what your GSoC mentor is for ;-)?

You can seek wider exposure in various different ways:

 * Send [RFC] patches to the list; that's how this community is supposed
   to work, although I do not see as much reviews as I would personally
   want to see from other people these days for some reason [*1*].

   I may pick up "next" worthy ones to "next", and perhaps other ones to
   "pu" as time permits.

 * Have your repository on repo.or.cz (I thought GSoC student project for
   git were supposed to be hosted there?)  People interested in Perl
   interface in general and Gitweb in particular can try your progress
   out.


[Footnote]

*1* I suspect that maybe there is a misconception that patch submission
and review on the list is a dialogue between the submitter and the
maintainer.  It is _NOT_ the case.  I'd rather stay back, sipping my
Caipirinha, listening to _other_ people argue and improve the submitted
patches, while occasionally giving some guidance to the course of the
discussion.  And when the polished result emerges finally, apply it to my
tree, taking all the credit.  _That_ is how the community is supposed to
work, isn't it? ;-)
