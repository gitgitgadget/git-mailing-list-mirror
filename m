From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2011, #04; Wed, 12)
Date: Wed, 12 Oct 2011 15:02:13 -0400
Message-ID: <20111012190213.GA19578@sigill.intra.peff.net>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE44U-0006P1-Td
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1JLTCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:02:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58707
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab1JLTCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:02:15 -0400
Received: (qmail 14525 invoked by uid 107); 12 Oct 2011 19:02:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 15:02:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 15:02:13 -0400
Content-Disposition: inline
In-Reply-To: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183398>

On Wed, Oct 12, 2011 at 11:48:48AM -0700, Junio C Hamano wrote:

> * jk/name-hash-dirent (2011-10-07) 1 commit
>   (merged to 'next' on 2011-10-11 at e2ea68b)
>  + fix phantom untracked files when core.ignorecase is set

I didn't see any comment on the original patch, so I assume you're OK
with the few extra bytes added to each cache entry? Otherwise, I can try
to retool it to keep the directory entries in a separate hash, so only
case-insensitive people pay the extra price.

I did a few trivial timings, and the extra bytes didn't seem to make any
difference.

-Peff
