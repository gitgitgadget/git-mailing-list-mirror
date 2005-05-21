From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 18:43:25 -0700
Message-ID: <7vzmuppd4y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505202113500.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:42:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZJ0Z-0005ul-AN
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVEUBnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEUBna
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:43:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33974 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261630AbVEUBn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 21:43:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521014327.YIRA12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 21:43:27 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505202113500.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 20 May 2005 21:16:22 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Junio was stripping the filename (not whitespace) from wc, not knowing
DB> that it could be suppressed by using stdin.

Actually the reason I did so initially was because I recalled
seeing a wc that said "-" instead of omitting the filename.  I
do not have access to those obscure Unixen so I cannot these
things easily anymore, though.

DB> of wc that put whitespace at the beginning. I think the
DB> sed-only solution is far more obscure and no cleaner than
DB> cat and wc.

This I tend to agree, but that is probably one of the most
portable.

