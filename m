From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 15:31:49 +0100
Message-ID: <20090728143149.GA3013@sirena.org.uk>
References: <200907280513.59374.elendil@planet.nl> <20090728142219.GA16168@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 16:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVnip-00072O-V5
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 16:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbZG1Obv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 10:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbZG1Obu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 10:31:50 -0400
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54401 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZG1Obu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 10:31:50 -0400
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1MVniX-0004Od-Se; Tue, 28 Jul 2009 15:31:49 +0100
Content-Disposition: inline
In-Reply-To: <20090728142219.GA16168@vidovic>
X-Cookie: Do you like "TENDER VITTLES"?
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124253>

On Tue, Jul 28, 2009 at 04:22:19PM +0200, Nicolas Sebrecht wrote:

> IMHO, a better way would be to ignore lines beginning with a defined
> level of quotes in the commit message (the "level" beeing the number of
> '>' or '> ' found at the beginning of a line. Something like

> 	--strip-quotes[=N]

> where N is the level of quoted lines to remove (if "=N" is
> not given, assume that the level is 1 and remove all the quotes).

> Comments?

That would help but it'll still carry over at least part of the
discussion that preceeds the patch (normally the person sending the
patch will say something as well as including the patch) and it won't
pick up things like the subject line without some manual fixing.
