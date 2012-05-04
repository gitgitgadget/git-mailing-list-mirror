From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] http: handle proxy authentication failure (error 407)
Date: Fri, 4 May 2012 03:23:29 -0400
Message-ID: <20120504072329.GD21895@sigill.intra.peff.net>
References: <4FA2B4EE.6010008@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCrd-0008F5-I6
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab2EDHXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:23:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57624
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab2EDHXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:23:32 -0400
Received: (qmail 16198 invoked by uid 107); 4 May 2012 07:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:23:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:23:29 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B4EE.6010008@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197000>

On Thu, May 03, 2012 at 06:40:14PM +0200, Nelson Benitez Leon wrote:

> Handle http 407 error code by asking for credentials and
> retrying request in case credentials were not present, or
> marking credentials as rejected if they were already provided.

This one looks good to me.

-Peff
