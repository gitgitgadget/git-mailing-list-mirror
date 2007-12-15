From: Jeff King <peff@peff.net>
Subject: Re: git-browse-help?
Date: Sat, 15 Dec 2007 06:01:53 -0500
Message-ID: <20071215110153.GA3447@coredump.intra.peff.net>
References: <20071214092829.GA22725@coredump.intra.peff.net> <7vtzmlrxc2.fsf@gitster.siamese.dyndns.org> <20071215100811.GA1692@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Umi-0004f7-Ss
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 12:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbXLOLB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 06:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbXLOLB5
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 06:01:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3639 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbXLOLB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 06:01:56 -0500
Received: (qmail 9492 invoked by uid 111); 15 Dec 2007 11:01:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Dec 2007 06:01:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 06:01:53 -0500
Content-Disposition: inline
In-Reply-To: <20071215100811.GA1692@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68382>

On Sat, Dec 15, 2007 at 05:08:11AM -0500, Jeff King wrote:

> On Fri, Dec 14, 2007 at 09:38:05AM -0800, Junio C Hamano wrote:
> 
> > > Should it perhaps be "git--browse-help" or "git-help--browse" to follow
> > Good eyes and a sensible argument.  Go wild.
> 
> Looks like you beat me to it. Thanks.

Although I would have called it "git-help--browse" rather than
"git-browse--help" since

  a) it is related to "git help", not "git browse"
  b) there is no tab completion conflict with git-he, but there is with
     git-br. :) This is of course because I am using the file
     completion, but the programmable bash completion has the same
     problem. Shawn, perhaps it should simply ignore *--* as plumbing?

I can prepare a patch if "git-help--browse" makes more sense.

-Peff
