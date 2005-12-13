From: Junio C Hamano <junkio@cox.net>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 19:23:48 -0800
Message-ID: <7v8xupd6ij.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
	<7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
	<7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
	<7vek4igevq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
	<7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
	<Pine.LNX.4.64.0512121758410.15597@g5.osdl.org>
	<Pine.LNX.4.64.0512122114090.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 04:25:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em0le-0001Dc-GZ
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 04:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVLMDXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 22:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVLMDXv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 22:23:51 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46547 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932401AbVLMDXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 22:23:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213032353.RSNA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 22:23:53 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0512122114090.26663@localhost.localdomain>
	(Nicolas Pitre's message of "Mon, 12 Dec 2005 21:45:16 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13566>

Nicolas Pitre <nico@cam.org> writes:

> However I added the possibility for (1) to use the destination file as 
> well as the "source" file for block copy in patch_delta().

Ah, I've been wondering where that one came from.
