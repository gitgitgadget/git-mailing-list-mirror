From: Jeff King <peff@peff.net>
Subject: Re: Adding 'Signed-off-by' to 'subtree add --squash' commits
Date: Mon, 7 Jul 2014 13:20:17 -0400
Message-ID: <20140707172017.GA28405@sigill.intra.peff.net>
References: <6A74A01C3512C646A9ED99AFA28AEB981358A7E8@IRSMSX102.ger.corp.intel.com>
 <87vbr93y8k.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Finucane, Stephen" <stephen.finucane@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Gray, Mark D" <mark.d.gray@intel.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CaW-0004hw-I8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbaGGRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:20:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:57553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbaGGRUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:20:20 -0400
Received: (qmail 10501 invoked by uid 102); 7 Jul 2014 17:20:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Jul 2014 12:20:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jul 2014 13:20:17 -0400
Content-Disposition: inline
In-Reply-To: <87vbr93y8k.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252972>

On Mon, Jul 07, 2014 at 06:55:07PM +0200, Andreas Schwab wrote:

> "Finucane, Stephen" <stephen.finucane@intel.com> writes:
> 
> > Is it possible to "sign off" squashed commits created by the 'git subtree add ... --squash' command?
> 
> If it isn't directly possible, you can always use "git commit --amend -C
> HEAD -s" to modify the commit afterwards.

I think that is sensible, though these days you can spell "-C HEAD" as
"--no-edit", which I think is a bit more obvious.

-Peff
