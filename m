From: Nicolas Pitre <nico@cam.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 15:34:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810151533090.26244@xanadu.home>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
 <20081015122621.a9674d75.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0810151531140.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqC9U-0002zX-0W
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbYJOTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYJOTeM
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:34:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28814 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYJOTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:34:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8S00C8ZP0TVJG1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Oct 2008 15:34:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0810151531140.26244@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98308>

On Wed, 15 Oct 2008, Nicolas Pitre wrote:

> On Wed, 15 Oct 2008, Andrew Morton wrote:
> 
> > I do
> > 
> > 	git-reset --hard HEAD
> > 	git-reset --hard linux-next
> > 	git-checkout linux-next
> > 
> > and get
> > 
> > error: Untracked working tree file 'Next/SHA1s' would be overwritten by merge.
> > y
> > 
> > grr.
> 
> What about simply:
> 
> 	git-checkout -f linux-next

Never mind -- you apparently did that already with success.


Nicolas
