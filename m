From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 21:03:50 +0100
Message-ID: <878v6lwfrt.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
	<20130218185801.GA25673@sigill.intra.peff.net>
	<CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Wwk-0003ZU-PO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab3BRUDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:03:54 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:21736 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170Ab3BRUDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:03:53 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 21:03:48 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 21:03:50 +0100
In-Reply-To: <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 01:15:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216511>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

[...]
>>> On a related note, I don't like our Wiki.  It's down half the time,
>>> and it's very badly maintained.  I want to write content for our Wiki
>>> from the comfort of my editor, with version control aiding me.  And I
>>> can't stand archaic WikiText.
>>
>> Agreed on all of those points. Putting the Wiki on GitHub fixes that.
>> But it means contributors need to have a GitHub account. On the other
>> hand, I think kernel.org wiki contributors need an account these days?
>> And GitHub is putting some active effort into finding and killing spammy
>> accounts, which might keep wiki spam down (I do not pay too much
>> attention to those efforts, but on kernel.org, it is mostly up to the
>> Git community to do it ourselves).
>
> No, I'm against using the GitHub Wiki for neutrality reasons.  There
> is one easy way to fight spam: don't expose a web-based editing
> interface at all.  It's mainly going to be maintained by the
> community, and we're all much more comfortable in our editors and git.
>  We can give the regulars direct commit access and ask the rest to
> submit pull requests.  Make it cost pennies, so any of us can easily
> afford it: just a cheap domain, DNS, and static HTML hosting.

I suppose since github's wiki system (gollum) is open source [1] it
wouldn't be too hard to set up another instance somewhere.  Bonus points
for importing all the old data in mediawiki format first, which is also
apparently supported.

But that just shifts the point of failure from the entire github team to
one or two people who end up administering the server.

Perhaps a better solution would be to ask Scott or Peff to create a
gollum instance under git-scm.com, which they're already hosting?  (It
seems people got over *that* neutrality issue quickly enough.)  Push
rights could be given to interested regulars.  It would then at least be
independent in name.


Footnotes: 
[1]  https://github.com/github/gollum

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
