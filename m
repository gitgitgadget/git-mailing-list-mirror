From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 10:48:08 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711191044500.19105@xanadu.home>
References: <1195477504.8093.15.camel@localhost>
 <20071119150209.GF6212@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jonas Juselius <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:48:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu8rX-0004BR-R3
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 16:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbXKSPsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 10:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbXKSPsT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 10:48:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63898 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbXKSPsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 10:48:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRR004E8FW81YQ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 10:48:09 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071119150209.GF6212@lavos.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65456>

On Mon, 19 Nov 2007, Brian Downing wrote:

> On Mon, Nov 19, 2007 at 02:05:04PM +0100, Jonas Juselius wrote:
> > I have also written a CVS2git transition guide, which outlines one
> > possible way of converting from CVS to git.
> 
> You write:
> 
> > In order to save space you can also enable compression
> > $ git config --global core.compression 1
> > $ git config --global core.loosecompression 1
> 
> I think this contradicts the git-config manpage:

Also, compression is always enabled by default with the adequate setting 
for most usages anyway, so I think it is probably best not to talk about 
those settings at all in a nutshell guide.


Nicolas
