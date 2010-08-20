From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 16:59:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008201327120.622@xanadu.home>
References: <4C6E46A4.8050502@kinet.ch> <20100820125119.GA9762@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Jampen <jampen@kinet.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 23:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmYh7-0001Dx-Aw
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 23:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0HTVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 17:00:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41854 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0HTU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 16:59:59 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L7G00BPQYBY1S50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Aug 2010 16:59:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100820125119.GA9762@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154081>

On Fri, 20 Aug 2010, Jonathan Nieder wrote:

> (+cc: Nicolas, who knows the packing code pretty well)
> 
> Hi,
> 
> Thomas Jampen wrote:
> 
> > I'm experiencing the following error while pushing a git repo (home
> > directory) to my QNAP TS-210:
> > 
> > user@mypc:~$ git push origin master
> > Counting objects: 12532, done.
> > Delta compression using up to 2 threads.
> > Compressing objects: 100% (8974/8974), done.
> > fatal: Out of memory, malloc failed, 986.06 MiB | 1.65 MiB/s
> > error: pack-objects died of signal 13

How much memory is there on the machine where the pushed data is going?


Nicolas
