From: Nicolas Pitre <nico@cam.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 11:17:33 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711091116470.21255@xanadu.home>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com>
 <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com>
 <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
 <20071109081035.GA2794@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yossi Leybovich <sleybo@mellanox.co.il>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWYI-0002R5-Sq
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbXKIQRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbXKIQRe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:17:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32049 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbXKIQRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:17:34 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR8002O8YLA0PG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Nov 2007 11:17:35 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071109081035.GA2794@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64210>

On Fri, 9 Nov 2007, Alex Riesen wrote:

> Yossi Leybovich, Fri, Nov 09, 2007 00:59:47 +0100:
> > I wonder if someone can help in this error
> > I tried to do git-gc and got error on corrupted object. 
> > 
> > I do the following:
> > 
> > $ git-gc
> > Generating pack...
> > Done counting 3037 objects.
> > Deltifying 3037 objects...
> > error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'
> 
> It is loose. Nothing uses it in this repository.

Very wrong.  Loose object != unreachable object.


Nicolas
