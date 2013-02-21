From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Thu, 21 Feb 2013 16:41:40 +0100
Message-ID: <877gm1brnv.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 16:42:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8YHj-0006dF-UR
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 16:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3BUPlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 10:41:44 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:13331 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab3BUPlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 10:41:42 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Feb
 2013 16:41:36 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 21 Feb 2013 16:41:40 +0100
In-Reply-To: <CAJo=hJvknVedGba5OxjjvZi2=JZyDuDoP2tD+LKQKdZNJ4NcsA@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 19 Feb 2013 22:50:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216777>

Shawn Pearce <spearce@spearce.org> writes:

> On Mon, Feb 18, 2013 at 9:42 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 18, 2013 at 06:23:01PM +0100, Thomas Rast wrote:
>>
>>> * We need an org admin.  AFAIK this was done by Peff and Shawn in
>>>   tandem last year.  Would you do it again?
>>
>> I will do it again, if people feel strongly about Git being a part of
>> it. However, I have gotten a little soured on the GSoC experience. Not
>> because of anything Google has done; it's a good idea, and I think they
>> do a fine of administering the program. But I have noticed that the work
>> that comes out of GSoC the last few years has quite often not been
>> merged, or not made a big impact in the codebase, and nor have the
>> participants necessarily stuck around.
>
> This.
>
> I actually think Git should take a year off from GSoC and not
> participate. Consequently I will not be volunteering as backup org
> admin.

Fair enough.  But I think if that's the decision (and modulo libgit2
praise, it seems to be pretty much the consensus?), we should probably
have some Idea why we are doing it?

You wrote:

> Git has been involved since 2007. In all of that time we have had very
> few student projects merge successfully into their upstream project
> (e.g. git.git, JGit or libgit2) before the end of GSoC. Even fewer
> students have stuck around and remained active contributors. When I
> look at the amount of effort we contributors put into GSoC, I think we
> are misusing our limited time and resources. The intention of the GSoC
> program is to grow new open source developers, and increase our
> community of contributors. Somehow I think Git is falling well short
> of its potential here. This is especially true if you compare Git's
> GSoC program to some other equally long-running GSoC programs.

If that's the outset (and it's certainly true for a lot of the
projects), aren't the options (not limited to just one):

* We have some discussion about why we fail, what to do better, etc. and
  hopefully also manage to clean up some old projects and get them
  included.  That way we can learn something from it.

* We try to look at how more successful communities are doing it
  (e.g. there were some posts about how KDE bumped their student
  retention rate).

* We try to "mentor" some projects that aren't GSoC sponsered.  That way
  we can hope to gain mentoring experience.

I'm not very optimistic about any of these, as:

- There weren't any in-depth discussions post-GSoC to analyze what went
  wrong.

- Contributor time is so limited that we're usually short on reviews.
  Adding "mentoring for the sake of trying it" to duties isn't very
  promising.

Thus I'm a bit afraid that after a year off, we won't have learned
anything new.  To the contrary, some previous mentors/students will
inevitably have disappeared into the mists of time, and with them their
experience.  Unless we do something about it, next year we'll be in an
_even worse_ position than this year.

I'm mildly pessimistic about "doing something" over the list, but
perhaps we can have an extended discussion at git-merge provided enough
of you show up there?  I can try to prepare some material.


(Maybe we should all make a bunch of clones of ourselves.  We can put
one copy each into a room so they can figure out GSoC, and have another
group doing our favorite git hacking while we're at it.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
