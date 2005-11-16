From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Give python a chance to find "backported" modules
Date: Tue, 15 Nov 2005 19:06:51 -0800
Message-ID: <7vveytcmus.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511160331150.15130@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 04:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcDdQ-0006dL-PT
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVKPDGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKPDGy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:06:54 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18060 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965195AbVKPDGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:06:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116030543.YERZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 22:05:43 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511160331150.15130@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 03:33:44 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11995>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> python 2.2.1 is perfectly capable of executing git-merge-recursive,
> provided that it finds heapq and sets. All you have to do is to steal
> heapq.py and sets.py from python 2.3 or newer, and drop them in your
> GIT_PYTHON_PATH. 

Fair enough.  But I do not think we would want to go further
than this.  Especially, shipping a copy of heapq and sets like
we did for subprocess.

Thanks anyway.
