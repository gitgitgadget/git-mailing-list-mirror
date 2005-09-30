From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Thu, 29 Sep 2005 22:46:39 -0700
Message-ID: <7vek779kg0.fsf@assigned-by-dhcp.cox.net>
References: <1128026765.24397.46.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 07:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELDjg-0004io-TJ
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 07:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVI3Fqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 01:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVI3Fqp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 01:46:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:44162 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751361AbVI3Fqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 01:46:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930054640.LTQY9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 01:46:40 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1128026765.24397.46.camel@dv> (Pavel Roskin's message of "Thu,
	29 Sep 2005 16:46:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9536>

Pavel Roskin <proski@gnu.org> writes:

> +# explicitly what architecture to check for.
> +SPARSE = sparse
> +SPARSE_FLAGS = -D__$(shell uname -i)__

        : siamese; uname --version
        uname (coreutils) 5.2.1
        Written by David MacKenzie.

        Copyright (C) 2004 Free Software Foundation, Inc.
        This is free software; see the source for copying conditions.
        There is NO
        warranty; not even for MERCHANTABILITY or FITNESS FOR A
        PARTICULAR PURPOSE.
        : siamese; uname -i
        Try `uname --help' for more information.

Better alternatives?
