From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Fix git-verify-tag for local tags
Date: Sun, 09 Oct 2005 12:29:43 -0700
Message-ID: <7vk6gmebfc.fsf@assigned-by-dhcp.cox.net>
References: <20051009181246.17885.81654.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 09 21:33:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOgrk-0004GH-5P
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 21:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVJIT3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 15:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVJIT3p
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 15:29:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46730 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932259AbVJIT3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 15:29:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051009192931.GGLE29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Oct 2005 15:29:31 -0400
To: git@vger.kernel.org
In-Reply-To: <20051009181246.17885.81654.stgit@zion.home.lan> (Paolo
	Giarrusso's message of "Sun, 09 Oct 2005 20:12:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9870>

Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> It currently exits printing "git-cat-file SHA1: bad file", while instead we must
> just abort the verification for local tags (i.e. referring to commit objects).

Good spotting, but checking for type being not a tag (not
limited to commit object) would be a better approach.  I'll fix
it up that way and apply (no need to resend).  Thanks.
