From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 12:09:06 -0700
Message-ID: <7vejvwjp2l.fsf@assigned-by-dhcp.cox.net>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
	<eb0554$1pu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 21:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G952n-0005OA-92
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWHDTJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWHDTJJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:09:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:65456 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161332AbWHDTJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 15:09:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804190907.HNNZ12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 15:09:07 -0400
To: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <eb0554$1pu$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	04 Aug 2006 20:55:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24823>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>>   - Ramsay Allan Jones has introduced "NO_C99_FORMAT" Makefile
>>     variable to help running things with a C library that does
>>     not support %zu and %td format.  This would be a good target
>>     for autoconf work by Jakub (hint hint).
>
> See [PATCH 2/4] in this thread (introductory message somehow got lost).
> Testing on system which doesn't have C99 format specifiers would be
> appreciated.

Running generated configure script on Cygwin just updated
reports NO_C99_FORMAT is needed.  This is consistent with what
Johannes confirmed.

Thanks, both.
