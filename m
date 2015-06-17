From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test-lib.sh: fix color support when tput needs
 ~/.terminfo
Date: Wed, 17 Jun 2015 16:25:08 -0400
Message-ID: <20150617202507.GA25234@peff.net>
References: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
 <1434567986-23552-3-git-send-email-rhansen@bbn.com>
 <20150617194315.GE25304@peff.net>
 <5581D099.7090200@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Jtc-0000WT-G1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbbFQUZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:25:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:47661 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751821AbbFQUZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:25:10 -0400
Received: (qmail 4014 invoked by uid 102); 17 Jun 2015 20:25:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:25:10 -0500
Received: (qmail 29179 invoked by uid 107); 17 Jun 2015 20:25:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 16:25:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 16:25:08 -0400
Content-Disposition: inline
In-Reply-To: <5581D099.7090200@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271907>

On Wed, Jun 17, 2015 at 03:55:05PM -0400, Richard Hansen wrote:

> > I do not mind it so much as you have
> > it, but it does mean adding a new field needs to update two spots.
> 
> I also don't like the duplicate list of color types, and I considered
> doing something similar to what you suggested, but I decided against it.
>  I'm a bit worried about bizarre syntax errors or code execution if
> say_color() is used improperly.  ('eval' with uncontrolled variables
> makes me nervous.)

As Junio pointed out, I think all bets are off in the test scripts. They
are running tons of arbitrary code. :)

But for the record, I am fine with your patch as-is. Thanks for looking
into it.

-Peff
