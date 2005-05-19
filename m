From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 14:29:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
 <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYpmP-0007XM-1Q
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVESSan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVESSan
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:30:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17751 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261212AbVESSai
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:30:38 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGR00AIQ21MMH@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 14:29:46 -0400 (EDT)
In-reply-to: <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Junio C Hamano wrote:

>  - the command line interface "-M" to read "-M" or "-M[0-9]"
>    (one digit); -M defaults to -M5 and give the cut-off point at
>    similarity score 5000, -M9 at 9000, etc.

Why not a fractional value instead?  -M1 is 100% the same while -M.95 
allows for some 5% changes.

This is clear and not based on some arbitrary level values.

>  - I have been assuming that diff_delta uses its two input
>    read-only but have not verified that myself yet.

It does.


Nicolas
