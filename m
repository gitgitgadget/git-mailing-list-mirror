From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 02:01:41 -0700
Message-ID: <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net>
References: <20050509233904.GB878@osuosl.org>
	<pan.2005.05.10.03.41.15.683163@smurf.noris.de>
	<428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de>
	<20050510080445.GB8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 10:54:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQVS-0002q0-Px
	for gcvg-git@gmane.org; Tue, 10 May 2005 10:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVEJJBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 05:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVEJJBo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 05:01:44 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42375 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261572AbVEJJBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 05:01:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510090141.FJAL12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 05:01:41 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050510080445.GB8176@lug-owl.de> (Jan-Benedict Glaw's message
 of "Tue, 10 May 2005 10:04:45 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JBG" == Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

>> find * \( -type f -o tyle l \) -print0 | ...

JBG> Btw, this won't find dot files, so using "." as the path list (instead
JBG> of "*") might be wise...

Huh?  Since when GIT started managing paths whose _any_ of their
path component starts with a dot?

