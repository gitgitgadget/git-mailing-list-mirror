From: Jan Hudec <bulb@ucw.cz>
Subject: Re: testing vger handling of charsets (part 2)
Date: Wed, 16 May 2007 11:29:15 +0200
Message-ID: <20070516092915.GA10660@artax.karlin.mff.cuni.cz>
References: <20070515test.2@coredump.intra.peff.net> <7vmz05ffad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, kha@treskal.com,
	bfields@fieldses.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 11:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoFpE-0007YM-R2
	for gcvg-git@gmane.org; Wed, 16 May 2007 11:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760548AbXEPJ3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 05:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760466AbXEPJ3R
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 05:29:17 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38471 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760281AbXEPJ3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 05:29:16 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 94F354CE6; Wed, 16 May 2007 11:29:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmz05ffad.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47429>

On Tue, May 15, 2007 at 11:34:02PM -0700, Junio C Hamano wrote:
> botched one:
> 
> 	outgoing:
>         	body in utf-8
>         	Content-type: text/plain; charset=utf-8
>                 no MIME-Version: header
> 
> 	vger relayed to recipients:
>         	body untouched
>                 Content-type: text/plain; charset=iso-8859-1
>                 MIME-Version: 1.0

The strange thing is, that I got it from vger -- with 
Content-type: text/plain; charset=utf-8

Therefore either:
 - It's not vger, but some other mail software, that munges it.
 - Some software on my side correctly guesses that it should have been
   utf-8, but I don't really believe that.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
