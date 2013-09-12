From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http-backend: provide Allow header for 405
Date: Thu, 12 Sep 2013 00:46:37 -0400
Message-ID: <20130912044637.GA1356@sigill.intra.peff.net>
References: <1378945801-122021-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jkoleszar@google.com,
	gitster@pobox.com, jrnieder@gmail.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 06:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJynk-0000qM-Oa
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 06:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab3ILEql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 00:46:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:51542 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab3ILEqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 00:46:40 -0400
Received: (qmail 28429 invoked by uid 102); 12 Sep 2013 04:46:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Sep 2013 23:46:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 00:46:37 -0400
Content-Disposition: inline
In-Reply-To: <1378945801-122021-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234623>

On Thu, Sep 12, 2013 at 12:30:01AM +0000, brian m. carlson wrote:

> The HTTP 1.1 standard requires an Allow header for 405 Method Not Allowed:
> 
>   The response MUST include an Allow header containing a list of valid methods
>   for the requested resource.
> 
> So provide such a header when we return a 405 to the user agent.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks, this looks good to me.

-Peff
