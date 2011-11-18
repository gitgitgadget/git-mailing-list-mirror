From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] refresh_index: notice typechanges in output
Date: Fri, 18 Nov 2011 06:09:38 -0500
Message-ID: <20111118110938.GA5940@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
 <20111114225651.GD3993@sigill.intra.peff.net>
 <7vaa7yi6wv.fsf@alter.siamese.dyndns.org>
 <20111115020506.GA6305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 12:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRMKt-0008WG-Uj
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 12:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1KRLJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 06:09:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47286
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab1KRLJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 06:09:40 -0500
Received: (qmail 31177 invoked by uid 107); 18 Nov 2011 11:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Nov 2011 06:09:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2011 06:09:38 -0500
Content-Disposition: inline
In-Reply-To: <20111115020506.GA6305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185649>

On Mon, Nov 14, 2011 at 09:05:06PM -0500, Jeff King wrote:

> Do you want to add your patch on top, or do you want me to re-roll with
> this squashed in? I can also hold the re-roll until post-release if you
> want.

You mentioned squashing in the "what's cooking" message. Rather than
squashing just the typechange bits, how about this re-roll, which I
think is a little easier to follow:

  [1/3]: read-cache: let refresh_cache_ent pass up changed flags
  [2/3]: refresh_index: rename format variables
  [3/3]: refresh_index: make porcelain output more specific

-Peff
