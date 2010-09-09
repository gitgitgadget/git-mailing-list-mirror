From: der Mouse <mouse@Rodents-Montreal.ORG>
Subject: Re: Errors in man git
Date: Wed, 8 Sep 2010 20:48:31 -0400 (EDT)
Message-ID: <201009090048.UAA08864@Sparkle.Rodents-Montreal.ORG>
References: <BLU0-SMTP666507C6D3E37A50B92431BB720@phx.gbl>
	<20100908233140.7d5df3ee@jk.gs>
	<201009082209.SAA08134@Sparkle.Rodents-Montreal.ORG>
	<20100909001411.067f29f8@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 02:48:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtVJi-00012V-DG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 02:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab0IIAsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 20:48:37 -0400
Received: from Sparkle.Rodents-Montreal.ORG ([216.46.5.7]:56943 "EHLO
	Sparkle.Rodents-Montreal.ORG" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753915Ab0IIAsg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 20:48:36 -0400
Received: (from mouse@localhost)
	by Sparkle.Rodents-Montreal.ORG (8.8.8/8.8.8) id UAA08864;
	Wed, 8 Sep 2010 20:48:31 -0400 (EDT)
X-Erik-Conspiracy: There is no Conspiracy - and if there were I wouldn't be part of it anyway.
X-Message-Flag: Microsoft: the company who gave us the botnet zombies.
X-Composition-Start-Date: Wed, 8 Sep 2010 18:46:31 -0400 (EDT)
In-Reply-To: <20100909001411.067f29f8@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155827>

>> That's always bothered me; I'd prefer to something more like

>>         git add (see git-add(1))

> To what end?

In a word, accuracy.  To refer to foo(1) without further annotation
implies the existence of both the manpage and the command.  Violating
that expectation grates and annoys even after it's clear what is really
going on.

> I have never seen anyone who got genuinely confused by the way it
> currently reads, and I've been hanging out on #git for over two years
> now.

I was.  Briefly.  Initially.  The colleague who introduced me to git
cleared up the confusion, of course, and it hasn't confused me more
than momentarily since - but it still grates every time I see it.  Not
in a truly confusing sense, but more in an "oh yes, this is a
git-related manpage, I have to remember to mentally correct for their
misnamed manpages" special-case sort of sense.  Knowing how to correct
for it, even (I think) understanding why it was done, those do not make
it any less expensive to maintain special-case interpretations.

> Also, please address your concerns to the department of redundancy
> department. ;)

Redundancy is not an inherently bad thing.  Writing manpages in English
(or any other natural language, for that matter) at all introduces
tremendous redundancy.  Shannon estimated the information content of
normal connected English at about one bit per letter; even if this is
low by a factor of two (and manpages probably have less redundancy than
Shannon's sample), it means manpages are still 3/4 redundant even if
you look at only the content, never mind the formatting.

Redundancy greatly improves communication between people; that's why
all natural langauges have a great deal of it - and manpages are just a
specialized form of such communication.  Especially when dealing with
things like computer interfaces, where precision is essential, I am
entirely willing to tolerate additional redundancy for the sake of
greater precision.

Of course, it's not my decision to make.  And I don't know to what
extent the arguments you cite are the real reasons for keeping the
style you have.  But I don't think these arguments really hold all
that much weight.

/~\ The ASCII				  Mouse
\ / Ribbon Campaign
 X  Against HTML		mouse@rodents-montreal.org
/ \ Email!	     7D C8 61 52 5D E7 2D 39  4E F1 31 3E E8 B3 27 4B
