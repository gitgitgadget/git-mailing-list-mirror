From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 18:40:41 +0100
Message-ID: <874n4xqlly.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 18:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5fJp-0006zF-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 18:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbaAURky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 12:40:54 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:41369 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbaAURkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 12:40:53 -0500
Received: from localhost ([127.0.0.1]:40411 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5fJk-00053c-Lo; Tue, 21 Jan 2014 12:40:52 -0500
Received: by lola (Postfix, from userid 1000)
	id E5F12E051D; Tue, 21 Jan 2014 18:40:41 +0100 (CET)
In-Reply-To: <20140121165546.GE18964@google.com> (Jonathan Nieder's message of
	"Tue, 21 Jan 2014 08:55:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240758>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>
>> Now I might have sent at an unopportune time: blame.c is mostly
>> attributed to Junio who seems to have been a few days absent now.
>>
>> I also have seen quite a few mails and patch submissions on the list go
>> basically unanswered in the last few days.
>
> In the U.S., yesterday was a federal holiday (Martin Luther King, Jr.
> day) and the two days before were the weekend.

I see.

>> Now the file involved (builtin/blame.c) itself does not state _any_
>> license.
>
> Most of git is GPLv2-only.

Does that include builtin/blame.c?

> Yeah, since these patches aren't adding a large new chunk of code

Well, _significant_ chunks of code are in the works already (and my
question was really more about them).

> there's no need for a new copyright notice and so no place to put that
> kind of thing unless Junio wants to relicense blame (which would be
> orthogonal to these patches).

So my understanding is that when we are talking about _significant_
additions to builtin/blame.c (the current patches don't qualify as such
really) that

a) builtin/blame.c is licensed under GPLv2
b) significant contributions to it will not be relicensed under
different licenses without the respective contributors' explicit
consent.

This question is not academical to me.  I don't have any source of
income apart from people paying me to write free software (mainly
LilyPond users), so if I'm writing significant pieces of code, I don't
want to see them distributed as proprietary software (for example, by
traveling through the very unrestrictively licensed libgit2) without
being in the situation of negotiating recompensation for that.

The combination of the SubmittingPatches text with the file notices in
builtin/blame.c is not really painting a full picture of the situation.

-- 
David Kastrup
