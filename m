From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 08 May 2005 14:35:23 -0700
Message-ID: <7vu0ld4d0k.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505081713070.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Tokarev <mjt@tls.msk.ru>, jdow <jdow@earthlink.net>,
	James Purser <purserj@ksit.dynalias.com>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:29:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtKL-00088h-MV
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVEHVfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVEHVfa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:35:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3047 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262969AbVEHVfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 17:35:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508213523.JYM22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 17:35:23 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505081713070.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Sun, 8 May 2005 17:16:21 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Sun, 8 May 2005, Junio C Hamano wrote:
>> 
MT> As I already said, deflate() in this case does only ONE iteration.
MT> stream.avail_in is NOT changed in the loop (except of the deflate()
MT> itself, where it will be set to 0 - provided out buffer have enouth
MT> room)....
>> 
>> Just a stupid question, but what happens when we do not have
>> enough room in the buffer?

DB> We must have enough room; we sized the buffer with deflateBound to fit the
DB> worst case.

Thanks for the explanation.  Then do we still need to express it
as a while loop?


