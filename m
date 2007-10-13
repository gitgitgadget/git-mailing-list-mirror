From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 14:49:57 +0200
Message-ID: <20071013124957.GZ31659@planck.djpig.de>
References: <471045DA.5050902@gmail.com> <20071013081205.GB27533@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 13 14:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IggRi-0002MG-5D
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 14:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbXJMMuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 08:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbXJMMuK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 08:50:10 -0400
Received: from planck.djpig.de ([85.10.192.180]:3883 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbXJMMuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 08:50:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 67EB288231;
	Sat, 13 Oct 2007 14:50:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rlyd69m0hp06; Sat, 13 Oct 2007 14:49:57 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E070188232; Sat, 13 Oct 2007 14:49:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071013081205.GB27533@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 13, 2007 at 04:12:06AM -0400, Jeff King wrote:
> > +if ($color_config=~"true" || -t STDOUT && $color_config=~"auto") {
> 
> Shouldn't these just be 'eq' instead of a regex?

What would mean you have to chomp it first. But it should at least
be written as =~ /.../ to make it clear that using a regex was a
concious decision here and not an accident.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
