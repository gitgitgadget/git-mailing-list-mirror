From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 12:17:15 +0100
Message-ID: <804oqn5nes.fsf@tiny.isode.net>
References: <h9nlhj$heq$1@ger.gmane.org>
            <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
            <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
            <94a0d4530909280401q4a451697re8954320682662f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 13:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsEES-0002wY-7Q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 13:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZI1LRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 07:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbZI1LRS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 07:17:18 -0400
Received: from rufus.isode.com ([62.3.217.251]:39960 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbZI1LRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 07:17:18 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SsCbOwB9YRq0@rufus.isode.com>; Mon, 28 Sep 2009 12:17:15 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 28 Sep 2009 12:17:15 +0100
X-Hashcash: 1:20:090928:felipe.contreras@gmail.com::dZ4w/dZMkMiVHzmU:000000000000000000000000000000000001wYW
X-Hashcash: 1:20:090928:newsgroups@catchall.shelter13.net::kZiKLE5y3oSxaiOM:000000000000000000000000000032rZ
X-Hashcash: 1:20:090928:johannes.schindelin@gmx.de::CUR1LiqBwmXnDSjx:000000000000000000000000000000000004GuK
X-Hashcash: 1:20:090928:git@vger.kernel.org::Q1+w2TLLO5eRUytj:0000000000000000000000000000000000000000005vq+
In-Reply-To: <94a0d4530909280401q4a451697re8954320682662f2@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 28 Sep 2009 14:01:48 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129250>

Felipe Contreras <felipe.contreras@gmail.com> writes:

[...]

> Ok, thanks for pointing that out. I was thinking that maybe 'git
> blame' would also be slightly faster on hg, but I really don't know.

hg (and git) store binary deltas.  AFAIK neither attempts to use those
to produce output for blame, diff, etc.  (git's deltas may well be
slightly different from mercurial's, in that git's can be deltas with
respect to something arbitrary so even if they had a suitable line-based
format they'd be useless for diff, blame.)

Similarly for the other major systems, with the exception of (I think)
bzr and darcs.  (I don't know how bzr or darcs actually work, but IIRC
they both have line-based storage that in principle might be usable in
computing blame and diff.)

[...]
