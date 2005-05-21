From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] - Convert git-checkout-cache to argp
Date: Sat, 21 May 2005 14:24:59 -0700
Message-ID: <7v7jhsgtlg.fsf@assigned-by-dhcp.cox.net>
References: <2242.10.10.10.24.1116700408.squirrel@linux1>
	<428FA5C3.6010900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 23:25:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZbS9-0001xj-Vb
	for gcvg-git@gmane.org; Sat, 21 May 2005 23:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEUVZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVEUVZH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 17:25:07 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34713 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261615AbVEUVZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 17:25:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521212500.GBTR12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 17:25:00 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <428FA5C3.6010900@pobox.com> (Jeff Garzik's message of "Sat, 21
 May 2005 17:18:59 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> Sean wrote:
>> Use argp to process command line arguments for git-checkout-cache.  Also,
>> fix things up so that the order of options on the command line no longer
>> matters.  To this end, the "-f" (--force) switch only applies to the
>> individual files given on the command line.   A new forcing version of the
>> "-a" (--all) switch is added as "-A" (--forceall).

JG> I agree with Junio -- this patch breaks stuff.

Yes, and that is exactly why I wanted to see the documentation
changes first before the code.

