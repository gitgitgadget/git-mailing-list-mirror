From: Junio C Hamano <junkio@cox.net>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 12:25:01 -0800
Message-ID: <7vd5l07336.fsf@assigned-by-dhcp.cox.net>
References: <437B6997.8010903@mc.com>
	<7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 21:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTqF-0005ge-4E
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVKPUZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbVKPUZF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:25:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48020 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030482AbVKPUZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:25:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116202409.MPZA17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 15:24:09 -0500
To: git@vger.kernel.org
In-Reply-To: <437B8CEC.8040002@mc.com> (Andrew Wozniak's message of "Wed, 16
	Nov 2005 14:47:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12052>

Andrew Wozniak <awozniak@mc.com> writes:

> Unfortunately, now there are other failures:
> ...
> I grep'd for these defines and they are nowhere to be found!  Is some 
> other package needed to resolve these undefines on my RH7.2 build host?

Probably.  Maybe you can look at INSTALL and report missing
dependencies?  Also the top of the Makefile (huge ugly comment
section).
