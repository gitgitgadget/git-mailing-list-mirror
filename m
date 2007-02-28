From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/3] Rename --pretty=changelog to --pretty=gnucl,
 and fix a bug
Date: Tue, 27 Feb 2007 21:52:03 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 03:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMEvO-0003Pw-9j
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbXB1CwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXB1CwF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:52:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40276 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXB1CwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:52:04 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE500030JYRWV23@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 21:52:03 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40878>

On Wed, 28 Feb 2007, Johannes Schindelin wrote:

> It was pointed out that this format is rather specific. So, rename it
> to "gnucl".
[...]
> +	{ "gnucl",	1,	CMIT_FMT_CHANGELOG}

Shouldn't it be CMIT_FMT_GNUCL as well to be consistent?

This is nitpicking but I don't see why those GNU abominations should 
be assigned generic terms, even in this particular name space.


Nicolas
