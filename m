From: Nicolas Pitre <nico@cam.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 11:03:35 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711091102370.21255@xanadu.home>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
 <473464A2.7080003@op5.se>
 <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
 <47347E0E.1040205@viscovery.net>
 <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWKt-0005Bb-R3
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbXKIQDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbXKIQDi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:03:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63675 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbXKIQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:03:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR8004O7XY0UBF0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Nov 2007 11:03:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64207>

On Fri, 9 Nov 2007, Yossi Leybovich wrote:

> On Nov 9, 2007 10:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Yossi Leybovich schrieb:
> > > [about corrupt loose object '4b9458b3786228369c63936db65827de3cc06200']
> >
> > You can try to create a clone (after you have fixed up the artificial
> > breakages that you made). If that goes well, then the bad object is
> > referenced only from reflogs.
> >
> 
> 
> git clone ib ib-clone
> Initialized empty Git repository in /home/mellanox/work/symm/ib-clone/.git/
> 0 blocks

Please try "file://ib" instead.  Otherwise the clone will only hardlink 
files to the original repository.


Nicolas
