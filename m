From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] cvsimport-in-Perl: Limit the number of arguments to
 git-update-cache
Date: Thu, 30 Jun 2005 13:15:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506301314280.1667@localhost.localdomain>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
 <pan.2005.06.30.10.34.00.807346@smurf.noris.de>
 <Pine.LNX.4.63.0506301249550.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 19:10:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do2Xb-0007OC-9c
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 19:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVF3RQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVF3RQr
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 13:16:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7293 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262841AbVF3RQb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 13:16:31 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR001.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIW00ENNQLEEM@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2005 13:15:14 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0506301249550.1667@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Nicolas Pitre wrote:

> On Thu, 30 Jun 2005, Matthias Urlichs wrote:
> 
> > A small fix to git-cvsimport-script:
> > 
> > Limit the number of arguments to git-update-cache.
> > (Limiting their length may make a bit more sense, but I'm lazy.)
> 
> Why not using:
> 
> 	write( "| xargs | git-update-cache --add --", @new)

That example should be:

	write( "| xargs git-update-cache --add --", @new)

of course.


Nicolas
