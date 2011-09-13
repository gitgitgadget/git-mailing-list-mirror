From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Documentation: basic configuration of notes.rewriteRef
Date: Tue, 13 Sep 2011 13:18:50 -0400
Message-ID: <20110913171850.GC32251@sigill.intra.peff.net>
References: <7vzki92wdc.fsf@alter.siamese.dyndns.org>
 <95a35723c2ac7e3accfceec2cdededcd213fb59b.1315899036.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:19:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3WdN-0000c0-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab1IMRSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:18:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51920
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1IMRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:18:52 -0400
Received: (qmail 30933 invoked by uid 107); 13 Sep 2011 17:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 13:19:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 13:18:50 -0400
Content-Disposition: inline
In-Reply-To: <95a35723c2ac7e3accfceec2cdededcd213fb59b.1315899036.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181297>

On Tue, Sep 13, 2011 at 09:32:42AM +0200, Thomas Rast wrote:

> Users had problems finding a working setting for notes.rewriteRef.
> Document how to enable rewriting for notes/commits, which should be a
> safe setting.

Thanks. After our discussion, I am left with the feeling that it is
probably going to be the problem of the individual notes-refs to say "I
am immutable; don't rewrite me" (probably by putting them in some
special part of the ref namespace). But until we figure out exactly how
that will work, this is a safe and sane step forward.

-Peff
