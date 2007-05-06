From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff: release blobs after generating textual diff.
Date: Sun, 06 May 2007 13:03:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705061301190.24220@xanadu.home>
References: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 19:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkk94-0004OF-MQ
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbXEFRDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXEFRDe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:03:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbXEFRDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 13:03:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHM0011EQ1PMF10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 May 2007 13:03:25 -0400 (EDT)
In-reply-to: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46347>

On Sun, 6 May 2007, Junio C Hamano wrote:

> This reduces the memory pressure when dealing with many paths.
> 
> An unscientific test of running "diff-tree --stat --summary -M"
> between v2.6.19 and v2.6.20-rc1 in the linux kernel repository
> indicates that the number of minor faults are reduced by 2/3
> (153k vs 49k).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * This is still a WIP, not in the sense that it breaks anything
>    (it doesn't seem to), but in the sense that it is not known
>    if it is useful in general and would make that much of a
>    difference with a project much larger than the kernel.

This can only be good.  People are really starting to use Git with 
gigantic repos on limited memory hardware.


Nicolas
