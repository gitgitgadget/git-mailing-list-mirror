From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Sun, 15 Mar 2009 21:53:19 -0700
Message-ID: <7vprgiysow.fsf@gitster.siamese.dyndns.org>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
 <20090303091504.GG3627@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 16 05:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj4qz-0000t8-NN
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 05:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbZCPExZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbZCPExZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 00:53:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZCPExZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 00:53:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A559D6DCE;
	Mon, 16 Mar 2009 00:53:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0431C6DCD; Mon,
 16 Mar 2009 00:53:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61161050-11E6-11DE-BE51-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113309>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 03, 2009 at 01:01:45AM -0800, Junio C Hamano wrote:
>
>> As an experiment, 'next' and 'pu' stayed open during this release freeze;
>> new topics have been accepted.  I have to say that the experiment was a
>> moderate success, and many topics in 'next' seem to be of fairly high
>> quality already, which would mean that we will have a shorter cycle before
>> 1.6.3.
>
> I was going to stay quiet on this issue until after 1.6.3 released, but
> now you have opened the topic. :)
>
> I think seeing the quality of topics in 'next' is only half of
> "success". You have to also consider how much attention was given to the
> about-to-be-released version (and its impact on quality). And I think we
> won't know about that until we see how quickly we need 1.6.3.1. :)
>
> Personally, I know that I have spent much less time focusing on
> 'master'. Like everyone else, I have limited git bandwidth, and topics
> in 'next' are simply more interesting. I think it's easier to put them
> aside for a few weeks if everybody agrees to do so (rather than having
> interesting discussion proceeding without you if you choose to focus on
> 'master').

With the first maintenance release after 1.6.2 behind us, I think we can
start to judge how successful the 1.6.2 cycle was fairly objectively.

During the pre-release freeze, we would want to encorage people to spend
as much time as possible on finding and fixing bugs and regressions in the
frozen 'master', and that was the reason why traditionally we closed
'next' during the pre-release freeze.

But in reality, contributors who had leftover topics on 'next' simply
stopped working on their topics on 'next' without spending the freed up
time on concentrating on 'master'.  In an ideal world, the choice would be
between "git time on 'next'" vs "git time on 'master'", and closing 'next'
was meant to force the choice, but instead the outcome became "less git
time until 'next' reopens".

My suspicion, when deciding to keep the 'next' branch open during the
freeze, was that as long as people look at _any_ git code, even if it is
because they are working on their own topic that will never be in the
upcoming release, it would increase the chance of bugs getting discovered.

I do not know the exact count of bugfixes after 1.6.2-rc0 are attributable
to people who happened to notice glitches by accident while working on an
unrelated enhancements, but for me personally, I tend to notice more bugs
when I am not hunting for one but working on something else.

Also as a side effect, we had many topics on 'next' that are already
reasonably mature after 1.6.2, and I think we can have a short cycle for
the next one.
