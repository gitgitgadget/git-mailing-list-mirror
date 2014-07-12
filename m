From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 21:02:43 -0400
Message-ID: <20140712010243.GA17349@sigill.intra.peff.net>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 03:02:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5liD-00012Y-NP
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 03:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbaGLBCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 21:02:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:60538 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbaGLBCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 21:02:45 -0400
Received: (qmail 7127 invoked by uid 102); 12 Jul 2014 01:02:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 20:02:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 21:02:43 -0400
Content-Disposition: inline
In-Reply-To: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253373>

On Fri, Jul 11, 2014 at 03:55:45PM -0700, Jacob Keller wrote:

> From: Jeff King <peff@peff.net>
> 
> Make the parsing of the --sort parameter more readable by having
> skip_prefix keep our pointer up to date.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Fixed issue with patch in that we dropped the reset to STRCMP_SORT, discovered
> by Junio.

I think what Junio queued in ce85604468 is already correct, so we are
fine as long we build on that.

-Peff
