From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Thu, 6 Dec 2007 00:52:00 -0500
Message-ID: <20071206055200.GA23309@coredump.intra.peff.net>
References: <20071203043258.GA16658@coredump.intra.peff.net> <Pine.LNX.4.64.0712031052410.27959@racer.site> <20071203173022.GA19219@coredump.intra.peff.net> <7vbq97iqxd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09eu-0006aA-RQ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbXLFFwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXLFFwH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:52:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1597 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXLFFwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:52:05 -0500
Received: (qmail 28096 invoked by uid 111); 6 Dec 2007 05:52:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 00:52:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 00:52:00 -0500
Content-Disposition: inline
In-Reply-To: <7vbq97iqxd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67246>

On Mon, Dec 03, 2007 at 10:17:18AM -0800, Junio C Hamano wrote:

> So in short:
> 
>  * I do not think extending it to mean a set of commits (with some
>    definition of how the set is computed) is a good idea.  It can stay
>    "name one commit that matches this string" without losing usefulness,
>    and I think it should;
> 
>  * The definition of the "match" can be tweaked and introducing regexp
>    might be a good way;
> 
>  * The definition of the "match" may become more useful if we can limit
>    which refs to dig from.

Obviously the overall design and usage of :/ is going to take some
thinking and is not 1.5.4 material. However, we do have it in its
current form, and I think regex versus prefix string matching is
orthogonal to the range issues. Should I post my rebased :/ regex patch,
or do you want to just leave it for post-1.5.4?

-Peff
