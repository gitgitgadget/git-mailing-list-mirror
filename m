From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Wed, 22 Feb 2006 10:26:43 -0800
Message-ID: <7vpslfntb0.fsf@assigned-by-dhcp.cox.net>
References: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 19:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FByhl-00021c-5m
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 19:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWBVS0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWBVS0q
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 13:26:46 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17553 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751139AbWBVS0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 13:26:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222182533.HBC3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 13:25:33 -0500
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
In-Reply-To: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
	(Andrew Vasquez's message of "Wed, 22 Feb 2006 10:17:58 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16604>

Andrew Vasquez <andrew.vasquez@qlogic.com> writes:

> Commit:
>
> 	b5b16990f8b074bd0481ced047b8f8bf66eee6dc
> 	Prevent git-upload-pack segfault if object cannot be found
>
> is causing some really annoying noise being sent to stderr on some of
> my older non-packed repositories:
>...
> Could we drop this fprintf to stderr?

Thanks for noticing.
