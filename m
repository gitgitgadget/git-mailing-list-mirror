From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 16:02:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812181600210.30035@xanadu.home>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pickens, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQ2K-0004Wv-RD
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbYLRVCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYLRVCm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:02:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54787 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYLRVCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:02:42 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KC3007TSBRL1KC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Dec 2008 16:02:09 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103492>

On Thu, 18 Dec 2008, Pickens, James E wrote:

>                    NFS->NFS    NFS->Local
> master (53682f0c)    2:46.1          13.3
> with threads           36.6          18.2
> 
> So it improved performance on NFS significantly.

Are those figures repeatable over multiple consecutive runs?


Nicolas
