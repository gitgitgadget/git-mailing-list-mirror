From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 14:00:09 -0800
Message-ID: <7vd5ktoe52.fsf@assigned-by-dhcp.cox.net>
References: <87hda61a80.fsf@gmail.com>
	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
	<7vacfxrdao.fsf@assigned-by-dhcp.cox.net> <438235AA.8070805@zytor.com>
	<7vpsotofd0.fsf@assigned-by-dhcp.cox.net> <43823E31.2050500@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJi0-0001Yw-HM
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVKUWAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKUWAM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:00:12 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39808 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751110AbVKUWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 17:00:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121215912.EQXM17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 16:59:12 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43823E31.2050500@zytor.com> (H. Peter Anvin's message of "Mon,
	21 Nov 2005 13:37:53 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12494>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Okay, in that post Linus suggests that -M without an argument should be 
> == 100% (1.0), thus avoiding having to mess up the meaning of -M100 as 
> 0.100.  It seems like a really odd thing to have -M100 mean something 
> that's completely out of line with the rest of the meaning.

True, but it might be too late to change that; I suspect people
expect -M to do a bit more than pure renames by now.
