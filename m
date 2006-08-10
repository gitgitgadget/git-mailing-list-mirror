From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recur status
Date: Thu, 10 Aug 2006 01:03:20 -0700
Message-ID: <7vwt9hvwzb.fsf@assigned-by-dhcp.cox.net>
References: <20060810062914.GA5192@c165.ib.student.liu.se>
	<Pine.LNX.4.63.0608100949250.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:03:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5Vm-0008AP-UT
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWHJIDX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWHJIDX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:03:23 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39899 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161067AbWHJIDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 04:03:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810080321.JDKI6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 04:03:21 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608100949250.13885@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 10 Aug 2006 09:54:55 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25165>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> P.S.: Pavel, thanks for the "A dedicated programmer with good C and Python 
> skills could rewrite git-merge-recursive.py in C in 2 days, I believe. Add 
> a few days of bug fixing, of course." underestimation. I do not know if I 
> had started fiddling with it if I had known how involved it is.

It indeed _is_ involved, and not just C vs Python but the latter
being able to rely on multiple processes without worrying about
state clean-ups.

I am quite impressed by and happy with the merge-recur work.
