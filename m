From: "Stephan Beyer" <s-beyer@gmx.net>
Subject: Re: 'next' will be rewound shortly
Date: Sat, 28 Jun 2008 01:41:04 +0200
Message-ID: <20080627234104.68810@gmx.net>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
 <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org>
 <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
 <20080627161220.GB6201@leksak.fem-net>
 <20080627163411.GA2058@genesis.frugalware.org>
 <20080627171948.GC6201@leksak.fem-net>
 <20080627192819.GC2058@genesis.frugalware.org>
 <7vd4m2r2iq.fsf@gitster.siamese.dyndns.org>
 <20080627213605.GD2058@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 28 01:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNZt-0007Lv-1g
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929AbYF0XlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758897AbYF0XlI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:41:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756217AbYF0XlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:41:07 -0400
Received: (qmail 5874 invoked by uid 0); 27 Jun 2008 23:41:04 -0000
Received: from 89.49.11.26 by www048.gmx.net with HTTP;
 Sat, 28 Jun 2008 01:41:04 +0200 (CEST)
In-Reply-To: <20080627213605.GD2058@genesis.frugalware.org>
X-Authenticated: #1499303
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX18VVdEer48VNeZGPww38MNv9KQ0BqkCylMViuSRnD
 9lhBRtMYaA8CFz36jd2cWXemcVOyooSyOmBA== 
X-GMX-UID: qE1QfJRdTiE+P9SBcWRwCzV9ZUVSRFcB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86680>

Hi,

> <gitster@pobox.com> wrote:
> > Following git tradition, manpage came after the command's behaviour has
> > been long established.  It will be a behaviour change, and it is open to
> > debate if the new behaviour is better or if the proposed change of
> > behaviour hurts existing users.
> 
> If my opinion counts, I like the current ("prepend") one, and I think
> the best would be to add a new option (and/or make it configurable) for
> the new ("replace") one.

Well, perhaps I am different, but I sometimes have temporary branches
named like "first-silly-experiment" and I do not expect having a
    Merge branch 'another-silly-experiment' into 'first-silly-experiment'
appended, when I do a
    git merge -m "Merge a lot of useful stuff... blabla" another-silly-experiment.

(btw, I don't *really* name my branches like this..it's just an example.)

Well, I see this from a "sequencer author point of view", where
     merge silly-experiment
will invoke an editor,
     merge --standard silly-experiment
generates some kind of the typical standard (or default) message,
and
     merge --message "Merge blabla" silly-experiment
does the "obvious". (For me this is the obvious since I've never
experienced another behavior. All my merges have been using the
now disappeared commit.)

So I'd vote for a "replace" behavior by default on -m, and an 
"append standard message" option, but if there is *one* person
who relies on the prepend feature, I'd also take the "prepend"
default and would like to vote for an option that does the
replacement.

For the current state of the art, it seems that I have to merge
with whatever message and then do a commit -m "..." --amend.

Regards,
  Stephan Beyer

PS: Currently using webmail. So sorry for any too long lines
or whatever.
-- 
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/wasistshortview.php?mc=sv_ext_mf@gmx
