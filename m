From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Thu, 18 Feb 2016 11:13:45 -0800
Message-ID: <xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
	<CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWU1Q-0007Y1-U7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 20:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946258AbcBRTNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 14:13:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945995AbcBRTNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 14:13:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12B0245E03;
	Thu, 18 Feb 2016 14:13:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+duIvQq1+rt5JREDg0n+X2J67B0=; b=xGhobp
	EgcCZ2H6p0LVBvHOVxQSSnQUecy2/u5l6YGaTC19diMm5g7dBdfWAQXLUZ+vAs9e
	fL5n3dl2RFIe58SYD0SYamKS798Qh82BiTEJX9Jf+ghBNJgMQQtxKTgUnITVVUYV
	MFwJWTDeNaCaiMp6lrzGa5ifL/leVWEoXHmBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QdqhUstLmyFrYau95UZQjj5+0lbncjNR
	xDVinGT/WKO8AFS6ZjAOVIpVtpi8EaBISq7UP3qKfioxxSV2IOcbP/CGgAUlvui8
	ZHbwon5gvy9wjuYK2QcAGrI2Dtze6I0MIEYV2HujSLt59WzOs11L9acUbNXn2KLm
	y7nY3o/IV8A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 077A845E02;
	Thu, 18 Feb 2016 14:13:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E98745DFF;
	Thu, 18 Feb 2016 14:13:46 -0500 (EST)
In-Reply-To: <CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 18 Feb 2016 10:38:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BBC85BC6-D673-11E5-AFD5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286614>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 18, 2016 at 12:41 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>> Feel free to start writting an idea for
>>> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
>>> ideas before Friday. We can polish them later if needed.
>>
>> I published my ideas here:
>> https://github.com/git/git.github.io/pull/125/files
>
> I like the idea of a beginner mode, but on the other hand that looks
> inflexible to me ;)
> (What if I want to use rebase, but not reset --hard?)

That's simple.  You say "cd .. && rm -fr repo && git clone" and
start from scratch ;-).

This whole "beginner should be limited to a 'safe' subset" is an
unhealthy attitude.

Deciding what the 'safe' subset is must be done with a lot of
thinking by people who intimately know what implications it has to
ban each feature.  I do not think it would be a good fit for a
project to give to a relatively new participant to the Git project.

For example, I think banning "worktree" feature from newbies may not
be a bad idea, as you can work on a project without using "worktree"
at all, and use of "worktree" would only subject you to bugs that do
not exist when you do not use that feature.  The "shallow clone",
"sparse checkout", and "untracked cache" fall into the same category
for exactly the same reason.  The "submodule" feature might fall
into the same category for the same reason, but that is not
something you as a project participant can unilaterally decide, as
the project you are working on may have already decided to use the
feature, so it is harder to ban from the beginners.

But for the rest of really "core" part of Git, I do not think there
is any such command that can be totally banned.

We have these "powerful" tools for a reason.  After making a mess
experimenting with your working tree files, "reset --hard" is the
best tool to go back to the known-good state, and robbing it from
the users is not a sound approach to help them.  When "powerful"
becomes "too powerful" is when a "powerful" tool is misused.  It is
perhaps done by mistake or perhaps done by copying and pasting a
solution from Interweb for a problem that does not match your
situation without understanding what you are doing.

What is needed to help beginners is to make the powerful tool harder
to misuse.  Of course, that would be a harder task, because you have
to do a real thinking.

You do not have to do any thinking to say that "a blanket ban that
hides these powerful tools behind the beginner mode" helps
beginners, but I do not think it is solving what really matters.  At
the same time, it just adds to the FUD, i.e. some commands are too
powerful for their own good.
