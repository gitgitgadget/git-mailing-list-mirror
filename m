From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch -d <branch>: delete unused branch.
Date: Wed, 14 Sep 2005 09:15:19 -0700
Message-ID: <7vd5nbpqw8.fsf@assigned-by-dhcp.cox.net>
References: <4326F2AE.50108@citi.umich.edu>
	<7vvf14ox39.fsf@assigned-by-dhcp.cox.net>
	<432839B6.2070103@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 18:15:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZuu-00074z-Eh
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVINQPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVINQPW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:15:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43713 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030225AbVINQPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 12:15:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914161521.KIQK24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 12:15:21 -0400
To: cel@citi.umich.edu
In-Reply-To: <432839B6.2070103@citi.umich.edu> (Chuck Lever's message of "Wed,
	14 Sep 2005 10:54:46 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8535>

Chuck Lever <cel@citi.umich.edu> writes:

> what if you want to throw away work in a branch even if it's not merged? 
>  doesn't the safety check prevent that?

Yes.  And you would get instructions on what to do from the
command upon refusal.
