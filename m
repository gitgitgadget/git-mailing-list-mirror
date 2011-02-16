From: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 11:54:27 +0100
Message-ID: <20110216105427.GA27909@pcpool00.mathematik.uni-freiburg.de>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102151606.21040.johan@herland.net> <7vipwlp3yv.fsf@alter.siamese.dyndns.org> <201102160154.24744.johan@herland.net> <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:54:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppf1n-0005M7-9p
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab1BPKyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:54:31 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:53147
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983Ab1BPKya (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 05:54:30 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Ppf1f-0002dd-GI; Wed, 16 Feb 2011 11:54:27 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Ppf1f-0007HZ-ER; Wed, 16 Feb 2011 11:54:27 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102160421300.14950@debian>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166958>

* Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> [110216 10:43]:
> On Wed, 16 Feb 2011, Matthieu Moy wrote:
>
> > Johan Herland <johan@herland.net> writes:
> >
> > > In order to make this more understandable to the user, we rename the
> > > push.default == 'tracking' option to push.default == 'upstream'.
> >
> > While we're there, shouldn't we also rename 'branch.<remote>.merge' to
> > 'branch.<remote>.upstream'?
>
> I have a draft proposal not exactly to rename it, but to replace it by
> a new branch.<name>.upstream which would point to local ref rather
> than a ref on the remote, so one would have e.g.
> branch.topic.upstream = refs/remotes/origin/master.

Making it name a local ref name would also make it easier to add support
for listing multiple references.

The use case I miss support for (please hint me if this is already
possible somehow), is having multiple remotes where other people (or
more importantly I at other computers for projects without central
repository) add commits.

Currently one needs to fetch all the remotes and then manually do a
merge remote1/branchname remote2/branchname remote3/branchname and so
on. It would be nice if a single git pull could do that.

	Bernhard R. Link
