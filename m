From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 12:21:59 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702221219370.27932@xanadu.home>
References: <alpine.LRH.0.82.0702212224510.31945@xanadu.home>
 <Pine.LNX.4.63.0702221654131.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221117080.27932@xanadu.home>
 <Pine.LNX.4.63.0702221811130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 18:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKHdt-0000uL-LL
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 18:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbXBVRWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 12:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXBVRWB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 12:22:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39567 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXBVRWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 12:22:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDV00JIXK8NPIO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Feb 2007 12:21:59 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702221811130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40363>

On Thu, 22 Feb 2007, Johannes Schindelin wrote:

> On Thu, 22 Feb 2007, Nicolas Pitre wrote:
> 
> > Could you please make the test, including the call to fstat(), 
> > conditional on !from_stdin instead?
> 
> How about using Simon's idea instead (subtracting input_len)?

Yes it would work.


Nicolas
