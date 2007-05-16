From: Jeff King <peff@peff.net>
Subject: Re: testing vger handling of charsets (part 2)
Date: Wed, 16 May 2007 06:57:01 -0400
Message-ID: <20070516105700.GB30256@coredump.intra.peff.net>
References: <20070515test.2@coredump.intra.peff.net> <7vmz05ffad.fsf@assigned-by-dhcp.cox.net> <20070516092915.GA10660@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	kha@treskal.com, bfields@fieldses.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 12:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHCH-0006oT-7K
	for gcvg-git@gmane.org; Wed, 16 May 2007 12:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbXEPK5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 06:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758213AbXEPK5G
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 06:57:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2635 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530AbXEPK5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 06:57:05 -0400
Received: (qmail 13892 invoked from network); 16 May 2007 10:57:03 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 May 2007 10:57:03 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2007 06:57:01 -0400
Content-Disposition: inline
In-Reply-To: <20070516092915.GA10660@artax.karlin.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47432>

On Wed, May 16, 2007 at 11:29:15AM +0200, Jan Hudec wrote:

> The strange thing is, that I got it from vger -- with 
> Content-type: text/plain; charset=utf-8
> 
> Therefore either:
>  - It's not vger, but some other mail software, that munges it.
>  - Some software on my side correctly guesses that it should have been
>    utf-8, but I don't really believe that.

It's option 3:
  - vger selectively munges based on whether your server claims 8BITMIME
    during the SMTP EHLO. So some list members never saw this issue at
    all.

-Peff
