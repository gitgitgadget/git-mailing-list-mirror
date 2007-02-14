From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 13:19:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702141318060.1757@xanadu.home>
References: <200702140909.28369.andyparkins@gmail.com>
 <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702141843190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkj0pqp5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702141901250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd54cpq0v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOjF-0000h2-5I
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbXBNSTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbXBNSTi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:19:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33462 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbXBNSTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:19:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDG00NMVTKM2B50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Feb 2007 13:19:34 -0500 (EST)
In-reply-to: <7vd54cpq0v.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39718>

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> That's slightly different.  I can ask "Do you have anything
> special in your $HOME/.gitconfig?"  Now I have to ask two
> questions (and I would not know if a particular distro compiled
> git to use /etc/git/default.config or /etc/gitconfig or whatever).

Why not simplifying the question to only:

	git config -l

then?


Nicolas
