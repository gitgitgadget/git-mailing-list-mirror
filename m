From: Nicolas Pitre <nico@cam.org>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 23:35:04 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711102331270.21255@xanadu.home>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
 <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
 <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
 <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
 <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 05:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir4Xf-00033i-K3
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 05:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbXKKEfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 23:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXKKEfJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 23:35:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15851 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbXKKEfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 23:35:06 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRB00JSFREGUQD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Nov 2007 23:35:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64397>

On Sat, 10 Nov 2007, bob wrote:

> I will try a few things and see if I can get a script put together
> that generates the inflate problem.  The data that I am
> using is a backup of my original repository.  So, I can
> play all that I want.  But it would be a lot easier if I
> could just generate some files using dd or something.

Please see the patch I just posted to the list.  That should fix your 
problem.  I even included a small script to create a repository 
confirming the problem and allowing to test the fix.


Nicolas
