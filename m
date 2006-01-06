From: Junio C Hamano <junkio@cox.net>
Subject: Re: trivial: remove the dots at the end of file names
Date: Fri, 06 Jan 2006 14:37:24 -0800
Message-ID: <7vu0chrniz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050346v43dc1e58k7e0b51c6d6817d1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Dk-0007b1-6x
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWAFWh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWAFWhz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:27530 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964862AbWAFWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223458.SGWZ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:34:58 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14217>

Alex Riesen <raa.lkml@gmail.com> writes:

> Subject: [PATCH] Remove the dots at the end of file names
> to make the output more mouse copy-paste friendly.

> -		echo "ERROR: Merge conflict in $4."
> +		echo "ERROR: Merge conflict in $4"

Hmph.  I think there are places we state pathname within 'single
quotes' as a part of sentence, which may have the same issue.  I
understand and am sympathetic to the motivation, but at the same
time messages that do not end with full-stop somehow make me
feel quite uneasy. I'll swallow the patch; maybe it is just me.
