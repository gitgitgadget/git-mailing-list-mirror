From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 15:18:49 -0700
Message-ID: <20120417221849.GA11936@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <20120417220838.GB10797@sigill.intra.peff.net>
 <7vr4vmm29z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGjo-0003Jg-6e
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab2DQWS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:18:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37411
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab2DQWSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:18:54 -0400
Received: (qmail 9303 invoked by uid 107); 17 Apr 2012 22:19:01 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 18:19:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 15:18:49 -0700
Content-Disposition: inline
In-Reply-To: <7vr4vmm29z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195819>

On Tue, Apr 17, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:

> > How many cores are there on this box? Have you tried setting
> > pack.windowMemory to (12 / # of cores) or thereabouts?
> 
> Hrm, from the end-user's point of view, it appears that pack.windowMemory
> ought to mean the total without having to worry about the division of it
> across threads (which the implementation should be responsible for).

Agreed. I had to look in the code to check which it meant. I'm not sure
we can change it without regressing existing users, though.

-Peff
