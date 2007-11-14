From: Nicolas Pitre <nico@cam.org>
Subject: Re: git 1.5.3.5 error over NFS
Date: Tue, 13 Nov 2007 20:38:35 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711132030370.21255@xanadu.home>
References: <18228.32091.865519.312011@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is7DQ-0002te-8b
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbXKNBih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbXKNBih
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:38:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbXKNBig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:38:36 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRH006AO38BHBU0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Nov 2007 20:38:35 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <18228.32091.865519.312011@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64942>

On Fri, 9 Nov 2007, Bill Lear wrote:

> I've brought this up before, but I don't recall a resolution to it.
> 
> We have an NFS-mounted filesystem, and git pull is choking on it.
> 
> % uname -a
> Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux

I recall there was issues with NFS on some old linux version posted on 
the list a while ago.  Again the archive must have it but I'm too lazy 
to check.  Because the issue wasn't reproducible on later kernels, the 
conclusion was that the kernel was to blame.


Nicolas
