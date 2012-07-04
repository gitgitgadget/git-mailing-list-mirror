From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2012, #01; Tue, 3)
Date: Wed, 4 Jul 2012 03:28:13 -0400
Message-ID: <20120704072813.GD24807@sigill.intra.peff.net>
References: <7vd34ctoub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmK0d-0000dJ-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab2GDH2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 03:28:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52848
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab2GDH2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:28:16 -0400
Received: (qmail 31156 invoked by uid 107); 4 Jul 2012 07:28:24 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jul 2012 03:28:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jul 2012 03:28:13 -0400
Content-Disposition: inline
In-Reply-To: <7vd34ctoub.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200993>

On Tue, Jul 03, 2012 at 04:19:24PM -0700, Junio C Hamano wrote:

> [Discarded]
> [...]
> 
> * jk/no-op-push-message (2012-05-30) 1 commit
>  . improve no-op push output
> 
> Rewords the status message of "git push" that pushed only one ref
> differently from "Everything up-to-date", to give a bit more help to
> people who get the message when their current branch is not pushed.
> 
> I had an impression after the discussion thread that a redesign is
> coming, but it hasn't happened yet.

After our discussion, I was not really convinced that it was a good
direction to go in. So I'm happy to scrap this for now, and somebody may
or may not come up with something better later.

-Peff
