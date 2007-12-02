From: Nicolas Pitre <nico@cam.org>
Subject: Re: git pack-objects input list
Date: Sat, 01 Dec 2007 21:23:19 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712012120060.9605@xanadu.home>
References: <20071201104502.GA1457@glandium.org>
 <alpine.LFD.0.9999.0712010933370.8458@woody.linux-foundation.org>
 <20071201223849.GA15110@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyeUh-00025A-Tq
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 03:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbXLBCXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 21:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbXLBCXU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 21:23:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54715 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbXLBCXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 21:23:20 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSE004ELHAVUYG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 01 Dec 2007 21:23:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071201223849.GA15110@glandium.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66747>

On Sat, 1 Dec 2007, Mike Hommey wrote:

> On Sat, Dec 01, 2007 at 09:49:00AM -0800, Linus Torvalds wrote:
> > Hope that clarified something.
> 
> Thanks, that helped me understand my observations when trying to pack
> with and without file names in pack-objects input on different kind of
> datasets, where some would be best packed with and others would be without.
> 
> I'll try to add some words about the pack-objects input format in the
> documentation. I don't know if it's worth adding information about the
> packing process itself in the manual page. Or maybe that should be added
> to a more technical document about git (a bit like "git for computer
> scientists")

Look at Documentation/technical/ for existing technically oriented 
documents.  The pack format and packing heuristics have documents of 
their own already.  If you feel like adding more documentation there 
please just go ahead.


Nicolas
