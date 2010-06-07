From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: DWIM "git checkout frotz" to
         "git checkout -b frotz origin/frotz"
Date: Mon, 07 Jun 2010 20:52:09 +0100
Message-ID: <80631uboye.fsf@tiny.isode.net>
References: <20100605110930.GA10526@localhost>
            <vpqljas5e33.fsf@bauges.imag.fr>
            <20100606164642.GA10104@localhost>
            <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
            <20100607185439.GB17343@localhost>
            <vpqzkz6fy9m.fsf@bauges.imag.fr>
            <20100607193226.GA19789@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:52:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLiMq-000125-3t
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab0FGTwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 15:52:10 -0400
Received: from rufus.isode.com ([62.3.217.251]:48209 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743Ab0FGTwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 15:52:09 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <TA1N5gBeGX=L@rufus.isode.com>; Mon, 7 Jun 2010 20:52:06 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 07 Jun 2010 20:52:09 +0100
X-Hashcash: 1:20:100607:ribasushi@cpan.org::F0elim3dLSTkdLXI:000000000000000000000000000000000000000000013BN
X-Hashcash: 1:20:100607:drizzd@aon.at::Ap47WCCiSfBM1in1:00003k0V
X-Hashcash: 1:20:100607:miles@gnu.org::fAraMsTkpiNGndkV:00007AUW
X-Hashcash: 1:20:100607:git@vger.kernel.org::Ab9c99cs9CbdLKiS:0000000000000000000000000000000000000000005CBQ
X-Hashcash: 1:20:100607:matthieu.moy@grenoble-inp.fr::yRSUJnsP+8HoUedx:000000000000000000000000000000000EXWk
In-Reply-To: <20100607193226.GA19789@localhost> (Clemens Buchacher's message
	of "Mon, 7 Jun 2010 21:32:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148621>

Clemens Buchacher <drizzd@aon.at> writes:

[...]

> "git checkout <branch>", on the other hand, will create a branch
> based on a remote branch, even though you neither asked for a new
> branch, nor did you specify any remote at all.

Provided such a branch doesn't already exist and that only one remote
matches.  I agree it's magic (and understand why people might not like
it) but personally I find it convenient.

Possibly (because it hides the distinction between local and remote
branches a little) it would be better opt-in than the default, but I
think a reasonable case could be made in both directions.

[...]
