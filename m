From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Wed, 13 Nov 2013 02:17:47 -0500
Message-ID: <20131113071747.GA31251@sigill.intra.peff.net>
References: <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
 <20131112.214357.1022923291448967795.chriscool@tuxfamily.org>
 <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
 <20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, ae@op5.se, git@vger.kernel.org,
	apenwarr@gmail.com, Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
	max@quendi.de
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 13 08:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgUi2-0007ty-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 08:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219Ab3KMHRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 02:17:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:38275 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750Ab3KMHRt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 02:17:49 -0500
Received: (qmail 17082 invoked by uid 102); 13 Nov 2013 07:17:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Nov 2013 01:17:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Nov 2013 02:17:47 -0500
Content-Disposition: inline
In-Reply-To: <20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237780>

On Wed, Nov 13, 2013 at 07:47:03AM +0100, Christian Couder wrote:

> My preference is:
> 
> 1) with an "s"
> 2) "start"
> 3) underscore
> 
> so that gives: starts_with() and ends_with()

FWIW, that looks good to me, too. Whether there is confusion over the
meaning of "suffix" or not, it makes sense, all other things being
equal, to use the same terms as other popular languages.

Like you, I prefer "with an s", but we are deep in bikeshedding
territory now. I can live with anything. :)

-Peff
