From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 12:35:14 -0800
Message-ID: <xmqq8u2gcubh.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
	<CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
	<xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
	<vpqr3g96tn6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 21:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWrlt-0007YA-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946791AbcBSUfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 15:35:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422898AbcBSUfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 15:35:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BD7644814;
	Fri, 19 Feb 2016 15:35:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dPGWERnF3hxYfi4ulXx96uI2us4=; b=drj89o
	HAHIJIHtJFan8Qv4mhVKkstct0z8f4afwvK2f5gNzZ73OjLthWcdGVHgP5734Pk2
	fp4huV5uAFgPnIUWM2ui44zpymon+JYrSPum8bqxhghNiVw4BqvkWyy5tPwKvK9n
	MZInxdxteyEb72B6hrY5Vi/EMdcZ2Wxq8x1cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImaTeLA6ZBUaANQikHkzVnMPsv1rHnim
	iBCheFpNE2RnifLwCF86Tlw56gp/v+0Q/fJUlrFm99+cUDt/96e1JRNP+vfo7LDH
	ehPD6CE3Bqkw+CdDctWL3NCdRB8b6Xwp6G7o1LRFyxFnFu99NIJI0dnM4BS2P3Tp
	IuaZdeyP6+4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80C0E44813;
	Fri, 19 Feb 2016 15:35:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EEEDB44812;
	Fri, 19 Feb 2016 15:35:15 -0500 (EST)
In-Reply-To: <vpqr3g96tn6.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	19 Feb 2016 08:34:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 489E2D9E-D748-11E5-8138-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286748>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> We have these "powerful" tools for a reason.  After making a mess
>> experimenting with your working tree files, "reset --hard" is the
>> best tool to go back to the known-good state,
>
> I disagree with that. This reminds me a discussion I had with a student
> a few years ago:
>
>   student: how do a clear all changes from my worktree?
>   me: git reset --hard
>
> the next day:
>
>   student: OK, now, how do I get my changes back?
>   me: ...!
>
> There's almost no situation where reset --hard is the best tool.

I obviously have to disagree.  After maknig a mess experimenting,
when you want to discard all that, "reset --hard" is the best
tool--the situation of your student may be quite different but you
didn't make it clear what s/he wanted to salvage.  In any case, I
wasn't asking about "clear all changes for now, to be salvaged
later".

The "experimenting" would include mergy operations like "am -3" and
"cherry-pick".  "After queuing a topic and trying it in isolation,
an attempt to merge to the baseline results in quite a mess, and I
give up"--there is nothing to salvage.

And obviously, "stash" is not useful in such a situation.  You could
use "tar cf ../saved .", though.

> Now, another issue with the proposed core.isbeginner is compatibility
> with scripts. 

Yes.

> Dangerous commands are often plumbing, and a beginner may
> still want to use scripts or other porcelain on top of it. Typically, I
> think this rules out "git reset --hard" which is legitimate in scripts.

I agree that an "under core.isbeginner, the command will always be
refused" change can be written without thinking and it will be
useless for anything that has ledigimate uses (like, but not limited
to, being used in scripts) [*1*].

But not so fast.

If you can figure out when "git reset --hard" is legitimate based
*NOT* only on the fact that it is driven by a script, but on what
kind of modifications to the working tree contents, the index
contents and the refs are about to be made by the command, then
"core.isbeginner" can be a permission for the command to spend extra
cycles to examine the situation carefully to decide to selectively
go ahead, warn and go ahead, or refuse.

That of course takes a real thinking.  


[Footnote]

*1* I'd refuse to take a patch to make scripted Porcelains that make
legit calls to "powerful" tools export GIT_SCRIPT_IS_RUNNING_YOU
environment variable as a workaround for such a kludge.
