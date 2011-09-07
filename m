From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Wed, 7 Sep 2011 15:56:11 -0400
Message-ID: <20110907195611.GD13364@sigill.intra.peff.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
 <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
 <4E5A5290.4050005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 21:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1OEN-0005mQ-85
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 21:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab1IGT4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 15:56:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37038
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab1IGT4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 15:56:13 -0400
Received: (qmail 5203 invoked by uid 107); 7 Sep 2011 19:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 15:57:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 15:56:11 -0400
Content-Disposition: inline
In-Reply-To: <4E5A5290.4050005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180900>

On Sun, Aug 28, 2011 at 04:37:04PM +0200, Michael J Gruber wrote:

> Currently, "-m -d" is forbidden", but "-m -v" is "-m", same for "-d -v".
> Do we want to keep it like that? Probably. I'll add the tests to 4/5.

Yes, I think so. "-v" just means "be more verbose"; the fact that
there is currently nothing to be more verbose about with "-m" and "-d"
is irrelevant.

It does make me a little nervous about the "'git branch -v'
automatically means 'git branch --list -v'" patch, though. It closes the
door in the future to us being more or less verbose about branch
creation details (and while helpful, it creates a slight inconsistency
in the interface).

If we are adding "-l" anyway, is it really necessary? It's not much
harder to do "git branch -lv" once that is in place.

-Peff
