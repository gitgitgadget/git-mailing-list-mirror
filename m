From: Jeff King <peff@peff.net>
Subject: Re: Merging limitations after directory renames -- interesting test
 repo
Date: Sat, 19 Feb 2011 05:19:36 -0500
Message-ID: <20110219101936.GB20577@sigill.intra.peff.net>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net>
 <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 11:19:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqjui-00037D-BO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 11:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab1BSKTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 05:19:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37581 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1BSKTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 05:19:38 -0500
Received: (qmail 8548 invoked by uid 111); 19 Feb 2011 10:19:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 10:19:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 05:19:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167264>

On Fri, Feb 18, 2011 at 03:27:36PM -0800, Linus Torvalds wrote:

> So I do think we could try to lift the default a bit, but it might be
> even more important to just make the message much more noticeable and
> avoid scrolling past it. For example, setting a flag, and not printing
> out the message immediately, but instead print it out only if it turns
> into trouble at the end.

So here's a patch series. It's built on your other 3 patches (all of
which I thought looked good, btw).

  [1/4]: merge: improve inexact rename limit warning
  [2/4]: bump rename limit defaults (again)
  [3/4]: commit: stop setting rename limit
  [4/4]: inexact rename detection eye candy

-Peff
