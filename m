From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Tue, 19 Jul 2011 17:57:39 -0400
Message-ID: <20110719215739.GA8613@sigill.intra.peff.net>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-3-git-send-email-artagnon@gmail.com>
 <20110719195504.GA3957@sigill.intra.peff.net>
 <7vipqy7yiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:57:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjIIX-0007C5-0e
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab1GSV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:57:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38741
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab1GSV5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:57:43 -0400
Received: (qmail 2640 invoked by uid 107); 19 Jul 2011 21:58:10 -0000
Received: from m-0-33.docsis.hbci.com (HELO sigill.intra.peff.net) (64.213.220.33)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jul 2011 17:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2011 17:57:39 -0400
Content-Disposition: inline
In-Reply-To: <7vipqy7yiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177511>

On Tue, Jul 19, 2011 at 02:26:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is there a need for this "config_exclusive_filename" hackery at all?
> >
> > I was thinking the result would look more like:
> > ...
> 
> Exactly my thought. I think I suggested the same to Ramkumar earlier and
> he said he will re-roll but perhaps this is a series before that exchange.

This one is incrementally better than the initial one, but I still think
it doesn't go far enough.

-Peff
