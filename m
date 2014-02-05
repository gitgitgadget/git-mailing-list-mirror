From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/13] Makefile: add c-quote helper function
Date: Wed, 5 Feb 2014 14:17:28 -0500
Message-ID: <20140205191728.GA15489@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
 <20140205175809.GI15218@sigill.intra.peff.net>
 <xmqqmwi54bl7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:17:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7yZ-0007vS-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbaBETRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:17:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:45215 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbaBETRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:17:30 -0500
Received: (qmail 12241 invoked by uid 102); 5 Feb 2014 19:17:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 13:17:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 14:17:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmwi54bl7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241642>

On Wed, Feb 05, 2014 at 11:13:24AM -0800, Junio C Hamano wrote:

> > +# Quote the value as C string inside a shell string. Good for passing strings
> > +# on the command line via "-DFOO=$(call # scq,$(FOO))".
> 
> "call # scq"???

Whoops. Bad rewrapping of the comment. It should obviously just be

  -DFOO=$(call scq,$(FOO))

-Peff
