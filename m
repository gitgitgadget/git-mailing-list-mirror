From: Jeff King <peff@peff.net>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
	branch
Date: Tue, 8 Jul 2008 00:26:07 -0400
Message-ID: <20080708042607.GC7186@sigill.intra.peff.net>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <20080707111803.GF31490@mit.edu> <m34p71gbuk.fsf@localhost.localdomain> <F0AD23BC-FA9A-4593-8942-228C428B661E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4nO-0002cU-TE
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYGHE0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYGHE0S
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:26:18 -0400
Received: from peff.net ([208.65.91.99]:4239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYGHE0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:26:18 -0400
Received: (qmail 28094 invoked by uid 111); 8 Jul 2008 04:26:16 -0000
Received: from c-75-75-1-159.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.1.159)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jul 2008 00:26:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jul 2008 00:26:07 -0400
Content-Disposition: inline
In-Reply-To: <F0AD23BC-FA9A-4593-8942-228C428B661E@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87706>

On Mon, Jul 07, 2008 at 11:03:46AM -0400, Brian Gernhardt wrote:

> I personally expected @{1} to be identical to HEAD@{1}.  Since omitting a 
> ref usually refers to HEAD, why shouldn't omitting it when referring to 
> the reflogs mean the HEAD log?  The definition of @{1} is useful since 
> there's no other easy way to get "current branch's reflog", but I think 
> it's non-obvious.  (Since HEAD@{1} is something completely different, I 
> think the only other way to refer to @{1} is $(git symbolic-ref)@{1}.)

FYI, there was much discussion about this exact point:

  http://thread.gmane.org/gmane.comp.version-control.git/38379

(I don't know that it has that much bearing on the current discussion,
but since I went to the trouble of digging it up, I thought you might
find it useful).

-Peff
