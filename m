From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Fri, 6 Jan 2012 17:32:15 -0500
Message-ID: <20120106223215.GA13106@sigill.intra.peff.net>
References: <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
 <20120106155204.GA17355@sigill.intra.peff.net>
 <20120106194800.GA9301@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:32:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjIKp-00061h-46
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759225Ab2AFWcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:32:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59706
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759218Ab2AFWcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:32:18 -0500
Received: (qmail 9452 invoked by uid 107); 6 Jan 2012 22:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 17:39:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 17:32:15 -0500
Content-Disposition: inline
In-Reply-To: <20120106194800.GA9301@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188050>

On Fri, Jan 06, 2012 at 08:48:00PM +0100, Clemens Buchacher wrote:

> I have rebased Junio's cb/git-daemon-tests onto your
> jk/child-cleanup and replaced the call to pkill with a regular kill
> command.

Looks pretty good from my cursory examination. I think you should fill
out the rationale for "kill dashed externals on exit" a bit. My
reasoning is that whether a git command is an internal or external
process is purely an implementation detail, and killing the git wrapper
should behave identically in both cases.

> On top of that, I have added two commits to fix the discussed race
> condition. I also verified that the race condition actually happens
> by adding an artificial delay in the daemon (this change is
> obviously not included).

Looks reasonable to me.

> I pushed the new cb/git-daemon-tests to
> https://github.com/drizzd/git . If you have no objections I will
> post the entire series including your run-command and send-pack
> patches to the list.

No objections here. Thanks for moving this forward.

-Peff
