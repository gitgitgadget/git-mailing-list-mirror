From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/10] replace: die early if replace ref already exists
Date: Sat, 17 May 2014 03:05:18 -0400
Message-ID: <20140517070518.GD13003@sigill.intra.peff.net>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
 <20140517064133.18932.92343.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 17 09:05:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYgO-0000QA-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbaEQHFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:05:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:53678 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755848AbaEQHFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:05:20 -0400
Received: (qmail 10912 invoked by uid 102); 17 May 2014 07:05:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:05:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:05:18 -0400
Content-Disposition: inline
In-Reply-To: <20140517064133.18932.92343.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249454>

On Sat, May 17, 2014 at 08:41:29AM +0200, Christian Couder wrote:

> If a replace ref already exists for an object, it is
> much better for the user if we error out before we
> let the user edit the object, rather than after.

Definitely. Code looks fine to me.

-Peff
