From: Nicolas Pitre <nico@cam.org>
Subject: Re: Any way to ignore a change to a tracked file when
 committing/merging?
Date: Wed, 13 Jun 2007 14:19:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706131417320.1697@xanadu.home>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
 <alpine.LFD.0.99.0706131318390.21061@xanadu.home>
 <477C424C-009F-46BF-85D4-A0D777FE3CEC@mimvista.com>
 <alpine.LFD.0.99.0706131349430.1697@xanadu.home>
 <6D50717E-7FB2-48EE-9B56-42B658ACAD10@mimvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyYcK-0007KB-2w
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 21:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760551AbXFMTaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 15:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760434AbXFMTap
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 15:30:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12377 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760254AbXFMTao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 15:30:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJL009806WDDJ11@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Jun 2007 14:19:25 -0400 (EDT)
In-reply-to: <6D50717E-7FB2-48EE-9B56-42B658ACAD10@mimvista.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50119>

On Wed, 13 Jun 2007, David Watson wrote:

> It appears that only applies to untracked files. I am specifically interested
> in ignoring changes to files that are already tracked, unless I'm
> misunderstanding what you're suggesting. I just built the most recent git from
> repo.or.cz/git, and did the following:
> 
> * edit the file I want to "ignore"
> git-status shows this file as modified
> 
> * edit .git/config, set core.excludesfile to myexcludes, containing the name
> of the file I want
> * git add -u
> * git-status
> shows the file I edited as ready to be committed.

I suppose that the behavior of git-add could be modified to honnor the 
exclude pattern even for already tracked files.  Such change would make 
sense to me.


Nicolas
