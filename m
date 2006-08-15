From: Jeff King <peff@peff.net>
Subject: Re: 2 build issues
Date: Tue, 15 Aug 2006 02:10:56 -0400
Message-ID: <20060815061056.GB4543@coredump.intra.peff.net>
References: <20060814121156.84bc6e34.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 08:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCs96-0005ac-I9
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 08:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWHOGLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 02:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWHOGLA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 02:11:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:63889 "HELO
	peff.net") by vger.kernel.org with SMTP id S965194AbWHOGK7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 02:10:59 -0400
Received: (qmail 19244 invoked from network); 15 Aug 2006 02:10:26 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Aug 2006 02:10:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2006 02:10:56 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Content-Disposition: inline
In-Reply-To: <20060814121156.84bc6e34.rdunlap@xenotime.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25438>

On Mon, Aug 14, 2006 at 12:11:56PM -0700, Randy.Dunlap wrote:

> xmlto -m callouts.xsl man git-add.xml
> I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl

It looks like your docbook installation is broken. You should have an
xml catalog file that translates the url to a local file reference for
the docbook stylesheet. Can you verify the integrity of / reinstall your
docbook package?

-Peff
