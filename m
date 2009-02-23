From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Mon, 23 Feb 2009 02:10:56 -0500
Message-ID: <20090223071056.GA29241@coredump.intra.peff.net>
References: <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl> <20090220172918.GB4636@coredump.intra.peff.net> <499F3B9B.3020709@pelagic.nl> <20090223000840.GA20392@coredump.intra.peff.net> <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl> <20090223065615.GA24807@coredump.intra.peff.net> <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:12:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUzL-0005tk-1v
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZBWHLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbZBWHK7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:10:59 -0500
Received: from peff.net ([208.65.91.99]:46805 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbZBWHK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 02:10:58 -0500
Received: (qmail 21256 invoked by uid 107); 23 Feb 2009 07:11:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 02:11:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 02:10:56 -0500
Content-Disposition: inline
In-Reply-To: <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111111>

On Mon, Feb 23, 2009 at 08:09:03AM +0100, Ferry Huberts (Pelagic) wrote:

> > But won't that now import CRLF's into your new git repo? Especially on
> > Windows, where (IIRC) cvs gives you files with CRLF by default?
> 
> Yes it would. But sadly that's the only way to make sure that the import
> will work (without serious manual intervention).
> I found this out the hard way.

Wouldn't setting autocrlf=true, safecrlf=true do the import you want?
Then you could reset autocrlf to input after import but before checkout
time.

-Peff
