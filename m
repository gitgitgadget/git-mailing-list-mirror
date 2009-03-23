From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/WIP 0/2] Documentation clean-up: git commands
Date: Mon, 23 Mar 2009 17:35:43 +0100
Message-ID: <49C7BA5F.9090600@drmicha.warpmail.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net> <7vwsag5hva.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lln9d-0003Lj-8O
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbZCWQgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbZCWQgF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:36:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60015 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866AbZCWQgE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 12:36:04 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3A2462FA2F1;
	Mon, 23 Mar 2009 12:35:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 Mar 2009 12:35:59 -0400
X-Sasl-enc: ezSMg4ewT8c+PZR/FN5Gv8+MXH7n3aGd+NOaWKsvhTPB 1237826158
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 95A1631F78;
	Mon, 23 Mar 2009 12:35:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090323 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vwsag5hva.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114333>

Junio C Hamano venit, vidit, dixit 23.03.2009 17:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> - Do we want it this way (`git command`)?
> 
> That's my personal preference but other people may differ; wasn't there an
> issue with "man" backend losing the typesetting information?

Some man readers reconstruct links when they see something like
git-add[1], which is why I proposed not changing those for now. A while
ago I introduced a backend specific linkgit macro (git-command for man,
git command for others), but that was not so well received.

>> - How to prepare: 1 patch per file/per 5 files/per 50 changes?
>> - How to submit: single patch once ready or whole series at end (5 years
>>   from now)?
>> - How to send: Bother the list or send pull requests only?
> 
> How about a fork of git.git on repo.or.cz that branches from 1.6.2 and that:
> 
>  - does not pull from git.git/master unless absoletely necessary; and
>  - contains only these clean-up changes and nothing else?
>

Whatever works for you. I have a fork there anyway but would need to
rebase to 1.6.2 as opposed to next. But somehow we would need to ensure
that new Documentation patches don't regress away from the consistent style.

> A bonus point would be for a publically reachable pages rendered out of
> the tip of this "documentation updates" repository, so that people can
> view it, compare it with www.kernel.org/pub/software/git/docs/.

I didn't plan on changing style, only making the usage of ` and such
more consistent. I find these are spotted most conveniently with diff
--color-words. Do you really think rendered versions are worthwhile for
that?

> I would love to have a separate "documentation maintainer" in the longer
> run, and it would be great if your tree becomes it.  I can start pulling
> from you, forwarding any documentation patches your way.
> 
> Thanks.

Uhm, ohm. Let's see how the quotation and dash thing goes first... I
don't want to make promises I can't keep (time-wise).

Michael
