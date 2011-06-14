From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 13 Jun 2011 20:30:29 -0400
Message-ID: <20110614003029.GA31447@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
 <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
 <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <20110609162604.GC25885@sigill.intra.peff.net>
 <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
 <4DF6A8B6.9030301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 14 02:30:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWHWo-0007rf-Va
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 02:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab1FNAab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 20:30:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49461
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab1FNAab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 20:30:31 -0400
Received: (qmail 19586 invoked by uid 107); 14 Jun 2011 00:30:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 20:30:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 20:30:29 -0400
Content-Disposition: inline
In-Reply-To: <4DF6A8B6.9030301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175739>

On Tue, Jun 14, 2011 at 02:17:58AM +0200, Andreas Ericsson wrote:

> If you're using svn metadata in the commit text, you can always do
> "git log -p --grep=@20356" to get the commits relevant to that one.
> It's not as fast as "git show svn-20356", but it's not exactly
> glacial either and would avoid the problems you're having now.

If we do end up putting this data into notes eventually (which I think
we _should_ do, because then you aren't locked into having this svn
cruft in your commit messages for all time, but can rather choose
whether or not to display it), it would be nice to have a --grep-notes
feature in git-log. Or maybe --grep should look in notes by default,
too, if we are showing them.

I suspect the feature would be really easy to implement, if somebody is
looking for a gentle introduction to git, or a fun way to spend an hour.
:)

-Peff
