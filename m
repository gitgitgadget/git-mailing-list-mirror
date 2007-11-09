From: Nicolas Pitre <nico@cam.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 09 Nov 2007 11:11:03 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711091103540.21255@xanadu.home>
References: <6C571F0D-442F-49B9-8CF8-D7DACB41FC1A@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWS1-0008HC-Vg
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbXKIQLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXKIQLG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:11:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16077 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbXKIQLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:11:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR8004FZYAGAP80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Nov 2007 11:11:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <6C571F0D-442F-49B9-8CF8-D7DACB41FC1A@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64208>

On Fri, 9 Nov 2007, bob wrote:

> Sorry, but I am not that familiar with git's internal workings,
> but here is a failure that I can consistently create.  I am
> running MacOSX 10.4.10 with git compiled from source.
> Here is the problem output that I am receiving:
> 
> remote: Generating pack...
> remote: Done counting 11402 objects.
> remote: Deltifying 11402 objects...
> remote:  100% (11402/11402) done
> Indexing 11402 objects...
> 100% (11402/11402) done
> Resolving 3356 deltas...
> fatal: serious inflate inconsistency

A similar problem (if not the same problem) has been reported on MacOSX 
in the past.  The conclusion was that either the gcc version or zlib 
version on MacOSX was bad and updating them fixed it.  I don't remember 
the details now but you should be able to find them in the mail archive 
(or maybe someone else remembers).


Nicolas
