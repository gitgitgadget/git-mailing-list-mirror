From: Nicolas Pitre <nico@cam.org>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 10:58:28 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801161056500.25841@xanadu.home>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
 <m37ii9nagt.fsf@roke.D-201>
 <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com>
 <200801161520.44668.jnareb@gmail.com>
 <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
 <alpine.LFD.1.00.0801160958170.25841@xanadu.home>
 <alpine.DEB.1.00.0801161715570.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFAfN-00043U-5p
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 16:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYAPP6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYAPP6c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 10:58:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24507 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYAPP6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 10:58:31 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUQ00E14V1GJ0D0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jan 2008 10:58:28 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0801161715570.5260@bender.nucleusys.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70693>

On Wed, 16 Jan 2008, Petko Manolov wrote:

> On Wed, 16 Jan 2008, Nicolas Pitre wrote:
> 
> > On Wed, 16 Jan 2008, Petko Manolov wrote:
> > 
> > > On Wed, 16 Jan 2008, Jakub Narebski wrote:
> > > 
> > > > Petko Manolov wrote:
> > > > > 
> > > > > Unfortunately this is not the case.  These binary blobs are already
> > > > > compressed and/or encrypted and adding even a few bytes ends up
> > > > > storing
> > > > > new version in full size.
> > > > 
> > > > Can't you store them uncompressed?
> > > 
> > > Not really, but i can convert them into ascii format and store only the
> > > delta.
> > 
> > If you don't have the original uncompressed unencrypted file, what will
> > converting them to ascii actually give you?
> 
> I hope that in the case of incremental changes (0 to 5MB file is the same,
> last 64KB are actually new) the delta will be small and should be able to
> compress well.
> 
> This won't work for random changes along the length of the whole file.

But my question remains.

If you cannot create good deltas out of your binary files, converting 
those binaries into ascii will do nothing to compression performance.


Nicolas
