From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Wed, 10 Jul 2013 06:57:50 -0400
Message-ID: <20130710105750.GC9724@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707100949.GC19143@sigill.intra.peff.net>
 <20130707211538.GB6478@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 12:58:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uws5u-0007OF-QF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 12:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab3GJK5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 06:57:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:47446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab3GJK5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 06:57:54 -0400
Received: (qmail 23030 invoked by uid 102); 10 Jul 2013 10:59:11 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 05:59:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 06:57:50 -0400
Content-Disposition: inline
In-Reply-To: <20130707211538.GB6478@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230037>

On Sun, Jul 07, 2013 at 09:15:41PM +0000, brian m. carlson wrote:

> On Sun, Jul 07, 2013 at 06:09:49AM -0400, Jeff King wrote:
> > +NOTE: The on-disk size reported is accurate, but care should be taken in
> > +drawing conclusions about which refs or objects are responsible for disk
> > +usage. The size of a packed non-delta object be much larger than the
> 
> You probably meant "may be" here.               ^

Thanks, fixed in my re-roll.

-Peff
