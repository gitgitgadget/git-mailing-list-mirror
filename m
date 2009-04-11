From: Nicolas Pitre <nico@cam.org>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 22:03:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102159000.6741@xanadu.home>
References: <loom.20090410T084314-918@post.gmane.org>
 <fabb9a1e0904100330u61a7e252he546f0edc4e016a7@mail.gmail.com>
 <49DF294E.7010407@hepe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Aaron Digulla <digulla@hepe.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 04:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsSba-0003eZ-S0
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 04:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbZDKCEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 22:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbZDKCEH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 22:04:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44508 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbZDKCEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 22:04:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHW00054Z2MGF30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Apr 2009 22:03:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49DF294E.7010407@hepe.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116290>

On Fri, 10 Apr 2009, Aaron Digulla wrote:

> Sverre Rabbelier wrote:
> 
> > > I need a way to safely synchronize data between several places using an
> > > unsafe
> > > storage (USB stick, Internet drive). So my question is: How much work
> > > would it
> > > be to patch GIT to encrypt all files in the repository using AES-256?
> > 
> > Encrypt the entire drive flash drive [0], and then use git like
> > normal, 0 changes required ;). You can also create an encrypted file,
> > and then use git like normal, also 0 changes required!
> 
> How do I encrypt an Internet drive (like Dropbox)? Also, if possible, I'd like
> not to have to install any software on the local computer (well, besides git,
> obviously).

You can create git bundles, which is a way to synchronize repositories 
without using a direct network connection.  A bundle is simply a single 
file with the needed data to perform repository updates.

So you could use bundles, and encrypt them with the encryption tool of 
your choice before storing them on a USB stick for example.


Nicolas
