From: Nicolas Pitre <nico@cam.org>
Subject: Re: git fsck segmentation fault
Date: Thu, 27 Nov 2008 12:47:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811271243250.14328@xanadu.home>
References: <200811271814.06941.simon@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 18:49:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5kzZ-0000rz-WA
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 18:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYK0Rrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 12:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYK0Rrx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 12:47:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23098 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbYK0Rrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 12:47:52 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KB0009QJ6QBLKE0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 27 Nov 2008 12:46:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200811271814.06941.simon@lst.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101819>

On Thu, 27 Nov 2008, Simon Hausmann wrote:

> Hi,
> 
> when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a medium sized

That version doesn't exist in the git repo.

> (930M) repository I get a segfault.
> 
> The backtrace indicates an infinite recursion. Here's the output from the last
> few lines:
[...]

Could you try with latest master branch please?  It is more robust 
against some kind of pack corruptions that could send the code into 
infinite loops.


Nicolas
