From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow the Unix epoch to be a valid commit date
Date: Sun, 05 Jul 2009 12:27:47 -0700
Message-ID: <7vljn3hqvg.fsf@alter.siamese.dyndns.org>
References: <sbqo45dgejpcnt58cam2tfkeon4is2v4ur@4ax.com>
	<20090703042846.GA14767@dcvr.yhbt.net>
	<20090703043454.GA20080@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, esskov@oncable.dk
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNXNT-0001YL-2r
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbZGET1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbZGET1q
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:27:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62368 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbZGET1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 15:27:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090705192748.HASX17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 5 Jul 2009 15:27:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id CKTn1c00B4aMwMQ03KTnid; Sun, 05 Jul 2009 15:27:47 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=u_1pwTsbef4A:10 a=Hbzmh3xeAAAA:8
 a=q_zKFOfhIgpHCpmWYigA:9 a=HvD2MqstHcyuKiWv59vRFFKQRPIA:4 a=BEwxGj72lFYA:10
X-CM-Score: 0.00
In-Reply-To: <20090703043454.GA20080@dcvr.yhbt.net> (Eric Wong's message of "Thu\, 2 Jul 2009 21\:34\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122753>

Eric Wong <normalperson@yhbt.net> writes:

> It is common practice to use the Unix epoch as a fallback date
> when a suitable date is not available.  This is true of git svn
> and possibly other importing tools that import non-git history
> into git.
>
> Instead of clobbering established strtoul() error reporting
> semantics with our own, preserve the strtoul() error value
> of ULONG_MAX for fsck.c to handle.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

Makes sense.  Will queue.

Thanks.
