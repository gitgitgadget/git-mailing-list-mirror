From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Sat, 26 Apr 2014 20:28:05 +0200
Message-ID: <87zjj86j4a.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 20:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We7LN-0001jU-Bo
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 20:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaDZS2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 14:28:09 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:48007 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaDZS2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 14:28:07 -0400
Received: from localhost ([127.0.0.1]:47049 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1We7KX-0006mS-Mr; Sat, 26 Apr 2014 14:28:06 -0400
Received: by lola (Postfix, from userid 1000)
	id 52CF4E060B; Sat, 26 Apr 2014 20:28:05 +0200 (CEST)
In-Reply-To: <7vmwf8huey.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 26 Apr 2014 10:28:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247175>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Includes reasonably tasteful begging.
>
> Thanks, but no thanks---I do not see it tasteful.

Well, begging rarely is.  The point simply is that without commensurate
recompensation, I cannot afford any more work of that kind on Git, and
there is a reasonable likelihood that such work is worth more to some
subset of Git users than what it would take to enable me doing it.

My experience with "tasteful" asking for contributions in the context o=
f
AUCTeX and preview-latex development is about =A4100 plus two cases of
beer in 10 years.

With GNU LilyPond, I've been way more blunt.  Its community certainly i=
s
dwarved by the Git community, and still they've been able to support my
work with more than =A41000 per month for several years now.  I've been
letting those people down for several months now because of the
git-blame stuff, with a respective decline in support to show for that.
Sure, partly because of misestimates of the involved work and the
involved self-motivation to get it over with.

If that's not worth anything to the Git community, I can just chalk it
off as a somewhat expensive one-time experience and that's it.  I=A0can
live with that.

What I want to avoid, however, is the situation where this kind of work
would actually _have_ been worth enough to enough people to enable it
but they don't get to make a decision whether to support more of it
and/or express their appreciation in the manner that actually counts,
because of being blissfully unaware.

Now of course, people having an independent and/or guaranteed can affor=
d
to be tasteful.  And there are probably enough of those around for
running the show.

But then "git blame" performance has been sub-par for a very long time
already.

> In any case, any large change that is not a regression fix (or a fix
> to a code added since 1.9 series) is way too late for 2.0 at this
> point,

=46or what it's worth, the user interface is unchanged.  And results
should be the same as previously apart from the runtime requirements.
Naturally, this is "should", and problems, particularly regarding
different output, may take a long time until somebody notices since few
people will actually compare the old and new results.

> but I do look forward to reading the patch over, queuing to my tree,
> cooking in 'next' and eventually having this in 2.1 or later.
>
> If you want help in a fundraising campaign, I can lend my name
> (especially after this change settles and proves to be useful ;-),

In my book, it is a large usability improvement but not necessarily a
game changer.  Waiting for 1 minute rather than 3 minutes is still
nothing one wants enabled in a web server, or that turns stuff into the
"interactive response" ballpark.

To get that, one will have to work on the remaining performance which i=
s
primarily the responsibility of the object store and associated caching=
=2E
The advantage is that its impact on the performance is now readily
visible: previous to this patch it is strongly masked by the sub-par
performance of the git-blame code itself.

> but let's do that elsewhere.

If you have a reasonable idea for that.  It would be pointless wherever
it safely becomes "somebody else's problem" for pretty much everybody.
I'm not overly happy with trying to recruit active developers/power
users for that kind of thing when they are

a) actively investing time and effort themselves
b) outnumbered by profiting users 1000:1

but I've not yet found a better approach myself with regard to LilyPond=
=2E
If you have a better idea for Git...

> I do not want to do this in the release notes (e.g., an entry in
> git-blame blog can mention it when it touches the blame improvements)=
=2E

Again: it's important to be visible to those people who might care abou=
t
putting money in, or it's pointless.

At any rate, I'm glad that the work is closed for now.

--=20
David Kastrup
