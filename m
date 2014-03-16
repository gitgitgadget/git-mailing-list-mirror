From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] mv: prevent mismatched data when ignoring errors.
Date: Sat, 15 Mar 2014 22:00:52 -0400
Message-ID: <20140316020051.GB20019@sigill.intra.peff.net>
References: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
 <1394909812-92472-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Mar 16 03:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP0Nm-0001NR-TR
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 03:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbaCPCAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 22:00:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:40332 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755062AbaCPCAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 22:00:54 -0400
Received: (qmail 3498 invoked by uid 102); 16 Mar 2014 02:00:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Mar 2014 21:00:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Mar 2014 22:00:52 -0400
Content-Disposition: inline
In-Reply-To: <1394909812-92472-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244178>

On Sat, Mar 15, 2014 at 06:56:52PM +0000, brian m. carlson wrote:

> We shrink the source and destination arrays, but not the modes or
> submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
> all the arrays at the same time to prevent this.  Add tests to ensure the
> problem does not recur.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> 
> I attempted to come up with a second patch that would refactor out the
> four different arrays into one array of struct, as Jeff suggested, but
> it became very ugly very quickly.  So this patch simply fixes the
> problem and adds tests.

>From my brief look, I feared that might be the case. Oh well, thanks for
trying.

-Peff
