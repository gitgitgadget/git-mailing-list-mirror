From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] - Convert git-checkout-cache to argp
Date: Sat, 21 May 2005 12:57:10 -0700
Message-ID: <7voeb4gxnt.fsf@assigned-by-dhcp.cox.net>
References: <2242.10.10.10.24.1116700408.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 21:56:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZa4u-0003Xv-5B
	for gcvg-git@gmane.org; Sat, 21 May 2005 21:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEUT5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 15:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEUT5P
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 15:57:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58539 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261437AbVEUT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 15:57:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521195711.SLCM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 15:57:11 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <2242.10.10.10.24.1116700408.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Sat, 21 May 2005 14:33:28 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:

S> Use argp to process command line arguments for git-checkout-cache.  Also,
S> fix things up so that the order of options on the command line no longer
S> matters.  To this end, the "-f" (--force) switch only applies to the
S> individual files given on the command line.   A new forcing version of the
S> "-a" (--all) switch is added as "-A" (--forceall).

I do not like that change at all.  That would break existing
scripts.

Why not just say --force forces checkout even when it is used
with -a?  I do not think anybody sane uses "-a -f" in their
existing scripts nor from the command line.



