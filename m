From: Nicolas Pitre <nico@cam.org>
Subject: Re: [FYI] pack idx format
Date: Wed, 15 Feb 2006 11:46:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602151144010.5606@localhost.localdomain>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 17:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Po1-0005wf-9F
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 17:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbWBOQq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 11:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWBOQq7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 11:46:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:6030 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1946013AbWBOQq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 11:46:59 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUQ00GA2MLYJTE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Feb 2006 11:46:46 -0500 (EST)
In-reply-to: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16246>

On Wed, 15 Feb 2006, Junio C Hamano wrote:

> This is still WIP but if anybody is interested...  Once done, it
> should become Documentation/technical/pack-format.txt.
> 
[...]
> 
> Pack file entry: <+
> 
>      packed object header:
> 	1-byte type (upper 4-bit)

Actually the type occupies only 3 bits (bits 4 to 6) as bit 7 is the 
size continuation bit.


Nicolas
