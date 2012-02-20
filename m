From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 20:06:46 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1202202002330.28090@tvnag.unkk.fr>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org> <20120220010617.GB4140@sigill.intra.peff.net> <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org> <20120220135639.GA5131@sigill.intra.peff.net> <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
 <20120220154452.GA27456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:20:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYmh-0007wp-7e
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab2BTTUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:20:23 -0500
Received: from giant.haxx.se ([80.67.6.50]:49041 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab2BTTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:20:22 -0500
X-Greylist: delayed 801 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2012 14:20:21 EST
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q1KJ6kpS015570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Feb 2012 20:06:46 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q1KJ6keV015560;
	Mon, 20 Feb 2012 20:06:46 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20120220154452.GA27456@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191087>

On Mon, 20 Feb 2012, Jeff King wrote:

>  3. Open a browser and say "Ah, I see. A captive portal".
>
> We should already be doing that. Adding more support could make step 3 a 
> little nicer, but like I said, I'd be more interested in seeing a real case 
> first. It may even be a feature that would be more appropriate to curl 
> (which git builds on for http access).

We're already discussing the 511 in the curl camp as well, but with even more 
sighs and hands in the air. 511 is clearly intended for HTML-understanding 
user agents and curl is not one of those. IMHO, curl will remain to simply 
help users to figure out that it is 511 and leave it at that.

As a git user, I would probably be very surprised if using 'git' suddenly 
caused by browser to pop up a captive portal login. I would prefer git to 
instead properly explain to me that is being the victim of a 511 and what I 
should do to fix it.

-- 

  / daniel.haxx.se
