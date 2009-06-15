From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 22:43:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906142239120.16467@xanadu.home>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
 <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Alfred M. Szmidt" <ams@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 15 04:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG2B3-0007a1-KZ
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 04:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbZFOCn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 22:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZFOCn7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 22:43:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43671 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbZFOCn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 22:43:58 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KL9003MKE98ITE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Jun 2009 22:43:56 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121574>

On Sun, 14 Jun 2009, Johannes Schindelin wrote:

> Hi,
> 
> Disclaimer: if you are offended by constructive criticism, or likely to
> answer with insults to the comments I offer, please stop reading this mail
> now (and please do not answer my mail, either). :-)
> 
> Still with me?  Good.  Nice to meet you.
> 
> Just for the record: responding to a patch is my strongest way of saying
> that I appreciate your work.
> 
> On Sun, 14 Jun 2009, Alfred M. Szmidt wrote:
> 
> > This small patch fixes things so that repack, fsck, and other things
> > work on >2GiB files.  There are still some other problems (cloning
> > over ssh being one), but this makes it atleast possible to handle such
> > files.
> > 
> > (not subscribed, please CC)
> 
> This is almost perfect, but please add a Signed-off-by: line.
> 
> Oh, and maybe add a test like t/t5705-clone-2gb.sh?

Creating test for files >= 2GB is kinda hard.  It'll be really slow and 
take a lot of disk space, and I doubt people will be happy about that.

Been there.  That's the only reason why I created the --index-version 
argument to pack-objects: to fake behavior for huge files by the test 
suite.


Nicolas
