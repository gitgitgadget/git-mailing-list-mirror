From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: repair filesystem permissions with
 test_when_finished
Date: Wed, 2 Jul 2014 15:03:31 -0400
Message-ID: <20140702190331.GA9869@sigill.intra.peff.net>
References: <20140702184429.GA32538@sigill.intra.peff.net>
 <20140702190159.GC5816@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:04:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Pog-0000wJ-5x
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 21:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbaGBTDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 15:03:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:55078 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757062AbaGBTDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 15:03:34 -0400
Received: (qmail 32181 invoked by uid 102); 2 Jul 2014 19:03:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 14:03:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 15:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20140702190159.GC5816@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252830>

On Wed, Jul 02, 2014 at 12:01:59PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/t7300-clean.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Does the later "git clean -d with an unreadable empty directory" test
> need the same treatment?

I don't think so, because it is also failing during the experiments I'm
doing and it is not causing the same problem.

-Peff
