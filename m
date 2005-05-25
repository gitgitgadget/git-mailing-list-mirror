From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-cache: allow dot-files
Date: Tue, 24 May 2005 17:32:37 -0700
Message-ID: <7v8y24taai.fsf@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:31:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dajne-0003l5-Pk
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVEYAcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVEYAcm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:32:42 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42736 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262211AbVEYAci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:32:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525003236.IGWT22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:32:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 17:24:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I considered it, but it's so much easier to allow things
LT> later than deny them, that I preferred being anal about it.

That is not the point.  GIT_DIR set to "GIT" would happily suck
index file in.  You are not being anal enough.

