From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix git-fast-export for zero-sized blobs
Date: Tue, 11 Dec 2007 17:20:38 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111719380.555@xanadu.home>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
 <20071211220128.GA19857@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DTX-0004DS-Fu
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbXLKWUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXLKWUk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:20:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48285 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408AbXLKWUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:20:38 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW007TTOQE8TE1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 17:20:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071211220128.GA19857@steel.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67957>

On Tue, 11 Dec 2007, Alex Riesen wrote:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  builtin-fast-export.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Nicolas Pitre, Tue, Dec 11, 2007 21:27:33 +0100:
> > Simply doing something like:
> > 
> > $ git fast-export --all > /dev/null
> > 
> > results in:
> > 
> > fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> > 
> 
> I get this for my git repo:
> 
> 	$ git fast-export --all >/dev/null
> 	fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 	$ git cat-file blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 |wc -c
> 	0
> 
> Writing a zero-size blob will surely returns 0.

Indeed.


/me looking at too many piece of code at the same time


Nicolas
