From: Jeff King <peff@peff.net>
Subject: Re: [PATCH-master] tag: add --points-at list option
Date: Wed, 8 Feb 2012 20:44:30 -0500
Message-ID: <20120209014430.GA21661@sigill.intra.peff.net>
References: <20120208205857.GA22479@sigill.intra.peff.net>
 <1328742223-24419-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 02:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvJ40-0001hn-SE
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 02:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab2BIBoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 20:44:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59805
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2BIBoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 20:44:32 -0500
Received: (qmail 22318 invoked by uid 107); 9 Feb 2012 01:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 20:51:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 20:44:30 -0500
Content-Disposition: inline
In-Reply-To: <1328742223-24419-2-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190265>

On Wed, Feb 08, 2012 at 03:03:43PM -0800, Tom Grennan wrote:

> This filters the list for tags of the given object.
> Example,
> 
>    john$ git tag v1.0-john v1.0
>    john$ git tag -l --points-at v1.0
>    v1.0-john
>    v1.0
> 
> Signed-off-by: Tom Grennan <tmgrennan@gmail.com>

This version looks fine to me. Thanks.

-Peff
