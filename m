From: Nicolas Pitre <nico@cam.org>
Subject: Re: error: packfile while git fsck
Date: Wed, 22 Oct 2008 10:52:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810221049340.26244@xanadu.home>
References: <48FF337F.3050505@atmel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 16:54:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksf5m-0000lY-HK
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 16:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYJVOwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 10:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbYJVOwX
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 10:52:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55043 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbYJVOwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 10:52:22 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9500E65AM27X70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Oct 2008 10:51:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <48FF337F.3050505@atmel.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98872>

On Wed, 22 Oct 2008, Nicolas Ferre wrote:

> Hi all,
> (please cc me on response)
> 
> I am facing error during git status & git fsck on my tree.
> This tree is cloned from various linux kernel trees.
> 
> Here are a sample of the error I see :
> 
> $ git fsck
> error: packfile
> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not
> match index
> error: packfile
> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be
> accessed
[...]

What git version?

> Did I do something wrong (merging files while fetching) ?

Unlikely.


Nicolas
