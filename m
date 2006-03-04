From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Fri, 03 Mar 2006 22:01:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603032158250.1859@localhost.localdomain>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
 <7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
 <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
 <7vfylzx7t3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 04:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFN1h-0000Xr-Bf
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 04:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWCDDBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 22:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWCDDBq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 22:01:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52933 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751699AbWCDDBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 22:01:45 -0500
Received: from xanadu.home ([66.131.142.204]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVL0039V1QLV270@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 03 Mar 2006 22:01:34 -0500 (EST)
In-reply-to: <7vfylzx7t3.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17167>

On Fri, 3 Mar 2006, Junio C Hamano wrote:

> 	In short, I'd love to get a tighter packing, but as it
> currently stands, I do not think 5% resulting packsize reduction
> warrants making 100% slower operation the default.

Agreed.  Please just drop that one patch for now.

I'll rework the hash limiting patch so the 16-byte block version behaves 
better with the large 20MB files.


Nicolas
