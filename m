From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: use UTF-8 encoding
Date: Wed, 05 Oct 2005 21:19:46 -0700
Message-ID: <7vvf0b9t0d.fsf@assigned-by-dhcp.cox.net>
References: <1128564768.32103.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 06:22:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENNEx-0007gb-RM
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 06:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVJFEUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJFEUP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 00:20:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57077 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751220AbVJFEUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 00:20:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006041938.CEKC29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 00:19:38 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1128564768.32103.18.camel@dv> (Pavel Roskin's message of "Wed,
	05 Oct 2005 22:12:48 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9760>

Pavel Roskin <proski@gnu.org> writes:

> gitk should try to use UTF-8 encoding for system operations, such as
> reading and writing files and git output.

I agree about commit messages, but I am not so sure about the
file contents (aka user data).  Is it possible to control them
separately?
