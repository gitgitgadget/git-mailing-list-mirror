From: Junio C Hamano <junkio@cox.net>
Subject: Re: tool to diff cache <-> working directory
Date: Thu, 05 May 2005 19:48:49 -0700
Message-ID: <7vy8atdq7i.fsf@assigned-by-dhcp.cox.net>
References: <20050506002347.GU20994@cip.informatik.uni-erlangen.de>
	<7vhdhhf88u.fsf@assigned-by-dhcp.cox.net>
	<20050506020759.GA11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 04:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTsn7-0000SX-Rv
	for gcvg-git@gmane.org; Fri, 06 May 2005 04:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVEFCsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 22:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEFCsz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 22:48:55 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22733 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262195AbVEFCsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 22:48:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506024850.RKAF1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 5 May 2005 22:48:50 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050506020759.GA11506@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Fri, 6 May 2005 04:07:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> I thought there would be no cache<->working directory delta generation.
TG> And I need a way to see if there are unchecked-in deltas in the working
TG> tree. So I thought about looking at the 'git-diff-cache --cached tree1'
TG> and comparing it with the self generated SHAs of the working tree. But
TG> now, that there is such a tool, I am perfectly fine.

Are you using pure GIT, without any Porcelain layer like Cogito?

Cogito has "cg-status" that shows something like "cvs -n update"
output.

My (shameless plug ;-) JIT [*1*] also has "jit-status".

[References]
*1* http://members.cox.net/junkio/

