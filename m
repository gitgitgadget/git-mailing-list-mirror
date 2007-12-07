From: Nicolas Pitre <nico@cam.org>
Subject: Re: multi-threaded git-index-pack
Date: Thu, 06 Dec 2007 22:45:51 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712062241510.555@xanadu.home>
References: <9e4733910712061932p712b9f00k49677a0db4afee8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 04:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0UAH-00048Y-I7
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXLGDpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbXLGDpw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:45:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32886 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbXLGDpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 22:45:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSN008QVUGEQCH0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 22:45:50 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712061932p712b9f00k49677a0db4afee8d@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67374>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> I'm cloning the gcc repo. My clone has been sitting in git-index-pack
> for about 10 minutes and it is only using one core. Is this something
> could be multi-threaded?

I've done the same and had the same thought, although it seemed shorter 
than 10 minutes to me.

Yes, most of it can be made multi-thread as well.


Nicolas
