From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 13:33:47 -0800
Message-ID: <7vpsotofd0.fsf@assigned-by-dhcp.cox.net>
References: <87hda61a80.fsf@gmail.com>
	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
	<7vacfxrdao.fsf@assigned-by-dhcp.cox.net> <438235AA.8070805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:36:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJIP-00071F-0w
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKUVdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKUVdt
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:33:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44777 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750750AbVKUVdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:33:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121213250.EBBH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 16:32:50 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <438235AA.8070805@zytor.com> (H. Peter Anvin's message of "Mon,
	21 Nov 2005 13:01:30 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12486>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Any reason we can't make it take an actual decimal number, like -M1.0 or 
> -M0.345?  It seems odd and annoying to invent our own notation for 
> floating-point numbers, especially in userspace.

No reason we "can't".  About we "don't", inertia and nothing
else.  It happened around this time.

	http://marc.theaimsgroup.com/?l=git&m=111654149421574

We could in addition to take 0 <= x <= 1 decimal number and that
should be a simple patch to diff.c::parse_num().
