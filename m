From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 13:50:56 -0400
Message-ID: <20140711175056.GE7856@sigill.intra.peff.net>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:51:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eyM-0005OD-ER
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbaGKRu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:50:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:60276 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753631AbaGKRu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:50:58 -0400
Received: (qmail 13855 invoked by uid 102); 11 Jul 2014 17:50:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 12:50:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 13:50:56 -0400
Content-Disposition: inline
In-Reply-To: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253303>

On Fri, Jul 11, 2014 at 10:24:05AM -0700, Jacob Keller wrote:

> Make the parsing of the --sort parameter more readable by having
> skip_prefix keep our pointer up to date.
> 
> Authored-by: Jeff King <peff@peff.net>

I suspect Junio may just apply this on the version of the commit he has
upstream, so you may not need this as part of your series.

However, for reference, the right way to handle authorship is with a

  From: Jeff King <peff@peff.net>

at the top of your message body. Git-am will pick that up and turn it
into the author field of the commit.

-Peff
