From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to restore the original head after `git-reset --hard master^`
Date: Tue, 11 Oct 2005 14:37:40 -0700
Message-ID: <7vpsqbspjv.fsf@assigned-by-dhcp.cox.net>
References: <434BD65A.9000108@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 23:39:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPRof-00081K-9m
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 23:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJKVhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVJKVhm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 17:37:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8592 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751123AbVJKVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 17:37:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011213730.RKPI4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 17:37:30 -0400
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <434BD65A.9000108@ust.hk> (Ben Lau's message of "Tue, 11 Oct 2005
	23:12:26 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9987>

Ben Lau <benlau@ust.hk> writes:

>   After involves the command `git-reset --hard master^` in a 
> repository, the working
> tree , current head and index are restored to the parent of master. That 
> includes
> the content of '.git/refs/head/master'. Although the original commit 
> object is still existed
> , I couldn't find it back.

I think you can find it in .git/ORIG_HEAD.
