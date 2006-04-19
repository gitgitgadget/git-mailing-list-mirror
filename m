From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 17:27:07 -0700
Message-ID: <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 02:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0XJ-0002UD-5c
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDSA1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDSA1J
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:27:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12004 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750788AbWDSA1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 20:27:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419002708.FYYL24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 20:27:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 16:45:16 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18892>

Linus Torvalds <torvalds@osdl.org> writes:

> [ NOTE! The reason I put "RFC" in the subject rather than "PATCH" is that 
>   I'm not 100% sure this isn't just a "shiny object" of mine rather than a 
>   really useful thing to do. What do people think? Have you ever wanted to 
>   access individual files in some random revision? Do you think this is 
>   useful? I think it's cool and _may_ be useful, but I'm not going to 
>   really push this patch. Consider it a throw-away patch unless somebody 
>   else finds it intriguing enough.. ]

Yes, I wanted to do this myself for a while.  The only issue I
might have is what the separator character between rev and path
should be.
