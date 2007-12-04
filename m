From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 13:44:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041343040.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 14:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzY4t-0002b9-Lc
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 14:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbXLDNo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 08:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXLDNo1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 08:44:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751356AbXLDNo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 08:44:27 -0500
Received: (qmail invoked by alias); 04 Dec 2007 13:44:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 04 Dec 2007 14:44:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VpztsrHOVE4wfd2SYqzaqbqJKSe22Rhm7kzKLJB
	Zi5+Hn68/Jn/4w
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204130922.731c407a@pc09.procura.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67045>

Hi,

On Tue, 4 Dec 2007, H.Merijn Brand wrote:

> make test then fails:

Could you run the failing test manually with -i -v, like so:

	$ cd t/
	$ sh t0001*.sh -i -v

Thanks,
Dscho
