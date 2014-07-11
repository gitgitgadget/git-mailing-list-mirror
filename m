From: Jeff King <peff@peff.net>
Subject: Re: pitfall with empty commits during git rebase
Date: Fri, 11 Jul 2014 14:25:31 -0400
Message-ID: <20140711182531.GG7856@sigill.intra.peff.net>
References: <20140711101547.GA26050@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:25:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fVx-0007iM-CK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbaGKSZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:25:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:60304 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751314AbaGKSZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:25:33 -0400
Received: (qmail 15967 invoked by uid 102); 11 Jul 2014 18:25:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 13:25:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 14:25:31 -0400
Content-Disposition: inline
In-Reply-To: <20140711101547.GA26050@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253310>

On Fri, Jul 11, 2014 at 12:15:47PM +0200, Olaf Hering wrote:

> Could not apply 6c5842320acc797d395afb5cdf373c2bfaebfa34... revert
> ....
> 
> Its not clear what '--allow-empty' refers to, git rebase does not seem to
> understand this option.

I think this is the same problem discussed recently in:

  http://thread.gmane.org/gmane.comp.version-control.git/251365

-Peff
