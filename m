From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use core.sharedrepository consistently.
Date: Sat, 04 Mar 2006 15:38:39 -0800
Message-ID: <7vhd6dpyps.fsf@assigned-by-dhcp.cox.net>
References: <20060304230557.GB28469@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 00:38:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFgKp-0005KX-NG
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 00:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCDXil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 18:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCDXil
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 18:38:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37603 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751345AbWCDXik (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 18:38:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304233658.PBVH6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 18:36:58 -0500
To: "Fernando J. Pereda" <ferdy@gentoo.org>
In-Reply-To: <20060304230557.GB28469@ferdyx.org> (Fernando J. Pereda's message
	of "Sun, 5 Mar 2006 00:05:57 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17199>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> 'git init-db --shared' sets 'core.sharedRepository' but in
> setup.c 'core.sharedrepository' is checked instead.

I thought they were case insensitive..
