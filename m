From: David Lang <david@lang.hm>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 15:25:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com> <53557071.5040500@gmail.com> <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com> <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com> <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch> <20140422213039.GB21043@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcj8d-0002l5-3K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbaDVWZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:25:59 -0400
Received: from mail.lang.hm ([64.81.33.126]:43023 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaDVWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:25:58 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s3MMPoSJ010316;
	Tue, 22 Apr 2014 15:25:50 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20140422213039.GB21043@thunk.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246798>

On Tue, 22 Apr 2014, Theodore Ts'o wrote:

> On Tue, Apr 22, 2014 at 02:23:18PM -0500, Felipe Contreras wrote:
>>> I am not fundamentally opposed.  I just do not think it would add
>>> much value to new people at this point, and it will actively hurt
>>> if we shoved barely cooked one in 2.0.
>>
>> You are probably biased in that you've used Git far much more than
>> the average user has (or future new users).
>
> I think Junio has a really strong point.  If the goal is to make life
> easier for new users, allowing them to save a few keystrokes is
> probably not the most significant thing we can do.  And we have to
> balance this with the additional cognitive load in remembering how a
> particular two character alias maps to the "real" command.  This is
> especially true for commands which might not be used as often -- e.g.,
> "rebase", and for commands where the meaning of "git commit" without
> any argument is qualitatively different from what "ci" (for checkin)
> means in most other source management systems.
>
> So I do think it's worth thinking about this very carefully.  For
> certain, I would **not** recommend using shortcuts in example command
> sequences.  If the user reads "git rebase" or "git cherry-pick" it
> means a lot more than if they see a series of apparent chicken
> scratches filled with things like "git rb", "git pi", "git st", etc.
>
> In fact, to be fair, you may be getting biased because you're used to
> using the two character shortcuts, so for you, of *course* "rb" and
> "pi" and "ci" make a lot of sense.  But for someone who is starting
> from scratch, I really question how much it helps, and how much it
> might hurt, to see the two character shortcuts or even to have to
> remember the two character shortcuts.  And for a command like "rebase"
> where the user can very easily shoot themselves in the foot to begin
> with, I'd actually suggest that it's a _good_ thing that they have to
> type it out in full.

agreed, of all the things that people complain about regarding learning git, the 
fact that the commands are words instead of cryptic 2 letter abberviations is 
not one of them.

The complaints tend to be far more about how there are inconsistancies between 
commands, or they don't understand what's happening.

Adding a new inconsistancy, or changing words to abbreviations is a further 
barrier against new users, not an advantage for them.

David Lang
