From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 20:40:57 -0400
Message-ID: <1334018233-sup-7389@pinkfloyd.chass.utoronto.ca>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org> <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca> <7vwr5os9zr.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHP8p-00078a-L3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074Ab2DJAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 20:40:59 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:56406 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab2DJAk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 20:40:58 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49324 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHP8j-0003iu-83; Mon, 09 Apr 2012 20:40:57 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHP8j-0003Ct-6w; Mon, 09 Apr 2012 20:40:57 -0400
In-reply-to: <7vwr5os9zr.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195052>

Excerpts from Junio C Hamano's message of Mon Apr 09 20:31:36 -0400 2012:

> > For some reason, I thought that using {x,y} range notation wasn't
> > valid in this scenario, but I think I was mistaken.  It seems to be
> > widely used elsewhere throughout the code.
> 
> Where?  Only two test scripts seem to use it and worse yet, one of them
> uses it doubly incorrectly.

I guess widely wasn't a good choice...My search wasn't narrow enough
earlier.  Was I correct in my original thinking that the range
notation isn't to be used then?

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
