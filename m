From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git exhausts memory.
Date: Sat, 02 Apr 2011 11:05:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alif Wahid <alif.wahid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 17:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q62OX-00016f-6D
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 17:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab1DBPFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 11:05:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33183 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1DBPFj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 11:05:39 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ100HY65XEQI20@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 02 Apr 2011 11:05:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170650>

On Sat, 2 Apr 2011, Alif Wahid wrote:

> Hi there,
> 
> I'm using Git v1.7.1 on Ubuntu v10.10 and unfortunately Git seems to
> regularly exhaust the memory on my machine and fails to compress loose
> objects and/or collect garbage.
> 
> My Intel based dual-core machine has 2 GB of RAM and 4 GB of swap
> space. I need to track a working tree with a handful of really large
> tarballs that rarely change and loads of really small text files that
> change frequently. What I'm seeing is that over time whenever "git gc"
> runs automatically it fails with the message "fatal: Out of memory,
> malloc failed". So I've been trying to manually run "git repack -ad
> --window-memory=1g --max-pack-size=1g" in the hope that Git will not
> exceed the physical memory. But I still get the same error message :(

Don't use --max-pack-size.  That won't help here.

How large are those tar files?


Nicolas
