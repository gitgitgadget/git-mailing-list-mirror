From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1300: attempting to remove a non-existent .git/config
 is not an error
Date: Wed, 19 Oct 2011 12:13:02 -0400
Message-ID: <20111019161302.GA3157@sigill.intra.peff.net>
References: <20111012182742.GA14543@sigill.intra.peff.net>
 <20111012182920.GA18948@sigill.intra.peff.net>
 <4E9E7115.60303@viscovery.net>
 <7vzkgxcviz.fsf@alter.siamese.dyndns.org>
 <4E9E7E22.7010905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 18:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGYlX-0001ad-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 18:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab1JSQNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 12:13:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35679
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1JSQNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 12:13:06 -0400
Received: (qmail 30391 invoked by uid 107); 19 Oct 2011 16:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Oct 2011 12:13:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2011 12:13:02 -0400
Content-Disposition: inline
In-Reply-To: <4E9E7E22.7010905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183933>

On Wed, Oct 19, 2011 at 09:37:06AM +0200, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> Since some tests before test number 79 ("quoting") are skipped, .git/config
> does not exist and 'rm .git/config' fails. Fix this particular case.
> 
> While at it, move other instance of 'rm .git/config' that occur in this
> file inside the test function to document that the test cases want to
> protect themselves from remnants of earlier tests.

Thanks, this fix looks good to me.

-Peff
