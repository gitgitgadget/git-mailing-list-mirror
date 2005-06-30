From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base)
Date: Wed, 29 Jun 2005 17:11:23 -0700
Message-ID: <7v1x6k1z6c.fsf@assigned-by-dhcp.cox.net>
References: <20050629234533.28709.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 02:04:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnmXL-0004ow-JL
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 02:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVF3AL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVF3AL3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 20:11:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29873 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262744AbVF3ALZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 20:11:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630001124.YJMY1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 20:11:24 -0400
To: Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <20050629234533.28709.qmail@blackcubes.dyndns.org> (Jon Seymour's message of "Thu, 30 Jun 2005 09:45:33 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

I am puzzled about this part.

JS> The unit test changes in this patch remove use of the --show-breaks 
JS> flags from certain unit tests. The changed --merge-order behaviour 
JS> changed the annotation that --show-breaks prints for certain test cases. 
JS> The new behaviour is reasonable and irrelevant to the intent of the tests
JS> so that tests have been changed to eliminate the spurious behaviour.

If the behaviour of --show-breaks subtly changes, and if that
changed behaviour is something still acceptable, why not update
the test to show the new expected results since you are updating
the test anyway?

Showing that "subtle" change in the diff may draw people's
attention and would help you to verify that the behaviour change
is not something that would be unacceptable to them.

Also if you are changing t6001, could you also merge Mark
Allen's BSD portability fix while you are at it?

    Message-ID: <20050628014337.18986.qmail@web41205.mail.yahoo.com>
