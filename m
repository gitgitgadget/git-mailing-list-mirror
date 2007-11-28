From: Nicolas Pitre <nico@cam.org>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 09:53:29 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxOIR-0001jc-VG
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXK1Oxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbXK1Oxb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:53:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14671 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbXK1Oxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:53:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS8000PK1D5FIA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 09:53:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66349>

On Tue, 27 Nov 2007, Jon Smirl wrote:

> Of course you've never screwed up a repository using git commands,
> right? I've messed up plenty. A good way to mess up a repo is to get
> the data in .git/* out of sync with what is in the repo. I'm getting
> good enough with git that I can fix most mess up with a few edits, but
> it took me two years to get to that point. Rolling back to a check
> point is way easier. User error and a command failing are both equally
> valid ways to mess up a repo.

The reflog contains all your check points, for every modifications you 
make, even the stupid ones.  You should look at it.


Nicolas
