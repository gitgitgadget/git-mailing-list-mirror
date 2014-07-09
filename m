From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: do not complain on EOF from parent git
Date: Wed, 9 Jul 2014 17:42:17 -0400
Message-ID: <20140709214217.GD25854@sigill.intra.peff.net>
References: <787461404891471@web12h.yandex.ru>
 <20140709205902.GB25854@sigill.intra.peff.net>
 <20140709212043.GC25854@sigill.intra.peff.net>
 <1404941118.23510.34.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"wipedout@yandex.ru" <wipedout@yandex.ru>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:42:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zd9-0006hG-AL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbaGIVmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:42:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:58985 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbaGIVmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:42:19 -0400
Received: (qmail 10268 invoked by uid 102); 9 Jul 2014 21:42:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:42:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:42:17 -0400
Content-Disposition: inline
In-Reply-To: <1404941118.23510.34.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253155>

On Wed, Jul 09, 2014 at 09:25:18PM +0000, Keller, Jacob E wrote:

> On Wed, 2014-07-09 at 17:20 -0400, Jeff King wrote:
> > The parent git process is supposed to send us an empty line
> > to indicate that the conversation is over. However, the
> > parent process may die() if there is a problem with the
> > operaiton (e.g., we try to fetch a ref that does not exist). 
> 
> Nitpick, but you probably meant operation here.

I did (and I probably meant to turn on spellcheck, too...).

I'll repost in a minute, as I have some follow-on patches. Thanks.

-Peff
