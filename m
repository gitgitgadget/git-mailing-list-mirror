From: Jeff King <peff@peff.net>
Subject: moving to a git-backed wiki
Date: Tue, 1 Feb 2011 15:11:44 -0500
Message-ID: <20110201201144.GA16003@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 21:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkMZt-0000P0-Oa
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 21:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1BAULr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 15:11:47 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60546 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab1BAULq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 15:11:46 -0500
Received: (qmail 21834 invoked by uid 111); 1 Feb 2011 20:11:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Feb 2011 20:11:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Feb 2011 15:11:44 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165849>

On Tue, Feb 01, 2011 at 10:34:24AM -0800, Scott Chacon wrote:

> > GitHub's wiki gets this right. I'm not saying we should host our wiki
> > there (well, it _would_ make setting it up pretty damn easy). But their
> > wiki system (gollum) is open-source, albeit in ruby. And surely there
> > are other git-backed alternatives (it's been a while since I've looked).
> 
> If you want to use the wiki on the git/git repo on GitHub that is
> being mirrored from the canonical repository, I've added Junio and
> peff to the account.  If you want to use that wiki, anyone with a
> github account can edit wiki pages on the site or clone and edit it
> locally and push changes up.  You can also turn off site edits so
> people have to send Junio a patch instead.  It's up to you guys, but
> the access is there now if you want.

Out of curiosity, I scraped the kernel wiki and put it into gollum. The
results are here, if people want to see what it looks like:

  https://github.com/peff/foo/wiki

It's extremely quick and dirty, which is why I didn't put it in the
actual git/git/wiki spot you made. Some of the formatting is off (note
that I didn't do any conversion; it understands mediawiki natively), and
some of the content is probably missing (my scraper was extremely
naive). For a real import I would try to get the actual wiki db from
kernel.org and import the entire history.

I dunno what the next step would be. I would really prefer a git-backed
wiki, but moving to something like this is a pretty big step in workflow
for people who use the current wiki. I would be curious to hear general
opinions (on the idea of moving, assuming we did a conversion that
actually looked good). I'll change the subject and see if we get any
comments.

-Peff
