From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 11:29:57 +1000
Message-ID: <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 03:30:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wewrz-0007yk-4i
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 03:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbaD2B37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 21:29:59 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:62441 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaD2B36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 21:29:58 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so8852403veb.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 18:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u2k8RAXjEV5wFqdOvzmPDyWC+Lyd7Pq7NFJKWnB3igE=;
        b=wOSM2j2r9cDHbP76baPUNdb30ubDjJUlWXpwxdGznOXqW3d8x2nxyhzUmKQdaw9LVk
         cEap85lzEAIc0DclN/SCHnmwQbhCdeJiPqYhAYNo3ey1DWA53AgZG/zY0N/VKlGuUYhR
         zu9Cw1JAVrhxuimTylzoQOK6sC8SOnA3+2ObmhzTX5Hh+WhIG5PjRjwfFHjXz9vvajBo
         vfjkpm6fPs9m82zEWaA6lHpdjy2Oyt6EjzUDgljEr1azZE+Q64DGjzVXz9o+hxGYA/Ed
         AY/bJi8j8omEctriE6bExiNpgSKdVkTZjT90VmBRiw3MvpqPVuoHyptSecERfq8phzol
         HpQA==
X-Received: by 10.58.230.103 with SMTP id sx7mr4665459vec.28.1398734997799;
 Mon, 28 Apr 2014 18:29:57 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Mon, 28 Apr 2014 18:29:57 -0700 (PDT)
In-Reply-To: <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247506>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> James Denholm wrote:
>> It's not anybody else's job to take your patches and drizzle them in the
>> honey of respectable discourse.
>
> It's nobody's job to do anything. This a collaborative effort and in a
> collaborative effort everbody chimes in to do different things.

No, true, but my point was more related to that it's ones own "task",
perhaps being the better term than job, to debate the merits of one's
own work when the merits are currently unknown to the rest of a
community.

> It's not Jeff's patches, they are our patches, they are part of the project.
> And it's not unusual for multiple people working on a patch series; oneperson
> doing most of the work, another adding tests, another cleaning updocumentation.
> It's also no unheard of from a person picking up a patch series somebody else
> stopped working on.

This, of course, would be the _other_ case where a proposal's
merits are already known and accepted by the community. Different
situation.

Note that I here specify a proposal's merits are known and accepted,
rather than the issue at hand. I'd be very, very surprised if there was
even a few cases in human history where a community was able to
collaboratively work, efficiently and successfully, on a proposal where
the merits were still hotly discussed (barring, of course, exploratory
works).

> If a patch series is event considered to be merged upstream, that means it
> doesn't just benefit the person sending it (e.g. me), it benefits all Git
> users.
>
> So "my" patches where by the project and for the project.

And yes, of course, but you misinterpret my use of "one's patches" to
describe ownership or who benefits from those patches. I merely
discuss authorship and seek not to imply anything more.

>> > The fact of the matter is that the tone doesn't matter, the patches don't
>> > get in because change is not welcome. Period.
>>
>> You neglect the possibility that your personal view of what git should
>> be differs from other people's.
>
> Except that in this case virtually everyone agreed the default was wrong. I
> already said that.
>
> Clarly you didn't read the relevant discussions where everyone, including Linus
> Torvalds, agreed. Did you?

I'm talking about the general case, not a _specific_ patch or set
thereof authored by you or any one person.

Again, though, recall that even if a community has agreed that
the current state is non-ideal, that doesn't mean that they agree
that a _specific proposal_ is the right one. If A and B agree that
they are starving to death, and B proposes they engage in hunting
to resolve this, A might disagree because he'd rather just go
across the street and buy a loaf of bread.

Although as I write this it seems Junio has described this exact
thing in a following mail, and on the following debate:

A patch relates to more than a personal view of what a project
shouldn't be. Even if it's solving an acknowledged problem, it
by it's nature relates to a view of what the solution should be.

Ergo, in the specific case, your view of what the solution should
have been did not match the community's view of the same, even
if the overall problem was acknowledged by the entire community.

The default may be wrong, you and I might agree that the default is
wrong, Junio and Torvalds and RMS and The Queen of England
might all agree that the default is wrong... But if we all live across
from a bread shop, it's going to be a difficult task for you to convince
us to go hunting.

Sincerely and analogically yours,
James Denholm.
