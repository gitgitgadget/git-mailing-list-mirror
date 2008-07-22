From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 02:06:43 -0400
Message-ID: <20080722060643.GA25023@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:07:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLB2K-0005GP-1i
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYGVGGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYGVGGp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:06:45 -0400
Received: from peff.net ([208.65.91.99]:2619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbYGVGGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:06:45 -0400
Received: (qmail 2723 invoked by uid 111); 22 Jul 2008 06:06:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 02:06:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 02:06:43 -0400
Content-Disposition: inline
In-Reply-To: <20080722053921.GA4983@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89440>

On Tue, Jul 22, 2008 at 07:39:21AM +0200, Mike Hommey wrote:

> > This marks diff-files as FORBID_PAGER; I will leave it to others to
> > fight about which commands should have it. But it doesn't make sense to
> > mark "status" since some people obviously _want_ the paging there.
> 
> Why not "simply" forbid the pager when output is not a terminal ?

We already do that (see pager.c:53). The original poster still had a
problem, but I don't know if it was for actual usage or simply a toy

  $ git status
  $ echo $?
  $ echo "why don't exit codes work in status?" | mail git@vger

question.

-Peff
