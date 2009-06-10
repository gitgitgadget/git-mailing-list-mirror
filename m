From: Nicolas Pitre <nico@cam.org>
Subject: Re: branch management
Date: Wed, 10 Jun 2009 11:28:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906101118070.31536@xanadu.home>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
 <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp>
 <7viqj5nzgz.fsf@alter.siamese.dyndns.org>
 <20090609172302.GH9993@laphroaig.corp>
 <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
 <20090609195018.GA17848@blimp.localdomain>
 <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
 <m3d49c40ai.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Harry Duin <hduin@optionshouse.com>,
	'Alex Riesen' <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEPjv-0007JH-IL
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 17:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759103AbZFJP2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759200AbZFJP2o
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 11:28:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39584 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707AbZFJP2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 11:28:43 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KL1008UQ3SWFWQ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Jun 2009 11:17:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3d49c40ai.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121283>

On Wed, 10 Jun 2009, Jakub Narebski wrote:

> Harry Duin <hduin@optionshouse.com> writes:
> 
> > 2. show list of files/directories touched by a branch (useful when
> >    looking for past fixes, but are unsure where the fix was done)
> 
> If you can use pickaxe search (git log -S...), or git-blame, or just
> looking throught "git log ... -- <path>", you can use
> 
> $ git rev-list master..branch | 
>   git diff-tree --stdin -r --name-only |
>   sort -u

What I use in that case is simply

	git diff --stat master...branch


Nicolas
