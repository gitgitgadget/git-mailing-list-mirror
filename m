From: Junio C Hamano <junkio@cox.net>
Subject: Re: Real-life kernel debugging scenario
Date: Mon, 07 Nov 2005 17:30:18 -0800
Message-ID: <7vwtjkncyd.fsf@assigned-by-dhcp.cox.net>
References: <dkosr7$f4s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 02:31:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZIJs-0004Yl-Ou
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 02:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVKHBaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 20:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVKHBaV
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 20:30:21 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13206 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965098AbVKHBaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 20:30:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108012958.MMLP16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 20:29:58 -0500
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dkosr7$f4s$1@sea.gmane.org> (wa1ter@myrealbox.com's message of
	"Mon, 07 Nov 2005 16:51:50 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11300>

walt <wa1ter@myrealbox.com> writes:

> First:  is this an optimal tactic?

Not if you are a git user.

> Second:  how to back out individual commits using git or
> cogito?  I suppose this is already spelled out in the docs,
> but I invite everyone to point me to the relevant places
> in the docs that have escaped my attention so far.

git-bisect(1).
