From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add suggestion to hard-to-understand error message
Date: Thu, 22 Dec 2005 11:27:32 -0800
Message-ID: <7vek45lyor.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net> <43AA79EB.6040800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 20:27:42 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpW6C-00023J-QS
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 20:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVLVT1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 14:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVLVT1e
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 14:27:34 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44497 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030276AbVLVT1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 14:27:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222192735.DZAS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 14:27:35 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13963>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> In a sense, both are "pull first?" situation, and it probably is
>> more confusing to give different messages to the user in these
>> two cases.  From the end-user point of view they are the same
>> "remote is not strict subset.".
>
> In non-git'ish, does this mean "you're not up to date, so pull before 
> pushing" ? If so, why not say so? I'm sure it could prevent a fair few 
> problems for users (not least those new to scm's).

Perhaps.  I was suggesting to say that in *both* places, not
just one.
