From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Sun, 8 May 2016 08:54:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605080841520.4092@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com> <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
 <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com> <alpine.DEB.2.20.1605041304050.9313@virtualbox> <CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com> <alpine.DEB.2.20.1605041416030.9313@virtualbox>
 <CAP8UFD0QeZqLaPwFe5wo0n1fdtSppJmYdUDc+Yo1duH1uyWbpw@mail.gmail.com> <alpine.DEB.2.20.1605041654300.9313@virtualbox> <CAP8UFD2qoCPkbDid+k6Lydh7JTM5VhQzxTSuJuRa40sw54_aZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 08:54:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azIc8-0005QB-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 08:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbcEHGyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 02:54:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:53830 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbcEHGys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 02:54:48 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MbxJ8-1bFBKw1hqA-00JLEG; Sun, 08 May 2016 08:54:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD2qoCPkbDid+k6Lydh7JTM5VhQzxTSuJuRa40sw54_aZw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UZnTNhMcLE7wpYw9oiXPHdgjBSdFD1Kh70ZsSs49i0zMLhXmTiq
 xyfKchhU1a+CRS3jMHpUEwlI9YlfuzusSOX3z4zVVhAZi09uOhUquPbBmR5ztFSIq0ECBqU
 eiOlXXMXO2EV771CrUeyZQV7iPsRUUl/otCzotKb5nEx0vd+njPa98u/h/d4uWEt4yeVJII
 x2efg5tnGqIIxyKWwRjDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3EH+u9agVnI=:C5pLgAoR50/0T0rjBzGZAv
 S6UkwaVtuQEBYeCo+RQvnZw6ifKrn26CS9HQTJkS+SqlhP5XOAeQ4Sy4LqDy9CCB/tikVEzem
 ntjhlrJnOQKDpwmYWqvslGMILfqxR5+3t92d5Ho7MJgNFPkjfmYXXrcl06OCQlV0O2iXSHvSB
 bkbCJw893UBWf+pQ3tLnW0lRI/D+9pAVM74xsewpK7j5I6T2tXH1mX2UXXhf2yIwFBKNHtV+u
 bdIzQd8ZVv0NEpXeyYjh3UBlveA59aG1JBIopM3GP/WkrRBnKTx2Vi4IcWjgawAbVKmACeYyC
 CXa31EyMZqmep1b5KXqpWtR9O8UZirm/V5bCxGuS9EHOYUg8WkgyFpgolt/pPKauHE9Ic12gP
 z25Krj/h5mrkgQWDV/3Z00rFQo3PhO/Rue96rVa0gtkeLCHR7tiL59eNV1VmDDhnH+T0WO/jn
 5k2XugDVqzngKA2Us9tFzJS4vs/y0jg6jgEA7h+jWElm1G8dqYAqwnpVXPox4qaRzSVVoDh1B
 P0slTi2XY0zsI6J4A83CO6iu4Hz51LTeAEvnPdmhti/h6uzDQbz0Oe3+kidPpoxwx/JmHNJh9
 lnp1s1DXr9cLcbz7tY1LcUZgeFjWdG3GdeHwW/xWMiB91DHt66eJXKqjRZRCXDLRlLk5/WzUE
 65lAetqQ1TxH0IW4NNyseES6E9Fi6sWDQICOtXfTKXxVZ3g7boU3Mf/6ELu2q4N6qo/rmQ5L0
 tzpD2Eaeny4SexiRgjg+DrKhyUb8NnqKDy8y+qJSwFJtyV5aTpaeaDHdYCYHYlfwMqs8BMsJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293912>

Hi Chris,

On Wed, 4 May 2016, Christian Couder wrote:

> On Wed, May 4, 2016 at 4:56 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 4 May 2016, Christian Couder wrote:
> >
> >> My intent was to try to show that there is some important value to make
> >> the subject close to the "low level" thing the patch actually does.
> >
> > I disagree. The place to describe low-level details that are not
> > immediately obvious from the patch is the commit message. Way, way down on
> > the bottom.
> >
> > The commit message should start with a subject that gives me a good clue
> > why this is a good change. A low-level detail won't do that very often.
> 
> Let me give you another example.
> 
> You want to do X and you discover that you need to tweek knob foo to
> do X, and also that tweeking knob foo is a good thing to do in general
> (for example it could be a refactoring that save some lines of code).
> So you create a patch that tweeks knob foo and call it "prepare to do
> X", and then send it so that it can be merged. Then you want to do X
> but you are interupted by an event, for example you boss tells you to
> do Y instead of X right away because of an urgent business need. So
> you do Y instead of X. And then sometimes later (it could be weeks,
> months or years later), when you are finished with Y, you now want to
> go back to your previous work on X. At that time you discover that you
> need to tweek knob bar (it could be another refactoring of another
> part of the code), but you forgot about your previous patch that
> tweeked knob foo, so you call your new patch that tweeks knob bar
> "prepare to do X". As your previous patch that was also called
> "prepare to do X" has already been integrated, you now have too
> patches that do different things that are called the same, and you can
> easily mistake the first one for the second one.
> 
> If you had just called your first patch "tweek knob foo" and the
> second patch "tweek knob bar", it would be much clearer which patch
> does what.

And then, six months later, when *you* are stuck in a plane and bisect a
problem down to my "tweak knob foo", you curse at me, asking fellow
passengers "what was Dscho thinking? 'foo'? What the hell is 'foo'
supposed to mean? And what was the *intention* of this patch? There is a
bug! And now I cannot fix it properly because I do not understand what the
patch was intended to do!".

Do not believe even one second this scenario s foreign to *me*. Even with
some of git.git's commits whose messages were so in love with low-level
details, essentially repeating what the diff already told me, that they
forgot to include the context, the big picture, leaving me puzzled and
frustrated.

And my fellow passengers, too.

This puzzlement and frustration is unnecessary. I typically follow Peff's
examples. They typically do a good job of telling me right away what the
big picture is, even if they are in the middle of a patch series, not
worrying too much whether adjacent commits say related things, without
forgetting low-level details. The crucial point is that they start out by
assuming little familiarity of the reader with the context.

In short: you can have both. The commit message *can* be informative, and
*still* contain low-level details. You simply start with the former and
ease the reader into the latter, instead of skipping the first part, is
all.

Ciao,
Johannes
