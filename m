From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Fri, 09 Apr 2010 15:25:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004091518500.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com>
 <alpine.LFD.2.00.1004070842580.7232@xanadu.home> <4BBECE44.4040608@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JpZ-0007Tp-BY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab0DITZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:25:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23730 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0DITZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:25:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0M00033JA9JV00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Apr 2010 15:25:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBECE44.4040608@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144461>

On Fri, 9 Apr 2010, Vitaly Berov wrote:

> > OK then.  What happens if you do the following on the server machine
> > where the repository is stored:
> > 
> > 	git repack -a -f -d
> > 
> > How long does this take?
> 
> So, the results: it took 37 hours. 20 hours is compressing objects (delta
> compression using up to 4 threads), 17 hours is writing objects. Almost all of
> the time the bottleneck was a CPU.
> 
> Objects amount: 3997548.
> Size of the repository: ~57Gb.

OK.  You probably have a size record.  :-)

How big is the .pack file in .git/objects/pack/ ?

> By the way, we have a large amount of binary files in our rep.

How many?  How big?


Nicolas
