From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: unexpected git-cherry-pick conflict
Date: Sat, 7 Jul 2007 21:58:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071949440.4093@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 23:05:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7HT2-00040n-39
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbXGGVFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXGGVFW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 17:05:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:35639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbXGGVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 17:05:21 -0400
Received: (qmail invoked by alias); 07 Jul 2007 21:05:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 07 Jul 2007 23:05:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yzuFeejYy0t6UKmxjQDdJbGMFedYzdM89+LepHY
	f75pZ1Kt8tFwYS
X-X-Sender: gene099@racer.site
In-Reply-To: <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51846>

Hi,

On Mon, 25 Jun 2007, Gerrit Pape wrote:

> Hi, did you get to this yet?, not to stress you, just to make sure we 
> don't forget about it.

Okay. Since now both you and Junio asked for it, and I made today a Git 
day for me, I looked into this.

I'm not yet done, but preliminary results are: 

- cherry-pick calls merge-recursive, which in turn calls unpack_trees(), 
  which in turn gives the ball to threeway_merge. But for d/f conflicts, 
  it goes wrong.

- Documentation/technical/trivial-merge.txt is maybe about a trivial 
  merge. But the document is not trivial in and of itself.

I'll keep going,
Dscho
