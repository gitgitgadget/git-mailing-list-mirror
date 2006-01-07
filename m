From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 13:12:13 -0800
Message-ID: <7vlkxreo9e.fsf@assigned-by-dhcp.cox.net>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net>
	<7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net> <43C028CA.8090702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 22:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvLMJ-0002N3-Ci
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 22:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbWAGVMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWAGVMP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 16:12:15 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20471 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752583AbWAGVMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 16:12:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107211025.ECUY17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 16:10:25 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43C028CA.8090702@zytor.com> (H. Peter Anvin's message of "Sat,
	07 Jan 2006 12:47:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14277>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Any reason to not just do:
>
>  	struct frotz {
>  		int xyzzy;
>  		char nitfol[1]; /* more */
>  	};
>
> ... which should work on all compilers?

Laziness, especially to avoid having to deal with comments like
"your xmalloc(sizeof(struct frotz) + strlen(nitfol) + 1) should be
xmalloc(sizeof(struct frotz) + strlen(nitfol)), because you
have already one byte for nitfol element."
