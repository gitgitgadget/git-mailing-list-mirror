From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] cvsimport-in-Perl: Limit the number of arguments to
 git-update-cache
Date: Thu, 30 Jun 2005 12:54:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506301249550.1667@localhost.localdomain>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
 <pan.2005.06.30.10.34.00.807346@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:49:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do2Dd-00048r-5g
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVF3Q4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbVF3Q4D
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:56:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9044 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S263005AbVF3Qzt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 12:55:49 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIW00JH2PM8I4@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2005 12:54:08 -0400 (EDT)
In-reply-to: <pan.2005.06.30.10.34.00.807346@smurf.noris.de>
X-X-Sender: nico@localhost.localdomain
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Matthias Urlichs wrote:

> A small fix to git-cvsimport-script:
> 
> Limit the number of arguments to git-update-cache.
> (Limiting their length may make a bit more sense, but I'm lazy.)

Why not using:

	write( "| xargs | git-update-cache --add --", @new)

or the like (I forget what the exact perl incantation is).


Nicolas
