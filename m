From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 17:45:28 +0200
Organization: <)><
Message-ID: <20140423154528.GB2291@camelia.ucw.cz>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info> <20140417215817.GA822@sigill.intra.peff.net> <20140423075325.GA7268@camelia.ucw.cz> <alpine.DEB.1.00.1404231627590.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 17:45:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WczMg-0002sh-Db
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 17:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbaDWPpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 11:45:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55214 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbaDWPpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 11:45:31 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id B45E91C00D6;
	Wed, 23 Apr 2014 17:45:29 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3NFjTpA002313;
	Wed, 23 Apr 2014 17:45:29 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3NFjSRr002312;
	Wed, 23 Apr 2014 17:45:28 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1404231627590.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246847>

Hello,

On Wed, Apr 23, 2014 at 04:28:39PM +0200, Johannes Schindelin wrote:
> The interdiff can be seen here:
> 	https://github.com/msysgit/git/commit/c68e27d5

not exatly, is also changes the number of commits in the "deep repo"
from 1000 to 4000, as peff proposed.

Stepan
