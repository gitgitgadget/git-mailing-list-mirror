From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-stripspace breakage
Date: Fri, 14 Apr 2006 12:13:11 -0700
Message-ID: <7v1ww0q8c8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604140936520.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 14 21:13:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUTjN-0004oq-9z
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 21:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWDNTNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWDNTNS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 15:13:18 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28336 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751420AbWDNTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 15:13:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414191317.DYKI14494.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 15:13:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604140936520.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 14 Apr 2006 09:40:03 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18696>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio,
>  the current git-stripspace leaves extra newlines at the end, causing ugly 
> commit logs in "git log". I assume/suspect that it's the recent 
> "incomplete line" handling (that I acked, bad me), but I didn't actually 
> test.

Bad me too indeed.  I noticed it last night after writing
"What's in" message.  Will fix shortly.

Thanks.
