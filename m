From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3200: test branch creation with -v
Date: Fri, 9 Sep 2011 15:45:38 -0400
Message-ID: <20110909194538.GA31721@sigill.intra.peff.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
 <20110909194357.GA31446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R271G-0000v7-L8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276Ab1IITpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:45:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37531
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1IITpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:45:41 -0400
Received: (qmail 1582 invoked by uid 107); 9 Sep 2011 19:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:46:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:45:38 -0400
Content-Disposition: inline
In-Reply-To: <20110909194357.GA31446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181116>

On Fri, Sep 09, 2011 at 03:43:57PM -0400, Jeff King wrote:

> On Fri, Sep 09, 2011 at 09:40:59PM +0200, Michael J Gruber wrote:
> 
> > +test_expect_success 'git branch -v t should work' '
> > +	git branch -v t &&
> > +	test .git/refs/heads/t &&
> 
> test -f ?

Hmm, this also seems to be a problem in the other tests, too.

-Peff
