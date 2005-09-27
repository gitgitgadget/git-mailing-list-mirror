From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Tue, 27 Sep 2005 09:07:41 -0700
Message-ID: <20050927160740.GB1377@reactrix.com>
References: <20050926175211.GD9410@reactrix.com> <7v4q87ed73.fsf@assigned-by-dhcp.cox.net> <20050927001241.GB15615@reactrix.com> <7v3bnr3vo5.fsf@assigned-by-dhcp.cox.net> <7vpsqv2g3p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 18:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKHzx-0007qz-FW
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 18:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVI0QH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 12:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVI0QH6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 12:07:58 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:13537 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964996AbVI0QH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 12:07:57 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8RG7fJ4003166;
	Tue, 27 Sep 2005 09:07:41 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8RG7f92003164;
	Tue, 27 Sep 2005 09:07:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsqv2g3p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9402>

On Mon, Sep 26, 2005 at 11:13:14PM -0700, Junio C Hamano wrote:

> ... so the patch still needed some fixups.  It had minor
> dependencies on the previous patches in the series as well, so I
> tried to fix them up myself.
> 
> Could you take a look at it and see if the following is good
> enough, please?

Looks great, thanks.

> ------------
> Subject: [PATCH] Return CURL error message when object transfer fails
> From: Nick Hengeveld <nickh@reactrix.com>
> Date: 1127757131 -0700
> 
> Return CURL error message when object transfer fails
> 
> [jc: added similar curl_errorstr errors to places where we
>  use curl_easy_perform() to run fetch that _must_ succeed.]
> 
> Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
