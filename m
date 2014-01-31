From: David Kastrup <dak@gnu.org>
Subject: Re: A few contributor's questions
Date: Fri, 31 Jan 2014 22:06:16 +0100
Message-ID: <87iosz3lpz.fsf@fencepost.gnu.org>
References: <8738k44808.fsf@fencepost.gnu.org>
	<20140131161924.GA4332@google.com> <87mwic2ijo.fsf@fencepost.gnu.org>
	<20140131184842.GA30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 22:07:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9LIp-00023H-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 22:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbaAaVHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jan 2014 16:07:01 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:52112 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaAaVHA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 16:07:00 -0500
Received: from localhost ([127.0.0.1]:51154 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W9LIh-0007tW-SO; Fri, 31 Jan 2014 16:07:00 -0500
Received: by lola (Postfix, from userid 1000)
	id 1C877E0521; Fri, 31 Jan 2014 22:06:16 +0100 (CET)
In-Reply-To: <20140131184842.GA30398@google.com> (Jonathan Nieder's message of
	"Fri, 31 Jan 2014 10:48:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241320>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I assume the problem you're trying to solve is that files don't have
> clear enough notices of their licensing.

No, just the file that I'm contributing to.  It has a single copyright
attribution that arguably is already less than accurate _unless_ the
respective authors can be considered to have been acting with the inten=
t
of letting Junio do whatever he wants to do with their contribution.

> That could be a real problem for people using the code, since if you
> no one gave you a license then you don't have a license at all.

In that case, it is reasonably to revert to the general license.

> It's also a problem in that it makes it harder to interpret the phras=
e
> "under the same open source license" (though I have no idea how that
> could be read as "I give up my copyright completely").

If the existing notice is "(c) Junio Hamano" that means that Junio is
fully able to license at his will.  And in the case of his work on Git,
this includes his expressive permission to relicense under the
conditions of libgit2, including a no-modification binary-only licensin=
g
option.

So my problem is not as much that people might get the idea they might
not use/copy my work at all (which would be silly), but rather that the=
y
have reasonable expectation to use it under the licensing scheme of
libgit2 without getting back to me.

>  * the code is copyright by the authors and we try not to waste fuss
>    on maintaining a comprehensive list in notices.

That's fine, but we are talking not about a list but a single named
copyright holder.  I was proposing adding "and others" to clarify that
the list is not exhaustive.

>  * relicensing, when needed, happens by contacting all the copyright
>    holders and getting their consent
>
> I don't see anything weird about that.

Neither do I.

> But people using the code might like clearer notices, so I personally
> would not mind an extra line in most files stating the license.

I was more concerned about amending the copyright attribution, though a
single line pointing out GPLv2 and referring the reader to the general
COPYING file does not seem excessive, either.

>> It's verbose and cumbersome enough that I would not have been
>> surprised if there'd be an established way of getting this
>> information on record, preferably per-project rather than per-commit=
=2E
>
> For relicensing the existing practice is to just contact people.

Well, that stops working once they are dead.  And it's probably rather
tricky to locate their heirs even in case they have placed instructions
concerning their copyrights into their last will.  While I=A0am not in =
a
rush here, I=A0am still likely to turn decomposing into a fulltime
occupation earlier than most other contributors: I=A0started working wi=
th
computers at a time when the single most imminent danger to long-term
data archival were mice.

> That has the advantage that I can make a decision about whether to
> allow relicensing code I've written in the context of how I expect it
> to be used.  I expect that if you had a stance on GPLv2+ licensing of
> contributions to git published in some place easily found by search
> engines (for example a message on the mailing list), interested peopl=
e
> would not have too much trouble finding it when the time comes.

Maybe, maybe not.  There is a big hole in the indexing of the Google
News history that was taken over from what once was Dejanews.  Putting
the information regarding prospective licensing close to the actual
source seems like a smart move.

At any rate, if there is no stock procedure for that, that's it.

--=20
David Kastrup
