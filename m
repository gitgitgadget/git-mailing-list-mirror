From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 7 Sep 2011 13:40:44 -0400
Message-ID: <20110907174044.GA11341@sigill.intra.peff.net>
References: <20110901184815.2cd8b472@pomiocik.lan>
 <1314895801-21147-1-git-send-email-mgorny@gentoo.org>
 <20110902163903.GA21768@sigill.intra.peff.net>
 <20110902193931.42593338@pomiocik.lan>
 <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1M7M-0008WE-Jm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab1IGRku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:40:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57490
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1IGRku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:40:50 -0400
Received: (qmail 3843 invoked by uid 107); 7 Sep 2011 17:41:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:41:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:40:44 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180884>

On Fri, Sep 02, 2011 at 01:53:23PM -0400, Jeff King wrote:

> But there may be other corner cases.  I need to read through the code
> more carefully, which I should have time to do later today.

This ended up a little trickier than I expected, but I think the series
below is what we should do. I tried to add extensive tests, but let me
know if you can think of any other corner cases.

  [1/5]: t7004: factor out gpg setup
  [2/5]: t6300: add more body-parsing tests
  [3/5]: for-each-ref: refactor subject and body placeholder parsing
  [4/5]: for-each-ref: handle multiline subjects like --pretty
  [5/5]: for-each-ref: add split message parts to %(contents:*).

-Peff
