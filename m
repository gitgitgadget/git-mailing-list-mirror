From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Wed, 24 Sep 2008 16:31:04 -0700
Message-ID: <20080924233104.GG3669@spearce.org>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com> <20080921112519.GA24200@diku.dk> <200809222242.29165.robin.rosenberg.lists@dewire.com> <20080922210734.GE3669@spearce.org> <20080924232519.GA15318@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	sverre@rabbelier.nl, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 25 01:32:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KidqD-0007kI-DD
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbYIXXbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 19:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYIXXbG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:31:06 -0400
Received: from george.spearce.org ([209.20.77.23]:34222 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIXXbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:31:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 38D8E3835F; Wed, 24 Sep 2008 23:31:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080924232519.GA15318@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96713>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote Mon, Sep 22, 2008:
> > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > s=C3=B6ndagen den 21 september 2008 13.25.19 skrev Jonas Fonseca:
> > > > +		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
=2E..
> > > This one is really (as you noted) bad so we shouldn't allow it at=
 all.
>=20
> Using exceptions seems a bit harsh, since the quote is not really fat=
al
> in anyway.
=2E..
> I propose to simply remove these hosts from the host map and clear
> the current host list so that no values will be saved, effectively
> causing invalid hosts to result in the same as unknown hosts.

Yea, that seems quite reasonable.

If you want more debugging than that on your ~/.ssh/config file then
run OpenSSH tools on it.  Hell, I can't count the number of times
I've made typos in there and couldn't figure out why it was still
asking for a password, etc.  And that's just the OpenSSH command
line tools.

--=20
Shawn.
