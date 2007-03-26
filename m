From: Nicolas Pitre <nico@cam.org>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 14:15:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703261414130.3041@xanadu.home>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
 <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org>
 <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com>
 <alpine.LFD.0.83.0703261015110.3041@xanadu.home>
 <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:16:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVtju-0001oF-P4
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbXCZSQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbXCZSQP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:16:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38898 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXCZSQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:16:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFI000YOW2H6AG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Mar 2007 14:15:54 -0400 (EDT)
In-reply-to: <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43170>

On Mon, 26 Mar 2007, Marco Costalba wrote:

> On 3/26/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 26 Mar 2007, Marco Costalba wrote:
> > 
> > > Experimenting with file names cache in qgit I have found a big saving
> > > splitting the paths in base name and file name and indexing both:
> > >
> > > drivers\usb\host\ehci.h
> > > drivers\usb\host\ehci-pci.c
> > > drivers\usb\host\ohci-pci.c
> > > kernel\sched.c
> > >
> > > became:
> > >
> > > dir names table
> > >
> > > 0 drivers\usb\host
> > > 1 kernel
> > >
> > >
> > > file name table
> > >
> > > 0 ehci.h
> > > 1 ehci-pci.c
> > > 2 ohci-pci.c
> > >
> > > In this way a big saving is achieved in case of directories deep in
> > > the tree (long paths) and a lot of files.
> > 
> > Sure, but if you also consider drivers/usb/Makefile and drivers/Kconfig
                     ^^^^

> In your example you'd have:
> 
> drivers/usb/Makefile
> drivers/Kconfig

No.  "also" was the key word here.


Nicolas
