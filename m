From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 08 Feb 2007 14:49:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702081447050.13009@xanadu.home>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <8aa486160702072325q1d63c5d2mc1c6a492392802c6@mail.gmail.com>
 <Pine.LNX.4.63.0702082022200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFI5-0000cw-0F
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423285AbXBHTt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423299AbXBHTt0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:49:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41653 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423285AbXBHTtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:49:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD500AJXTQB5CK0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Feb 2007 14:49:24 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702082022200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39080>

On Thu, 8 Feb 2007, Johannes Schindelin wrote:

> But if you _have_ to have it, see attached patch. I will not push for it 
> in time for 1.5.0, though, since I have a track record of not getting 
> patches right on the first try.

Well.... to that effect I'd suggest you use dwim_log() instead.
Otherwise it'll break the HEAD reflog.


Nicolas
