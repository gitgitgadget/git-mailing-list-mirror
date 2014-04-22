From: David Kastrup <dak@gnu.org>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 00:24:32 +0200
Message-ID: <87y4yxc89r.fsf@fencepost.gnu.org>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<20140422213039.GB21043@thunk.org>
	<5356e62feb9f3_6cbadd72f0f1@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:25:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcj7i-0001vO-Be
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbaDVWY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:24:59 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:51588 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaDVWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:24:58 -0400
Received: from localhost ([127.0.0.1]:50627 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wcj7Z-0004Ai-Da; Tue, 22 Apr 2014 18:24:57 -0400
Received: by lola (Postfix, from userid 1000)
	id A4535E0524; Wed, 23 Apr 2014 00:24:32 +0200 (CEST)
In-Reply-To: <5356e62feb9f3_6cbadd72f0f1@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 22 Apr 2014 16:59:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246796>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Theodore Ts'o wrote:
>
>> This is especially true for commands which might not be used as often
>> -- e.g., "rebase", and for commands where the meaning of "git commit"
>> without any argument is qualitatively different from what "ci" (for
>> checkin) means in most other source management systems.
>
> ci means commit in Mercurial.

Does it mean "commit the staging area"?

>> In fact, to be fair, you may be getting biased because you're used to
>> using the two character shortcuts, so for you, of *course* "rb" and
>> "pi" and "ci" make a lot of sense.
>
> I can't be biased to those because I don't use them, mine are one
> character shortcuts.

Which you created yourself, on your own responsibility.

> And if that hypothesis was correct, why does Mercurial, Bazaar,
> Subversion, CVS, and pretty much everything uses aliases? And why does
> pretty much every .gitconfig has similar aliases? That would imply
> that the whole world is biased.

Most .profile files define aliases as well.  Doing this on the user's
initiative is harmless since it will not have its usage leak into
scripts intended for use by others.

> It would help when the user starts to think "Geez, I seem to be typing
> `git checkout` an awful lot, I wonder if there's a shortcut", which if
> the .gitconfigs out there are any indication, it happens all the time.

Actually, it happens very rarely if you are talking about _real_
gitconfigs deployed by projects as compared to _sample_ gitconfigs
demonstrating Git features for _personal_ rather than project-wide use.

>> And for a command like "rebase" where the user can very easily shoot
>> themselves in the foot to begin with, I'd actually suggest that it's
>> a _good_ thing that they have to type it out in full.
>
> And now you contradict yourself; you actually want to make life harder
> for new users, on purpose.

Life's hardness is not proportional to the number of typed characters or
APL would be the easiest programming language narrowly followed by Perl.
Life does not become easier by lowering input redundancy until it
becomes hard to tell apart from line noise.  Keyboards are highly
efficient input devices, or we would not be conversing in whole
sentences in technical mailing lists but rather in telegraphy style.

-- 
David Kastrup
