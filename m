From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Wed, 14 Sep 2011 14:29:33 -0400
Message-ID: <20110914182933.GA15884@sigill.intra.peff.net>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
 <20110912224934.GA28994@sigill.intra.peff.net>
 <4E6FAB46.30508@web.de>
 <20110913221745.GB24549@sigill.intra.peff.net>
 <4E70F224.2080401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uDO-00064K-RG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324Ab1INS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:29:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261Ab1INS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:29:35 -0400
Received: (qmail 12502 invoked by uid 107); 14 Sep 2011 18:30:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 14:30:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 14:29:33 -0400
Content-Disposition: inline
In-Reply-To: <4E70F224.2080401@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181375>

On Wed, Sep 14, 2011 at 08:27:48PM +0200, Jens Lehmann wrote:

> Am 14.09.2011 00:17, schrieb Jeff King:
> > One thing that could make it slightly less expensive (but I wouldn't
> > worry about implementing until it becomes an issue): you do a full diff
> [...]

> I think this would work for the functionality which is implemented right
> now. But with Frederik's gitfile work I hope to enable git to support
> submodules being moved around in the work tree rather soonish. Then we
> would be blind for any changes in the new location. Until it hurts us
> I'd prefer to stay with the correct version, even if it is a bit slower.

Agreed. Let's worry about it if and when it becomes a performance issue.

Thanks for putting up my with my total cluelessness regarding what's
happening in submodules. ;)

-Peff
