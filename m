From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make tests more portable
Date: Tue, 24 May 2005 22:11:44 -0700
Message-ID: <7vis17opnz.fsf@assigned-by-dhcp.cox.net>
References: <20050525045229.29706.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 07:10:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dao9p-0001mJ-Vs
	for gcvg-git@gmane.org; Wed, 25 May 2005 07:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVEYFLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 01:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVEYFLx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 01:11:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40918 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262304AbVEYFLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 01:11:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525051144.LZRQ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 01:11:44 -0400
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050525045229.29706.qmail@web41205.mail.yahoo.com> (Mark
 Allen's message of "Tue, 24 May 2005 21:52:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MA" == Mark Allen <mrallen1@yahoo.com> writes:

MA> I made some minor changes to the test suite to make the
MA> tests more portable.  The sed on Darwin doesn't understand
MA> extended regex, cmp won't read from '-', and xargs doesn't
MA> have an '-r' command line flag.

Thank you for doing this.

MA> The t3000 test was broken because it wasn't updated when
MA> Linus merged Junio's patch to make git-ls-files show
MA> filenames with leading dots.  I fixed that with a trivial
MA> addition.

Not updating the tests to match code was my fault, not Linus.
Thanks again for the fix.


